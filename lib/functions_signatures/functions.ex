defmodule FunctionsSignatures.Functions do

  alias FunctionsSignatures.Signatures

  @spec add1(n :: number()) :: number() | {:error, String.t()}
  def add1(n) when is_number(n) do
    n + 1
  end
  def add1(_), do: {:error, "Invalid type."}

  @spec apply_add_then_sub(f :: Signatures.add_n(), n :: number(), v :: number()) :: number()
  def apply_add_then_sub(f, n, v) when is_number(n) and is_number(v) do
    f.(n) - v
  end

  @behaviour Signatures

  @impl Signatures
  def pass_thru(err_msg, f, x) do
    if f.(x) do
      x
    else
      {:error, err_msg}
    end
  end

  def is_hello(t) do
    t == "hello"
  end

  # Comṕosing functions adding dependencies.

  def check_product_code(code) do
    code in ["p1", "p2", "p3", "p4", "p5"]
  end
  def check_address(address) do
    address in ["a1", "a2"]
  end

  def validate_order(check_product_code_exists, check_address_exists, unavailable_order) do
    if check_product_code_exists.(unavailable_order.product_code) and check_address_exists.(unavailable_order.address) do
      %{valid_product_code: unavailable_order.product_code, valid_address: unavailable_order.address}
    else
      {:error, "Invalid order."}
    end
  end

  def validate_order_with_dependencies(validate_order, check_product_code_exists, check_address_exists) do
    &(validate_order.(check_product_code_exists, check_address_exists, &1))
  end
end
