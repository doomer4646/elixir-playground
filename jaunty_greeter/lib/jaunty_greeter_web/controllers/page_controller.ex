defmodule JauntyGreeterWeb.PageController do
  use JauntyGreeterWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
