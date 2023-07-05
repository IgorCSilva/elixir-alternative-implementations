defmodule UseBase.Infrastructure.Main do
  # alias UseBase.Infrastructure.Dress
  # alias UseBase.Application.Product.Print, as: ProductPrint

  alias UseBase.Infrastructure.Dictionary
  alias UseBase.Infrastructure.DictionaryBible
  alias UseBase.Application.Book.Print, as: BookPrint

  def run do
    # dress = %Dress{name: "Vestido Rosa", price: 100}
    dictionary = %Dictionary{name: "Dicionário de português", price: 500}
    dictionary_bible = %DictionaryBible{name: "English"}

    IO.inspect(dictionary)
    IO.inspect(dictionary_bible)
    IO.inspect(dictionary.@.make_child(dictionary_bible, dictionary))

    # encapsulated_dress = dress.__i__.encapsulate(dress)
    # encapsulated_dictionary = dictionary.__i__.encapsulate(dictionary)

    # IO.puts("PRODUCT PRINT")
    # ProductPrint.execute(encapsulated_dress)
    # ProductPrint.execute(encapsulated_dictionary)

    # IO.puts("BOOK PRINT")
    BookPrint.execute(dictionary)
    BookPrint.execute(dictionary_bible)
    dictionary_bible.@.get_name(dictionary_bible)
    # BookPrint.execute(encapsulated_dictionary)
  end
end
