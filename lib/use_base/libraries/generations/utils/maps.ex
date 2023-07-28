defmodule Utils.Maps do

  def merge(data1, nil), do: data1
  def merge(nil, data2), do: data2

  def merge([], data2) when is_list(data2), do: data2
  def merge([], _data2), do: []
  def merge(['-' | tail1], [head2 | tail2]), do: [head2] ++ merge(tail1, tail2)
  def merge([head1 | tail1], [head2 | tail2]), do: [merge(head1, head2)] ++ merge(tail1, tail2)

  def merge(data1, data2) when (is_map(data1) and is_map(data2)) do
    {result, remaining_fields} = Enum.reduce(data1, {%{}, data2}, fn {key, value}, {acc, data2_updated} ->
      if Map.has_key?(data2_updated, key) do
        {Map.put(acc, key, merge(value, data2_updated[key])), Map.drop(data2_updated, [key])}
      else
        {Map.put(acc, key, value), data2_updated}
      end
    end)

    Map.merge(result, remaining_fields)
  end
  def merge(data1, data2) do
    [{"Data type", type1} | _] = IEx.Info.info(data1)
    [{"Data type", type2} | _] = IEx.Info.info(data2)

    (if type1 == type2, do: data1, else: data2)

  end
end
