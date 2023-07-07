defmodule UseBase.Infrastructure.Dictionary do
  import UseBase.UseBaseMacro

  usebase(
    %{
      base: UseBase.Domain.IBook,
      attributes: %{
        authors: ['-', :dan, ['-', '-', :y, %{person: %{name: ""}}]],
        page: %{
          height: 60,
          weight: 30
        }
      }
    }
  )

  defmacro __using__(_opts) do
    lm = __MODULE__
    quote do
      defdelegate get_name(data), to: unquote(lm), as: :get_name
      defdelegate get_price(data), to: unquote(lm), as: :get_price

      # Private function
      # defdelegate get_stock(data), to: unquote(lm), as: :get_stock
      # defdelegate get_stock(data), to: unquote(lm), as: :get_stock

      defoverridable [get_name: 1]
    end
  end

  # Override base function.
  def get_name(%__MODULE__{} = data) do
    "Dictionary module: " <> data.name <> " || " <> super(data)
  end
  def get_name(%{__b__: l} = data) do
    with(
      true <- __MODULE__ in l
    ) do
      "Dictionary base: #{data.page.height} || #{super(data)}"
    else
      false -> "#{__MODULE__} isn't an ancestral of #{data}."
    end
  end

  # Don't override base function.
  def get_price(%__MODULE__{}) do
    :incorrect_value
  end

  # Use base function.
  def get_dictionary_price(%__MODULE__{__b__: [base | _]} = data) do
    "Dictionary module: #{base.get_price(data)}"
  end

  # Use base function.
  def get_dictionary_stock(%__MODULE__{__b__: [base | _]} = data) do
    "Dictionary module: #{base.get_total_stock(data)}"
  end
end
