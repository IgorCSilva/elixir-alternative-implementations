defmodule Implements.Infrastructure.Dress do
  import Implements.Implements
  alias Implements.Domain.IProduct

  implements(
    %{
      interface: IProduct,
      functions: [
        get_price: &(__MODULE__.get_price(&1))
      ]
    }
  )

  def get_price(%__MODULE__{} = data) do
    data.price * 2
  end
end
