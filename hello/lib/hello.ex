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
end
