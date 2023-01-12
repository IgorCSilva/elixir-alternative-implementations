defmodule Implements.Infrastructure.Main do
  alias Implements.Infrastructure.Dress
  alias Implements.Application.Product.Print, as: ProductPrint

  alias Implements.Infrastructure.Dictionary
  alias Implements.Application.Book.Print, as: BookPrint

  def run do
    dress = %Dress{name: "Vestido Rosa", price: 100}
    dictionary = %Dictionary{name: "Dicionário de português", price: 500}

    encapsulated_dress = Dress._i_().encapsulate(dress)
    encapsulated_dictionary = Dictionary._i_().encapsulate(dictionary)

    IO.puts("PRODUCT PRINT")
    ProductPrint.execute(encapsulated_dress)
    ProductPrint.execute(encapsulated_dictionary)

    IO.puts("BOOK PRINT")
    BookPrint.execute(encapsulated_dress)
    BookPrint.execute(encapsulated_dictionary)
  end
end
