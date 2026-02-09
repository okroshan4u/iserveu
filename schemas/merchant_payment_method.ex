defmodule Isupayx.Schemas.MerchantPaymentMethod do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "merchant_payment_methods" do
    belongs_to :merchant, Isupayx.Schemas.Merchant
    belongs_to :payment_method, Isupayx.Schemas.PaymentMethod

    field :min_amount, :decimal
    field :max_amount, :decimal
    field :daily_limit, :decimal

    field :is_active, :boolean, default: true

    timestamps()
  end

  def changeset(mpm, attrs) do
    mpm
    |> cast(attrs, [
      :merchant_id,
      :payment_method_id,
      :min_amount,
      :max_amount,
      :daily_limit,
      :is_active
    ])
    |> validate_required([
      :merchant_id,
      :payment_method_id,
      :min_amount,
      :max_amount
    ])
    |> unique_constraint([:merchant_id, :payment_method_id])
  end
end
