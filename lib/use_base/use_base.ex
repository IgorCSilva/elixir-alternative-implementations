defmodule UseBase.UseBaseMacro do
  alias UseBase.Domain.Utils.Maps, as: MapUtils

  defmacro usebase({_, _, opts}) do
    interface = Keyword.get(opts, :base, nil)

    interface = if is_list(interface), do: interface, else: [interface]
    attributes = Keyword.get(opts, :attributes, %{})
    caller_module = __CALLER__.module

    quote do
      unquote_interface = unquote(interface)
      unquote_attributes = unquote(attributes)
      unquote_caller_module = unquote(caller_module)

      defstruct (
        unquote_interface
        |> Enum.map(fn i -> Map.from_struct(i.__struct__) end)
        |> Enum.reduce(%{}, fn e, acc -> MapUtils.merge(acc, e) end)
        |> then(&(MapUtils.merge(unquote_attributes, &1)))
        |> Map.update(
            :__b__,
            [unquote_caller_module | unquote_interface],
            fn old_list -> [unquote_caller_module |  unquote_interface ++ old_list] |> Enum.uniq() end
          )
        |> Map.merge(%{ @: unquote_caller_module, child: nil })
        |> Map.to_list()
      )

      unquote(
        Enum.map(
          Enum.reverse(interface),
          fn i ->
            quote do
              use unquote(i)
            end
          end
        )
      )


      def make_child(%{__b__: [_, __MODULE__ | _]} = child, %__MODULE__{} = parent), do: %{parent | child: child}
      def make_child(_), do: nil

      def is_my_lineage?(module), do: module in %__MODULE__{}.__b__
    end
  end
end
