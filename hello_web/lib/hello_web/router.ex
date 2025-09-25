defmodule HelloWeb.Router do
  use Plug.Router
  import Plug.Conn

  plug(:put_secret_key_base)

  plug(Plug.Session,
    store: :cookie,
    key: "_hello_web_key",
    signing_salt: "random_salt",
    same_site: "Lax",
    secure: false
  )

  plug(:fetch_session)

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
    count = get_session(conn, :count) || 0

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
    value = (get_session(conn, :count) || 0) + 1

    conn
    |> put_session(:count, value)
    |> put_resp_header(
      "location",
      "/counter"
    )
    |> send_resp(303, "")
  end

  post "/counter/reset" do
    conn
    |> put_session(:count, 0)
    |> put_resp_header("location", "/counter")
    |> send_resp(303, "")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

  # ここに追加 ↓
  defp put_secret_key_base(conn, _opts) do
    secret =
      System.get_env("SECRET_KEY_BASE") ||
        "dev-secret-key-base-should-be-long-and-random-at-least-64-bytes................"

    %{conn | secret_key_base: secret}
  end
end
