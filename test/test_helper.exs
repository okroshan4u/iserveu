ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Isupayx.Repo, :manual)

Code.require_file("support/test_data_seeder.exs", __DIR__)
