defmodule HelloWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller
  alias HelloWeb.Router.Helpers


  def init(_) do
  end

  def call(conn, _) do
    if user = conn.assigns[:user] do
      conn
    else
      conn
        |> put_flash(:error, "User not logged in")
        |> redirect(to: Helpers.user_path(conn, :login))
        |> halt
      end
  end
end
