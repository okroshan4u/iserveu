defmodule Isupayx.Validation.BusinessLayer do
  def validate(%{amount: amount, method_config: config}) do
    cond do
      amount < config.min_amount ->
        rule_error("RULE_AMOUNT_BELOW_MIN", "Amount below minimum")

      amount > config.max_amount ->
        rule_error("RULE_AMOUNT_ABOVE_MAX", "Amount above maximum")

      true ->
        :ok
    end
  end

  defp rule_error(code, message) do
    {:error,
     %{
       layer: "business_rule",
       code: code,
       message: message,
       details: []
     }}
  end
end
