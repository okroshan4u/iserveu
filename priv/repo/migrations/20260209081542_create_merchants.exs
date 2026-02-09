defmodule Isupayx.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string, null: false
      add :api_key, :string, null: false

      add :onboarding_status, :string, null: false
      add :kyc_status, :string, null: false

      add :is_active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:merchants, [:api_key])
  end
end
