defmodule UseBase.Domain.IBook do
  defstruct(
    name: "",
    page: %{
      width: 20,
      height: 20,
      weight: %{
        libras: 0,
        kilogram: 0
      },
    },
    authors: [:show, :man, [:a, :b, :d, %{person: %{age: 0}}], :boi],
    price: 0.0,
    stock: 0
  )

  defmacro __using__(_opts) do
    lm = __MODULE__
    quote do
      defdelegate get_name(data), to: unquote(lm), as: :get_name
      defdelegate get_price(data), to: unquote(lm), as: :get_price

      # Private function
      # defdelegate get_stock(data), to: unquote(lm), as: :get_stock

      defoverridable [get_name: 1]
    end
  end

  # Public function.
  # Can be overridable.
  # Parent can call it.
  def get_name(data) do
    if __MODULE__ in data.__b__ do
      "IBook module - " <> data.name
    else
      "#{__MODULE__} isn't an ancestral of #{data}."
    end
  end

  # Public function.
  # Can't be overridable.
  # Parent can call it.
  def get_price(%{__b__: [__MODULE__]} = data), do: "IBook module - #{data.price}"
  def get_price(_), do: :invalid_struct

  # Private function.
  # Can't be overridable.
  # Parent can't call it.
  defp get_stock(%{__b__: [__MODULE__]} = data), do: "IBook module - #{data.stock}"
  defp get_stock(_), do: :invalid_struct

  # Redirecting call.
  def get_total_stock(%{__b__: [__MODULE__]} = data), do: "IBook module - #{get_stock(data)}"
  def get_total_stock(_), do: :invalid_struct
end
