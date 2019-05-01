defmodule Hello.Posts.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag" do
    field :name, :string
    many_to_many(:posts, Hello.Posts.Post, join_through: "tags_posts")

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
