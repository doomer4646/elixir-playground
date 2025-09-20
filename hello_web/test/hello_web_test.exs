defmodule HelloWebTest do
  use ExUnit.Case
  doctest HelloWeb

  test "greets the world" do
    assert HelloWeb.hello() == :world
  end
end
