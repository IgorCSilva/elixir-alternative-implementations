defmodule UseBase.Application.Book.Print do

  alias UseBase.Domain.IBook

  def execute(%{__b__: [IBook]} = book) do
    IO.inspect("==== BOOK APPLICATION ====")

    IO.inspect(book.@.get_name(book))

    IO.inspect(book.@.get_price(book))
    IO.inspect(book.@.get_dictionary_price(book))

    IO.inspect(book.@.get_dictionary_stock(book))

    :ok
  end

  # def execute(%IBook{child: book}) do
  #   IO.inspect(book.get_name.(book), label: "Book name")
  #   IO.inspect(book.get_price.(book), label: "Book price")
  #   :ok
  # end



  def execute(data), do: IO.inspect(data, label: "Invalid data in book usecase")
end
