defmodule Implements.Domain.IBook do
  defstruct(
    # attributes ========================
    name: "",
    price: 0.0,
    stock: 0,
    # functions =========================
    get_name: &__MODULE__.get_name/1,
    get_price: &__MODULE__.get_price/1,
    # child =============================
    child: nil
  )

  def encapsulate(data) do
    if data.__struct__._i_() == __MODULE__ do
      %__MODULE__{child: data}
    else
      :invalid_struct
    end
  end

  def get_name(data) do
    if data.__struct__._i_() == __MODULE__ do
      "Book - " <> data.name
    else
      :invalid_struct
    end
  end

  def get_price(data) do
    if data.__struct__._i_() == __MODULE__ do
      data.price
    else
      :invalid_struct
    end
  end
end
