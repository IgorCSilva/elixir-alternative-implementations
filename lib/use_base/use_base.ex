defmodule UseBase.UseBaseMacro do
  alias UseBase.Domain.Utils.Maps, as: MapUtils

  defmacro usebase({_, _, opts}) do
    interface = Keyword.get(opts, :base, nil)
    attributes = Keyword.get(opts, :attributes, %{})
    caller_module = __CALLER__.module

    quote do
      unquote_interface = unquote(interface)
      unquote_attributes = unquote(attributes)
      unquote_caller_module = unquote(caller_module)

      defstruct (
        unquote_interface.__struct__
        |> Map.from_struct()
        |> then(&(MapUtils.merge(unquote_attributes, &1)))
        |> Map.update(
            :__b__,
            [unquote_interface],
            fn old_list -> [unquote_interface | old_list] end
          )
        |> Map.merge(%{ @: unquote_caller_module, child: nil })
        |> Map.to_list())

      use unquote(interface)

      def make_child(%{__b__: [__MODULE__ | _]} = child, %__MODULE__{} = parent), do: %{parent | child: child}
      def make_child(_), do: nil
    end
  end
end
