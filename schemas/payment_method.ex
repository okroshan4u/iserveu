defmodule Isupayx.Schemas.PaymentMethod do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "payment_methods" do
    field :name, :string
    field :code, :string

    field :min_amount, :decimal
    field :max_amount, :decimal

    field :is_active, :boolean, default: true

    has_many :merchant_payment_methods, Isupayx.Schemas.MerchantPaymentMethod

    timestamps()
  end

  def changeset(method, attrs) do
    method
    |> cast(attrs, [:name, :code, :min_amount, :max_amount, :is_active])
    |> validate_required([:name, :code, :min_amount, :max_amount])
    |> unique_constraint(:code)
  end
end
