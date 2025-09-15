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
end
