defmodule FunctionsSignatures.ModuleA do

  @type func :: (integer() -> integer())

  @spec apply_function(func(), integer()) :: integer()
  def apply_function(func, value) when is_function(func, 1) and is_integer(value) do
    func.(value)
  end

  @spec add(x :: integer, y :: integer) :: integer
  def add(x, y) when is_integer(x) and is_integer(y) do
    x + y
  end

  @spec subtract(x :: integer, y :: integer) :: integer
  def subtract(x, y) when is_integer(x) and is_integer(y) do
    x - y
  end

  # Signature that returns a function
  @spec get_operation(operation :: atom) :: func
  def get_operation(:add), do: &add/2
  def get_operation(:subtract), do: &subtract/2
end
