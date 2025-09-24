defmodule HelloWeb.Router do
  use Plug.Router
  import Plug.Conn
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello Elixir! 🚀")
  end

  post "/echo" do
    {:ok, body, _conn} = Plug.Conn.read_body(conn)
    send_resp(conn, 200, body)
  end

  get "/counter" do
    count = HelloWeb.Counter.get()

    html = """
    <!DOCTYPE html>
    <meta charset="utf-8">
    <title>Counter</title>
    <h1>Counter: #{count}</h1>
    <form action="/counter/increment" method="post">
      <button type="submit">+1</button>
    </form>
    <form action="/counter/reset" method="post">
      <button type="submit">reset</button>
    </form>
    """

    conn
    |> put_resp_content_type("text/html; charset=utf-8")
    |> send_resp(200, html)
  end

  post "/counter/increment" do
    HelloWeb.Counter.increment()

    conn
    |> put_resp_header(
      "location",
      "/counter"
    )
    |> send_resp(303, "")
  end

  post "/counter/reset" do
    HelloWeb.Counter.reset()

    conn
    |> put_resp_header("location", "/counter")
    |> send_resp(303, "")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
