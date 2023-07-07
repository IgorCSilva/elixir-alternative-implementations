defmodule UseBase.Infrastructure.MathLibrary do
  import UseBase.UseBaseMacro

  usebase(
    %{
      base: UseBase.Domain.ILibrary,
      attributes: %{
        category: "Math",
        unavailable_books: []
      }
    }
  )

  alias UseBase.Domain.IBook

  defmacro __using__(_opts) do
    lm = __MODULE__
    quote do
      defdelegate count_books(data), to: unquote(lm), as: :count_books
      defdelegate add_book(data, book), to: unquote(lm), as: :add_book
      defdelegate add_unavailable_book(data, book), to: unquote(lm), as: :add_unavailable_book

      defoverridable [count_books: 1]
    end
  end

  def add_unavailable_book(%{__b__: _} = data, %{__b__: _} = book) do
    if data.@.is_my_lineage?(__MODULE__) and book.@.is_my_lineage?(IBook) do
      %{data | unavailable_books: [book | data.unavailable_books]}
    else
      {:error, "Isn't leneage."}
    end
  end

  def count_books(%{__b__: _} = data) do
    if data.@.is_my_lineage?(__MODULE__) do
      Enum.count(data.unavailable_books) + super(data)
    else
      {:error, "Isn't leneage."}
    end
  end
end
