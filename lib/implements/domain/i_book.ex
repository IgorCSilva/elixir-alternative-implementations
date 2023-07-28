defmodule Implements.Domain.IBook do
  defstruct(
    attributes: %{
      name: "",
      price: 0.0,
      stock: 0
    },
    functions: %{
      get_name: &__MODULE__.get_name/1,
      get_price: &__MODULE__.get_price/1
    },
    child: nil
  )

  def encapsulate(%{__i__: __MODULE__} = data), do: %__MODULE__{child: data}
  def encapsulate(_), do: :invalid_struct

  def get_name(%{__i__: __MODULE__} = data), do: "Book - " <> data.name
  def get_name(_), do: :invalid_struct

  def get_price(%{__i__: __MODULE__} = data), do: data.price
  def get_price(_), do: :invalid_struct
end
