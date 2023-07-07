defmodule UseBase.Infrastructure.MathScienceLibrary do
  import UseBase.UseBaseMacro

  usebase(
    %{
      base: [UseBase.Infrastructure.MathLibrary, UseBase.Infrastructure.ScienceLibrary],
      attributes: %{
        category: "MathScience"
      }
    }
  )

  def count_books(%{__b__: _} = data) do
    if data.@.is_my_lineage?(__MODULE__) do
      Enum.count(data.sell_books) + super(data)
    else
      {:error, "Isn't leneage."}
    end
  end
end
