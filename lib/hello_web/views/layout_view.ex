defmodule HelloWeb.LayoutView do
  use HelloWeb, :view

  def get_user(conn) do
    conn.assigns[:user]
  end
end
