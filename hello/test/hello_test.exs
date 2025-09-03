defmodule HelloTest do
  use ExUnit.Case
  doctest Hello

  test "greets the world" do
    assert Hello.hello() == :world
  end

  test "greets a name" do
    assert Hello.greet("Alice") == "Hello, Alice!"
  end
end
