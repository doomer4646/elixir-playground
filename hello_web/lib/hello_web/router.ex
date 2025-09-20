defmodule HelloWeb.Router do
  use Plug.Router
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello Elixir! 🚀")
  end

  post "/echo" do
    {:ok, body, _conn} = Plug.Conn.read_body(conn)
    send_resp(conn, 200, body)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
