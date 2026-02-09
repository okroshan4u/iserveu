defmodule IsupayxWeb.TransactionController do
  use IsupayxWeb, :controller

  alias Isupayx.Repo
  alias Isupayx.Schemas.{Merchant, PaymentMethod, MerchantPaymentMethod, Transaction}
  alias Isupayx.Events.TransactionEvents

  alias Isupayx.Validation.{
    SchemaLayer,
    EntityLayer,
    BusinessLayer,
    ComplianceLayer,
    RiskLayer
  }

  # =======================
  # PUBLIC ACTION
  # =======================
  def create(conn, params) do
    with {:ok, api_key} <- fetch_api_key(conn),
         {:ok, merchant} <- fetch_merchant(api_key),
         {:ok, idempotency_key} <- fetch_idempotency_key(conn),
         {:ok, nil} <- find_existing_txn(merchant, idempotency_key),
         {:ok, method} <- fetch_payment_method(params),
         :ok <- SchemaLayer.validate(params),
         :ok <- EntityLayer.validate(%{merchant: merchant, payment_method: method}),
         {:ok, method_config} <- fetch_method_config(merchant, method),
         :ok <-
           BusinessLayer.validate(%{
             amount: params["amount"],
             method_config: method_config
           }),
         {:ok, compliance_flags} <- ComplianceLayer.check(%{amount: params["amount"]}),
         :ok <- RiskLayer.check(%{}) do
      txn =
        %Transaction{}
        |> Transaction.changeset(%{
          amount: params["amount"],
          currency: params["currency"],
          status: :processing,
          reference_id: params["reference_id"],
          customer_email: get_in(params, ["customer", "email"]),
          customer_phone: get_in(params, ["customer", "phone"]),
          merchant_id: merchant.id,
          payment_method_id: method.id,
          idempotency_key: idempotency_key
        })
        |> Repo.insert!()

      TransactionEvents.transaction_created(txn)

      json(conn |> put_status(:created), %{
        success: true,
        data: %{
          transaction_id: txn.id,
          status: txn.status,
          amount: txn.amount,
          currency: txn.currency
        },
        metadata: %{
          compliance_flags: compliance_flags,
          timestamp: DateTime.utc_now()
        }
      })
    else
      {:error, {:idempotent_replay, txn}} ->
        json(conn, %{
          success: true,
          data: %{
            transaction_id: txn.id,
            status: txn.status,
            amount: txn.amount,
            currency: txn.currency
          },
          metadata: %{
            idempotent: true,
            timestamp: DateTime.utc_now()
          }
        })

      {:error, error} ->
        send_error(conn, error)

      :error ->
        send_error(conn, %{
          layer: "entity",
          code: "ENTITY_NOT_FOUND",
          message: "Invalid merchant or payment method",
          details: []
        })
    end
  end

  # =======================
  # PRIVATE HELPERS
  # =======================

  defp find_existing_txn(_merchant, nil), do: {:ok, nil}

  defp find_existing_txn(merchant, key) do
    case Repo.get_by(Transaction,
           merchant_id: merchant.id,
           idempotency_key: key
         ) do
      nil -> {:ok, nil}
      txn -> {:error, {:idempotent_replay, txn}}
    end
  end

  defp fetch_idempotency_key(conn) do
    case get_req_header(conn, "idempotency-key") do
      [key] -> {:ok, key}
      _ -> {:ok, nil}
    end
  end

  defp fetch_api_key(conn) do
    case get_req_header(conn, "x-api-key") do
      [key] -> {:ok, key}
      _ -> {:error, auth_error()}
    end
  end

  defp fetch_merchant(api_key) do
    case Repo.get_by(Merchant, api_key: api_key) do
      nil -> {:error, auth_error()}
      merchant -> {:ok, merchant}
    end
  end

  defp fetch_payment_method(%{"payment_method" => code}) do
    case Repo.get_by(PaymentMethod, code: code) do
      nil -> :error
      method -> {:ok, method}
    end
  end

  defp fetch_method_config(merchant, method) do
    case Repo.get_by(MerchantPaymentMethod,
           merchant_id: merchant.id,
           payment_method_id: method.id,
           is_active: true
         ) do
      nil -> :error
      config -> {:ok, config}
    end
  end

  defp auth_error do
    %{
      layer: "auth",
      code: "AUTH_INVALID_API_KEY",
      message: "Invalid or missing API key",
      details: []
    }
  end

  defp send_error(conn, error) do
    status =
      case error.layer do
        "schema" -> 400
        "auth" -> 401
        "entity" -> 403
        "business_rule" -> 422
        "risk" -> 429
        _ -> 500
      end

    conn
    |> put_status(status)
    |> json(%{
      success: false,
      error: error,
      metadata: %{
        timestamp: DateTime.utc_now()
      }
    })
  end
end
