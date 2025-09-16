defmodule HelloEnum do
  require Integer
  # 1) all?/any?
  # nums = [2, 4, 6, 8, 10]
  # すべて偶数か？（true）
  # ひとつでも 9 以上があるか？（true）
  def mondai_all_any() do
    nums = [2, 4, 6, 8, 10]
    IO.puts("すべて偶数か? #{Enum.any?(nums) and Enum.all?(nums, fn e -> rem(e, 2) == 0 end)}")
    IO.puts("ひとつでも９以上があるか？ #{Enum.any?(nums, fn e -> e >= 9 end)}")

    IO.puts("すべて偶数か? #{Enum.any?(nums) and Enum.all?(nums, &Integer.is_even/1)}")
    IO.puts("ひとつでも９以上があるか？ #{Enum.any?(nums, &(&1 >= 9))}")
  end

  #   2) map
  # prices = [100, 250, 400]
  # 消費税10%込みの金額リストを作る（小数はそのままOK）→ [110.0, 275.0, 440.0]
  def add_tax(price, rate) do
    Integer.floor_div(price * (100 + rate), 100)
  end

  def mondai_map() do
    prices = [100, 250, 400]
    Enum.map(prices, &add_tax(&1, 10))
  end

  # 3) filter / reject
  # words = ["apple", "banana", "pear", "apricot", "plum"]
  # 先頭が "ap" のものだけ残す
  # 文字数が 5 未満のものを弾く
  def mondai_filter_reject() do
    words = ["apple", "banana", "pear", "apricot", "plum"]
    ap_only = Enum.filter(words, &match?("ap" <> _, &1))
    len5_or_more = Enum.reject(words, &(byte_size(&1) < 5))
    IO.inspect(ap_only, label: ~s|prefix "ap"|)
    IO.inspect(len5_or_more, label: "len>=5")
  end

  # 4) min/max
  # temps = [18, 21, 19, 25, 22, 20]
  # 最低/最高気温を求めて {min, max} のタプルで返す
  def mondai_min_max() do
    temps = [18, 21, 19, 25, 22, 20]
    min_max = {Enum.min(temps), Enum.max(temps)}
    IO.inspect(min_max, label: "min/max")
  end

  # 5) sort
  # people = [{"Abe", 30}, {"Sato", 25}, {"Yamada", 40}]
  # 年齢昇順で並べ替える
  # 名前降順で並べ替える
  def mondai_sort() do
    people = [{"Abe", 30}, {"Sato", 25}, {"Yamada", 40}]
    sorted_age = Enum.sort(people, &(elem(&1, 1) <= elem(&2, 1)))
    IO.inspect(sorted_age, label: "sorted_age")
    sorted_name = Enum.sort(people, &(elem(&1, 0) <= elem(&2, 0)))
    IO.inspect(sorted_name, label: "sorted_name")
    # Enum.sort(people, fn el -> elem(el, 0) end)
  end

  # 6) reduce
  # nums = [3, 5, 7, 9]
  # 合計を Enum.reduce/2 で求める
  # “掛け算トータル”も reduce で求める
  # チャンク/ユニーク系
  def mondai_reduce() do
    nums = [3, 5, 7, 9]
    tasizan = Enum.reduce(nums, &(&1 + &2))
    kakezan = Enum.reduce(nums, &(&1 * &2))
    IO.inspect(tasizan, label: "足し算合計")
    IO.inspect(kakezan, label: "掛け算合計")
  end

  # 7) chunk_every
  # stream = Enum.to_list(1..10)
  # 要素を 3 個ずつのサブリストに分ける（端の余りもそのまま出す）
  # 例: [[1,2,3],[4,5,6],[7,8,9],[10]]
  def mondai_chunk_every() do
    stream = Enum.to_list(1..10)
    chunked = Enum.chunk_every(stream, 3)
    IO.inspect(chunked)
  end

  # 8) chunk_by
  # letters = ["a","a","b","b","b","a","c","c"]
  # 隣接する同値ごとにまとめる
  # 例: [["a","a"],["b","b","b"],["a"],["c","c"]]

  # 9) uniq / uniq_by
  # users = [ %{id: 1, name: "A"}, %{id: 2, name: "B"}, %{id: 1, name: "A*"} ]
  # id が重複する要素を 最初の出現だけ残すリストにする（uniq_by(& &1.id) を使う）
  # 複合問題

  # 10) 文字列スコア
  # codes = ["AA-100", "B-9", "CCC-30", "A-5", "BB-50"]
  # 文字部分の長さ×数値部分 を「スコア」とする
  # 例: "AA-100" → 2 * 100 = 200
  # 各要素を %{code: "...", score: n} に変換（map）
  # スコアの 最大 と 最小 を求めて {min_map, max_map} で返す
  # ※ 文字列処理は String なしで、"-" の位置で chunk_by は使えないため、
  # ここは **「reduce で文字と数字を手作業で分ける」**か、
  # または入力を {letters, number} のタプル配列に前提変換してから解いてOK。
  # 例: [{ "AA", 100 }, {"B", 9}, ...] にしてから取り組む。

  # 11) 在庫チェック
  # items = [%{sku: "A", stock: 10}, %{sku: "B", stock: 0}, %{sku: "C", stock: 5}, %{sku: "B", stock: 3}]
  # sku 重複を uniq_by で 最初の出現を採用
  # 在庫が 1 以上の SKU が すべて存在するか all? で確認（true/false）
  # 在庫 0 のものが ひとつでもあるか any? で確認

  # 12) グループ合計（chunk_every + reduce）
  # nums = [5, 4, 1, 2, 9, 3, 8] を 3 個ずつに分けて、各チャンクの合計を出す
  # 期待例: [[5,4,1],[2,9,3],[8]] → [10,14,8]
  # チャレンジ（任意）

  # 13) ログ圧縮（run-length encoding 的）
  # data = ["A","A","A","B","B","C","C","C","C","A"]
  # chunk_by で連続要素をまとめ、map と reduce で
  # [{"A",3},{"B",2},{"C",4},{"A",1}] を作る

  # 14) 集計＆並べ替え
  # orders = [ {:a, 100}, {:b, 50}, {:a, 30}, {:c, 20}, {:b, 70} ]
  # ラベルごとに合計（reduce）→ [%{key: :a, total: 130}, ...]
  # total 降順に sort
end
