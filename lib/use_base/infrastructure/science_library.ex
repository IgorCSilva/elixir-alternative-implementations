defmodule UseBase.Infrastructure.ScienceLibrary do
  import UseBase.UseBaseMacro

  usebase(
    %{
      base: UseBase.Domain.ILibrary,
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

  def add_sell_book(%{__b__: _} = data, %{__b__: _} = book) do
    if data.@.is_my_lineage?(__MODULE__) and book.@.is_my_lineage?(IBook) do
      %{data | sell_books: [book | data.sell_books]}
    else
      {:error, "Isn't leneage."}
    end
  end

  def count_books(%{__b__: _} = data) do
    if data.@.is_my_lineage?(__MODULE__) do
      Enum.count(data.sell_books) + super(data)
    else
      {:error, "Isn't leneage."}
    end
  end
end
