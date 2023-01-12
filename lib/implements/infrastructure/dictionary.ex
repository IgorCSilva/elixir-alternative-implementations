defmodule Implements.Infrastructure.Dictionary do
  import Implements.Implements
  alias Implements.Domain.IBook

  implements(
    %{
      interface: IBook,
      functions: [
        get_name: &(__MODULE__.get_name(&1))
      ]
    }
  )

  def get_name(%__MODULE__{} = data) do
    data.name
  end
end
