defmodule Implements.Application.Product.Print do

  alias Implements.Domain.IProduct

  def execute(%IProduct{child: product}) do
    IO.inspect(product.get_name.(product), label: "Product name")
    IO.inspect(product.get_price.(product), label: "Product price")
    :ok
  end
  def execute(data), do: IO.inspect(data, label: "Invalid data in product usecase")
end
