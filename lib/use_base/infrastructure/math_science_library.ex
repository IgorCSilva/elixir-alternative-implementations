defmodule UseBase.Infrastructure.MathScienceLibrary do
  import Generations

  generate(
    %{
      parents: [UseBase.Infrastructure.MathLibrary, UseBase.Infrastructure.ScienceLibrary],
      attributes: %{
        category: "MathScience"
      }
    }
  )

  def count_books(%{__l__: _} = data) do
    if data.@.is_my_lineage?(__MODULE__) do
      IO.inspect("COUNT BOOKS MATH SCIENCE")
      Enum.count(data.sell_books) + super(data)
    else
      {:error, "Isn't leneage."}
    end
  end
end
