defmodule Isupayx.Schemas.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @states [:initiated, :processing, :captured, :failed, :settled]

  schema "transactions" do
    field :amount, :decimal
    field :currency, :string
    field :status, Ecto.Enum, values: @states
    field :reference_id, :string

    field :customer_email, :string
    field :customer_phone, :string

    belongs_to :merchant, Isupayx.Schemas.Merchant
    belongs_to :payment_method, Isupayx.Schemas.PaymentMethod

    timestamps()
  end

  def changeset(txn, attrs) do
    txn
    |> cast(attrs, [
      :amount,
      :currency,
      :status,
      :reference_id,
      :customer_email,
      :customer_phone,
      :merchant_id,
      :payment_method_id
    ])
    |> validate_required([
      :amount,
      :currency,
      :status,
      :merchant_id,
      :payment_method_id
    ])
    |> validate_number(:amount, greater_than: 0)
    |> validate_format(:customer_email, ~r/@/)
  end
end
