defmodule TaskAppWeb.Router do
  use TaskAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TaskAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaskAppWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/tasks", TasksController
  end
end
