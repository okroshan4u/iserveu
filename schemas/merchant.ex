defmodule Isupayx.Schemas.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "merchants" do
    field :name, :string
    field :api_key, :string

    field :onboarding_status, :string
    field :kyc_status, :string

    field :is_active, :boolean, default: true

    has_many :transactions, Isupayx.Schemas.Transaction
    has_many :merchant_payment_methods, Isupayx.Schemas.MerchantPaymentMethod

    timestamps()
  end

  @doc "Merchant changeset with legacy + new KYC handling"
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [
      :name,
      :api_key,
      :onboarding_status,
      :kyc_status,
      :is_active
    ])
    |> validate_required([:name, :api_key, :onboarding_status, :kyc_status])
    |> validate_inclusion(
      :kyc_status,
      ["verified", "approved", "pending", "not_started", "review"]
    )
    |> unique_constraint(:api_key)
  end
end
