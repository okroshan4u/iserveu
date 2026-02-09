defmodule Isupayx.Repo.Migrations.CreateMerchantPaymentMethods do
  use Ecto.Migration

  def change do
    create table(:merchant_payment_methods, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :merchant_id, references(:merchants, type: :binary_id), null: false
      add :payment_method_id, references(:payment_methods, type: :binary_id), null: false

      add :min_amount, :decimal, null: false
      add :max_amount, :decimal, null: false
      add :daily_limit, :decimal

      add :is_active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(
      :merchant_payment_methods,
      [:merchant_id, :payment_method_id],
      name: :merchant_payment_method_unique_idx
    )
  end
end
