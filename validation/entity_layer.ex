defmodule Isupayx.Validation.EntityLayer do
  alias Isupayx.{Repo}
  alias Isupayx.Schemas.{Merchant, PaymentMethod, MerchantPaymentMethod}

  def validate(%{merchant: merchant, payment_method: method}) do
    cond do
      merchant.onboarding_status != "activated" ->
        entity_error("ENTITY_MERCHANT_INACTIVE", "Merchant is not active")

      merchant.kyc_status not in ["verified", "approved"] ->
        entity_error("ENTITY_MERCHANT_KYC_INVALID", "Merchant KYC not approved")

      not method.is_active ->
        entity_error("ENTITY_PAYMENT_METHOD_INACTIVE", "Payment method inactive")

      Repo.get_by(MerchantPaymentMethod,
        merchant_id: merchant.id,
        payment_method_id: method.id,
        is_active: true
      ) == nil ->
        entity_error("ENTITY_MERCHANT_METHOD_INACTIVE", "Payment method not enabled for merchant")

      true ->
        :ok
    end
  end

  defp entity_error(code, message) do
    {:error,
     %{
       layer: "entity",
       code: code,
       message: message,
       details: []
     }}
  end
end
