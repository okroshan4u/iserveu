defmodule Isupayx.Validation.ComplianceLayer do
  @threshold 200_000

  def check(%{amount: amount}) do
    if amount >= @threshold do
      {:ok, ["AMOUNT_REPORTING"]}
    else
      {:ok, []}
    end
  end
end
