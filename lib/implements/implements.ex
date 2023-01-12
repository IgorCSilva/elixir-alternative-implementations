defmodule Implements.Implements do
  @moduledoc """
  Module to perform an interface implementation.
  """

  defmacro implements({_, _, opts}) do
    interface = Keyword.get(opts, :interface, nil)
    functions = Keyword.get(opts, :functions, [])

    quote location: :keep do

      unquote_interface = unquote(interface)

      defstruct unquote(functions) |> Enum.reduce(
        unquote_interface |> Map.from_struct() |> Map.drop([:child]),
        fn {key, value}, struct -> Map.put(struct, key, value)
      end)
      |> Map.to_list()

      def _i_(), do: unquote(interface)
    end
  end
end
