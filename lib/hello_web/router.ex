defmodule HelloWeb.Router do
  use HelloWeb, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelloWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug HelloWeb.Plugs.SetUser
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PostController, :index
    get "/user/sign-out", UserController, :sign_out
    get "/user/login", UserController, :login
    post "/user/sign-in", UserController, :sign_in
    resources "/user", UserController
    resources "/post", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
