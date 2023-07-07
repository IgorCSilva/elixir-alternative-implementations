defmodule UseBase.Infrastructure.Main do
  # alias UseBase.Infrastructure.Dress
  # alias UseBase.Application.Product.Print, as: ProductPrint

  alias UseBase.Infrastructure.Dictionary
  alias UseBase.Infrastructure.DictionaryBible
  alias UseBase.Application.Book.Print, as: BookPrint

  alias UseBase.Infrastructure.MathLibrary
  alias UseBase.Infrastructure.ScienceLibrary
  alias UseBase.Infrastructure.MathScienceLibrary

  def run do
    # dress = %Dress{name: "Vestido Rosa", price: 100}
    dictionary = %Dictionary{name: "Dicionário de português", price: 500}
    dictionary_bible = %DictionaryBible{name: "English"}

    # Libraries.
    # begginner_math = %MathLibrary{}

    # IO.inspect(begginner_math)
    # IO.inspect(begginner_math.@.count_books(begginner_math))

    # begginner_math = begginner_math.@.add_book(begginner_math, dictionary)

    # IO.inspect(begginner_math)
    # IO.inspect(begginner_math.@.count_books(begginner_math))

    # begginner_math = begginner_math.@.add_unavailable_book(begginner_math, dictionary_bible)

    # IO.inspect(begginner_math)
    # IO.inspect(begginner_math.@.count_books(begginner_math))


    # begginner_science = %ScienceLibrary{}

    # IO.inspect(begginner_science)
    # IO.inspect(begginner_science.@.count_books(begginner_science))

    # begginner_science = begginner_science.@.add_book(begginner_science, dictionary)

    # IO.inspect(begginner_science)
    # IO.inspect(begginner_science.@.count_books(begginner_science))

    # begginner_science = begginner_science.@.add_sell_book(begginner_science, dictionary_bible)

    # IO.inspect(begginner_science)
    # IO.inspect(begginner_science.@.count_books(begginner_science))


    begginner_ms = %MathScienceLibrary{}

    IO.inspect(begginner_ms)
    IO.inspect(begginner_ms.@.count_books(begginner_ms))

    begginner_ms = begginner_ms.@.add_book(begginner_ms, dictionary)

    IO.inspect(begginner_ms)
    IO.inspect(begginner_ms.@.count_books(begginner_ms))

    begginner_ms = begginner_ms.@.add_unavailable_book(begginner_ms, dictionary_bible)

    IO.inspect(begginner_ms)
    IO.inspect(begginner_ms.@.count_books(begginner_ms))

    begginner_ms = begginner_ms.@.add_sell_book(begginner_ms, dictionary_bible)

    IO.inspect(begginner_ms)
    IO.inspect(begginner_ms.@.count_books(begginner_ms))

    # IO.inspect(dictionary_bible)
    # IO.inspect(dictionary.@.make_child(dictionary_bible, dictionary))

    # encapsulated_dress = dress.__i__.encapsulate(dress)
    # encapsulated_dictionary = dictionary.__i__.encapsulate(dictionary)

    # IO.puts("PRODUCT PRINT")
    # ProductPrint.execute(encapsulated_dress)
    # ProductPrint.execute(encapsulated_dictionary)

    # IO.puts("BOOK PRINT")
    # BookPrint.execute(dictionary)
    # BookPrint.execute(dictionary_bible)
    # dictionary_bible.@.get_name(dictionary_bible)
    # BookPrint.execute(encapsulated_dictionary)
  end
end
