defmodule Isupayx.Events.TransactionEvents do
  def transaction_created(txn) do
    Phoenix.PubSub.broadcast(
      Isupayx.PubSub,
      "transactions",
      {:transaction_created, txn}
    )
  end
end
