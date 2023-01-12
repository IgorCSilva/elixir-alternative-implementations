# elixir-alternative-implementations

## Fazendo com que structs tenham como base os atributos de uma outra struct.

Primeiro temos as structs base definidas na pasta domain. Estas structs servem para definir os atributos e funções default, além de uma função de encapsulamento que tem como objetivo apenas guardar dados.
Exemplo:
```elixir
defmodule Implements.Domain.IProduct do
  defstruct(
    # attributes ========================
    name: "",
    price: 0.0,
    stock: 0,
    # functions =========================
    get_name: &__MODULE__.get_name/1,
    get_price: &__MODULE__.get_price/1,
    # child =============================
    child: nil
  )

  def encapsulate(data) do
    if data.__struct__._i_() == __MODULE__ do
      %__MODULE__{child: data}
    else
      :invalid_struct
    end
  end

  def get_name(data) do
    if data.__struct__._i_() == __MODULE__ do
      data.name
    else
      :invalid_struct
    end
  end

  def get_price(data) do
    if data.__struct__._i_() == __MODULE__ do
      data.price
    else
      :invalid_struct
    end
  end
end
```

Na pasta infrastructure temos as structs que usam as structs definidas na pasta domain como base. Um exemplo é a struct Dress, que usa a struct IProduct como base:

```elixir
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
```
Aqui podemos ver que a função get_price, definida no módulo IProduct, será substituída pela função get_price definida no módulo Dress, no entanto a função get_name permanece sendo a definida no IProduct.


## Execução
Na raiz da pasta executar: `iex -S mix`
Em seguida executar: `Implements.Infrastructure.Main.run`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `alternative_implementation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:alternative_implementation, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/alternative_implementation>.