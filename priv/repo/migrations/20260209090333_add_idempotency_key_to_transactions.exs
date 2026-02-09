defmodule Isupayx.Repo.Migrations.AddIdempotencyKeyToTransactions do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :idempotency_key, :string
    end

    create unique_index(:transactions, [:merchant_id, :idempotency_key])
  end
end
