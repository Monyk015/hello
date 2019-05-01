defmodule HelloWeb.Plugs.CheckAdmin do
  import Plug.Conn
  import Phoenix.Controller
  alias Hello.Accounts.User

  alias HelloWeb.Router.Helpers

  def init(_) do
  end

  def call(conn, _) do
    case conn.assigns[:user] do
      %User{is_admin: true} ->
        conn

      %User{} ->
        conn
        |> put_flash(:error, "Need admin rights")
        |> redirect(to: Helpers.post_path(conn, :index))
        |> halt
    end
  end
end
