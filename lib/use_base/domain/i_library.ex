defmodule UseBase.Domain.ILibrary do
  import Generations

  generate(
    %{
      structure: %{
        category: "",
        books: []
      }
    }
  )

  alias UseBase.Domain.IBook

  defmacro __using__(_opts) do
    lm = __MODULE__
    quote do
      defdelegate count_books(data), to: unquote(lm), as: :count_books
      defdelegate add_book(data, book), to: unquote(lm), as: :add_book

      defoverridable [count_books: 1, add_book: 2]
    end
  end

  def add_book(%{__l__: _} = data, %{__l__: _} = book) do
    if data.@.is_my_lineage?(__MODULE__) and book.@.is_my_lineage?(IBook) do
      %{data | books: [book | data.books]}
    else
      {:error, "Isn't leneage."}
    end
  end

  def count_books(%{@: funcs} = data) do
    if funcs.is_my_lineage?(__MODULE__) do
      Enum.count(data.books)
    else
      {:error, "Isn't leneage."}
    end
  end
end
