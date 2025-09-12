defmodule HelloTest do
  use ExUnit.Case, async: true
  # doctestを有効にする
  doctest Hello

  test "parse_integer" do
    assert Hello.parse_integer("10") == {:ok, 10}
    assert Hello.parse_integer("x10") == {:error, :invalid_integer}
  end

  test "validate_age" do
    assert Hello.validate_age(20) == {:ok, :adult}
    assert Hello.validate_age(0) == {:ok, :minor}
    assert Hello.validate_age(-1) == {:error, :invalid_id}
  end

  test "fetch_user" do
    assert Hello.fetch_user(42) == {:ok, %{id: 42, name: "User42"}}
    assert Hello.fetch_user(1) == {:error, :not_found}
    assert Hello.fetch_user("x") == {:error, :invalid_id}
  end

  test "show_user with with-chain" do
    assert Hello.show_user("42") == {:ok, "ID=42, Name=User42"}
    assert Hello.show_user("1") == {:error, :not_found}
    assert Hello.show_user("x") == {:error, :invalid_integer}
    assert Hello.show_user(-1) == {:error, :invalid_id}
  end
end
