defmodule Generations do
  alias Utils.Maps, as: MapUtils

  defmacro generate({_, _, opts}) do
    interface = Keyword.get(opts, :parents, nil) || Keyword.get(opts, :structure, nil)

    interface = if is_list(interface), do: interface, else: [interface]
    lineage_interfaces = Enum.filter(interface, fn {type, _, _} -> type == :__aliases__ end)
    attributes = Keyword.get(opts, :attributes, {:%{}, [], []})
    caller_module = __CALLER__.module

    quote do
      unquote_interface = unquote(interface)
      unquote_lineage_interfaces = unquote(lineage_interfaces)
      unquote_attributes = unquote(attributes)
      unquote_caller_module = unquote(caller_module)

      defstruct (
        unquote_interface
        |> Enum.map(fn i -> if is_atom(i), do: Map.from_struct(i.__struct__), else: i end)
        |> Enum.reduce(%{}, fn e, acc -> MapUtils.merge(acc, e) end)
        |> then(&(MapUtils.merge(unquote_attributes, &1)))
        |> Map.update(
            :__l__,
            [unquote_caller_module | unquote_lineage_interfaces],
            fn old_list -> [unquote_caller_module | unquote_lineage_interfaces ++ old_list] |> Enum.uniq() end
          )
        |> Map.merge(%{ @: unquote_caller_module, child: nil })
        |> Map.to_list()
      )

      unquote(
        Enum.map(
          lineage_interfaces
          |> Enum.filter(fn {_, _, ms} ->
            String.to_atom("Elixir." <> Enum.join(ms, ".")).__info__(:macros)
            |> Enum.any?(fn {key, _value} -> key == :__using__ end)
          end)
          |> Enum.reverse(),
          fn li ->
            quote do
              use unquote(li)
            end
          end
        )
      )


      def make_child(%{__l__: [_, __MODULE__ | _]} = child, %__MODULE__{} = parent), do: %{parent | child: child}
      def make_child(_), do: nil

      def is_my_lineage?(module), do: module in %__MODULE__{}.__l__

    end
  end
end
