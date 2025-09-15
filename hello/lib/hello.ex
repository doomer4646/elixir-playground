defmodule Hello do
  @moduledoc """
  パターンマッチで戻り値をさばく練習モジュール
  """
  @doc """


  ## Examples

  iex -S mix
  iex(3)>  Hello.parse_integer("12x")
  {:error, :invalid_integer}
  iex(4)> Hello.parse_integer("12")
  """
  # 例１：文字列を整数に変換
  def parse_integer(str) when is_binary(str) do
    case Integer.parse(str) do
      {int, ""} -> {:ok, int}
      _ -> {:error, :invalid_integer}
    end
  end

  # 例２：年齢バリデーション
  def validate_age(age) when is_integer(age) and age >= 0 do
    if age >= 20, do: {:ok, :adult}, else: {:ok, :minor}
  end

  def validate_age(_), do: {:error, :invalid_id}

  # 例３：ユーザー検索っぽいもの
  def fetch_user(id) when is_integer(id) and id > 0 do
    if id == 42 do
      {:ok, %{id: 42, name: "User42"}}
    else
      {:error, :not_found}
    end
  end

  def fetch_user(_), do: {:error, :invalid_id}

  # 例４：蒸気を組み合わせるユースケース
  def show_user(id_str) when is_binary(id_str) do
    with {:ok, id} <- parse_integer(id_str),
         {:ok, user} <- fetch_user(id) do
      {:ok, "ID=#{user.id}, Name=#{user.name}"}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def show_user(_), do: {:error, :invalid_id}

  # 📝 お題１：買い物リスト（List + Enum）
  # 買い物リスト（["りんご", "みかん", "バナナ"]）を作る
  # そこに "ぶどう" を追加する
  # Enum.each/2 で「〜を買う」と1行ずつ表示する
  def odai1() do
    list = ["りんご", "みかん", "バナナ"]
    list = list ++ ["ぶどう"]
    Enum.each(list, fn el -> IO.puts(el <> "を買う") end)
  end

  # お題２：ユーザー情報（Tuple）

  # ユーザーを {id, name, age} というタプルで表す
  # 例: {1, "山村", 27}
  # そこから名前だけを取り出して表示する
  # 年齢を +1 した新しいタプルを作る
  def odai2() do
    user1 = {1, "山村", 27}
    {id, name, age} = user1
    IO.puts(name)

    user2 = {id, name, age + 1}
    {_, _, new_age} = user2
    IO.puts(new_age)
  end

  # お題３：社員名簿（Map）
  # Mapで社員の役職を表す
  # %{"田中" => "課長", "佐藤" => "主任"}
  # 新しく "山村" => "部長" を追加する
  # "佐藤" の役職を "係長" に更新する
  # 全員分を "名前: 役職" の形式で表示する
  def odai3() do
    yakushoku = %{"田中" => "課長", "佐藤" => "主任"}
    new_yakushoku = Map.put(yakushoku, :山村, "部長")
    IO.inspect(new_yakushoku)
  end
end
