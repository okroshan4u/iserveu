defmodule Isupayx.Validation.SchemaLayer do
  def validate(params) do
    required_fields = ["amount", "currency", "payment_method", "reference_id"]

    missing =
      required_fields
      |> Enum.filter(&(!Map.has_key?(params, &1)))

    if missing != [] do
      {:error,
       %{
         layer: "schema",
         code: "SCHEMA_MISSING_FIELD",
         message: "Required fields are missing",
         details: Enum.map(missing, &%{field: &1, rule: "required"})
       }}
    else
      amount = params["amount"]

      cond do
        not is_number(amount) ->
          schema_error("SCHEMA_INVALID_AMOUNT", "Amount must be a number")

        amount <= 0 ->
          schema_error("SCHEMA_INVALID_AMOUNT", "Amount must be greater than zero")

        true ->
          :ok
      end
    end
  end

  defp schema_error(code, message) do
    {:error,
     %{
       layer: "schema",
       code: code,
       message: message,
       details: []
     }}
  end
end
