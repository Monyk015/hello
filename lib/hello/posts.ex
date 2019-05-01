defmodule Hello.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Hello.Repo

  alias Hello.Posts.Post
  alias Ecto.Multi

  @doc """
  Returns the list of posts.
  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.
  Raises `Ecto.NoResultsError` if the Post does not exist.
  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.
  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.
  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.
  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  def create_posts(posts) do
    IO.inspect(posts)
    posts = posts
      |> Enum.map(fn post -> Post.changeset(%Post{}, post) end)

    invalid_posts = posts
      |> Enum.filter(fn post -> !post.valid? end)

    fields = Post.__schema__(:fields)
    if Enum.empty? invalid_posts do
      Repo.insert_all_models(Post, posts)
    else
      invalid_posts
    end
  end
end
