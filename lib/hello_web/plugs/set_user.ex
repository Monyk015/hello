defmodule HelloWeb.Plugs.SetUser do
  import Plug.Conn

  def init(_) do
  end

  def call(conn, _) do
    if user_id = conn |> get_session(:user_id) do
      user = Hello.Accounts.get_user!(user_id)
      conn
        |> assign(:user, user)
    else
        conn
    end
  end
end
