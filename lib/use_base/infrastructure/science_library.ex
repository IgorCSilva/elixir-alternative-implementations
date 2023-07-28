defmodule UseBase.Infrastructure.ScienceLibrary do
  import Generations

  generate(
    %{
      parents: UseBase.Domain.ILibrary,
      attributes: %{
        category: "Science",
        sell_books: []
      }
    }
  )

  alias UseBase.Domain.IBook

  defmacro __using__(_opts) do
    lm = __MODULE__
    quote do
      defdelegate count_books(data), to: unquote(lm), as: :count_books
      defdelegate add_book(data, book), to: unquote(lm), as: :add_book
      defdelegate add_sell_book(data, book), to: unquote(lm), as: :add_sell_book

      defoverridable [count_books: 1]
    end
  end

  def add_sell_book(%{__l__: _} = data, %{__l__: _} = book) do
    if data.@.is_my_lineage?(__MODULE__) and book.@.is_my_lineage?(IBook) do
      %{data | sell_books: [book | data.sell_books]}
    else
      {:error, "Isn't lineage."}
    end
  end

  def count_books(%{__l__: _} = data) do
    if data.@.is_my_lineage?(__MODULE__) do
      IO.inspect("COUNT BOOKS SCIENCE")
      Enum.count(data.sell_books) + super(data)
    else
      {:error, "Isn't lineage."}
    end
  end
end
