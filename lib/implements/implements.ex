defmodule Implements.Implements do
  @moduledoc """
  Module to perform an interface implementation.
  """

  defmacro implements({_, _, opts}) do
    interface = Keyword.get(opts, :interface, nil)
    functions = Keyword.get(opts, :functions, [])

    quote location: :keep do

      unquote_interface = unquote(interface) |> Map.from_struct()

      attributes = Map.get(unquote_interface, :attributes, %{})
      default_functions = Map.get(unquote_interface, :functions, %{})

      defstruct unquote(functions)
                |> Enum.filter(fn {key, _} -> key in Map.keys(default_functions) end)
                |> Enum.reduce(
                  attributes
                  |> Map.merge(%{__i__: unquote(interface)})
                  |> IO.inspect(label: "ahhh")
                  |> Map.merge(default_functions),
                  fn {key, value}, struct ->
                    Map.put(struct, key, value)
                  end
                )
                |> Map.to_list()

      # def _i_(), do: unquote(interface)
    end
  end
end
