defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password, :string
    field :is_admin, :boolean

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :is_admin])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> update_change(:password, &Bcrypt.hashpwsalt/1)
  end

  def check_password(%__MODULE__{} = user, password) do
    Bcrypt.checkpw(password, user.password)
  end
end
