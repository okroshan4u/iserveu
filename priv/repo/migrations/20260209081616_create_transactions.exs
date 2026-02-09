defmodule Isupayx.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :amount, :decimal, null: false
      add :currency, :string, null: false
      add :status, :string, null: false

      add :reference_id, :string

      add :customer_email, :string
      add :customer_phone, :string

      add :merchant_id, references(:merchants, type: :binary_id), null: false
      add :payment_method_id, references(:payment_methods, type: :binary_id), null: false

      timestamps()
    end

    create index(:transactions, [:merchant_id])
    create index(:transactions, [:payment_method_id])
  end
end
