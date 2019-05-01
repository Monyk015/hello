defmodule Hello.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Posts

  schema "posts" do
    field :content, :string
    field :title, :string

    many_to_many(:tags, Posts.Tag, join_through: "tags_posts")

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
