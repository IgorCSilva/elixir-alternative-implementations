defmodule Generations.Utils.ManipulateGeneration do

  def change_generation(%{@: module} = data, target) when target == module, do: data
  def change_generation(%{__l__: lineage} = data, target) do

    cond do
      target in lineage ->
        struct(
          target,
          Map.from_struct(data)
          |> Map.merge(%{@: target, __l__: struct(target).__l__})
        )

      data.__struct__ in struct(target).__l__ ->
        struct(
          target,
          Map.from_struct(data)
        )

      true -> {:error, "Struct is not in lineage."}
    end
  end
  def change_generation(_, _), do: {:error, "Invalid data for changing generation."}

  def raw_content([]), do: []
  def raw_content([head | tail]), do: [raw_content(head) | raw_content(tail)]
  def raw_content(data) when is_struct(data) do
    Map.from_struct(data)
    |> Map.drop([:@, :__l__, :child])
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      Map.put(acc, key, raw_content(value))
    end)
  end
  def raw_content(data), do: data
end
