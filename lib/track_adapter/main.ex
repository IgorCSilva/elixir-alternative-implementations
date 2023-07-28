defmodule TwoTrackAdapter do
  def mount(f, args \\ []) do
      &(track(f, &1, args))
  end

  defp track(_f, {:error, error}, _args) do
    throw({:error, error})
  end
  defp track(f, data, args), do: apply(f, [data | args])
end

defmodule TrackAdapter.Main do

  def create(data) do
    tt_save = TwoTrackAdapter.mount(&Repository.save/1, [])
    tt_notify = TwoTrackAdapter.mount(&Notify.notify_creation/2, ["ShowNotifier"])

    try do
      data
      |> Validation.validate_data()
      |> tt_save.()
      |> tt_notify.()
    catch
      {:error, error} -> {:error, error}
    end
  end
end

defmodule Validation do
  def validate_data(data), do: if data == "error", do: {:error, "Validation error"}, else: data
end

defmodule Repository do
  def save(data) do
    IO.inspect(data)
    "Data #{data} saved."
    # {:error, "Repository."}
  end
end
defmodule Notify do
  def notify_creation(data, notifier) do
    IO.inspect(data)
    "Data #{data} Notified by #{notifier}."
  end
end
