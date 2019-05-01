defmodule Hello.Repo do
  use Ecto.Repo,
    otp_app: :hello,
    adapter: Ecto.Adapters.Postgres

  def insert_all_models(schema, models) do
    fields = schema.__schema__(:fields)

    map_list = models
              |> Enum.map(fn model ->
                model
                  |> Map.from_struct
                  |> Map.merge(%{
                      inserted_at: datetime(),
                      updated_at: datetime(),
                    })
                  |> Map.take(fields)
                  |> Map.delete(:id)
              end)

    __MODULE__.insert_all(schema, map_list)
  end

  defp datetime, do: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
end
