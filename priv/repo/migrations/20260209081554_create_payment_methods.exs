defmodule Isupayx.Repo.Migrations.CreatePaymentMethods do
  use Ecto.Migration

  def change do
    create table(:payment_methods, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string, null: false
      add :code, :string, null: false

      add :min_amount, :decimal, null: false
      add :max_amount, :decimal, null: false

      add :is_active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:payment_methods, [:code])
  end
end
