defmodule HelloWeb.Counter do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end

  def increment() do
    Agent.get_and_update(__MODULE__, fn n ->
      new = n + 1
      {new, new}
    end)
  end

  def reset() do
    Agent.update(__MODULE__, fn _ -> 0 end)
  end
end
