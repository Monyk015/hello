defmodule Hello.RepoTest do
  alias Hello.Repo
  use Hello.DataCase

  describe "insert_all_models" do
    @data [
      %{content: "content of post 1", title: "title of post 1"},
      %{content: "content of post 2", title: "title of post 2"},
      %{content: "content of post 3", title: "title of post 3"}
    ]
    @schema Hello.Posts.Post

    defp get_models(_) do
      models = @data
        |> Enum.map(fn post ->
          @schema.changeset(%@schema{}, post)
            |> apply_changes
        end)
        %{models: models}
    end

    setup [:get_models]
    test "should insert all", %{models: models} do
      {inserted_count, _} = Repo.insert_all_models(@schema, models)
      assert inserted_count == Enum.count @data
    end
  end
end
