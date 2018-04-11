defmodule TwilioSandbox.Router do
  use TwilioSandbox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwilioSandbox do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/token", TwilioSandbox do
    pipe_through :api

    get "/", TokenController, :token
  end

  scope "/commands", TwilioSandbox do
    pipe_through :api

    post "/dial", CommandsController, :dial
    post "/hangup", CommandsController, :hangup
    post "/status_callback", PageController, :status_callback
  end

  # scope "/token", TwilioSandbox do
  #   pipe_through :browser
  #   get "/token", PageController, :token
  # end
end
