defmodule UseBase.Infrastructure.DictionaryBible do
  import Generations

  generate(
    %{
      parents: UseBase.Infrastructure.Dictionary,
      attributes: %{
        book_one: "english"
      }
    }
  )

  # Override base function.
  def get_name(%__MODULE__{} = data) do
    "Bible Dictionary module: " <> data.book_one <> " || " <> super(data)
  end
end
