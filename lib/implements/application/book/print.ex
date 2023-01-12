defmodule Implements.Application.Book.Print do

  alias Implements.Domain.IBook

  def execute(%IBook{child: book}) do
    IO.inspect(book.get_name.(book), label: "Book name")
    IO.inspect(book.get_price.(book), label: "Book price")
    :ok
  end
  def execute(data), do: IO.inspect(data, label: "Invalid data in book usecase")
end
