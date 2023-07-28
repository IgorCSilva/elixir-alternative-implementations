defmodule FunctionsSignatures.Signatures do

  @type add_n :: (number() -> number())
  @type add_values :: ((number() -> number()) -> number())

  @type check_func :: (any() -> boolean())

  @callback pass_thru(String.t(), check_func(), any()) :: (any() -> any())
end
