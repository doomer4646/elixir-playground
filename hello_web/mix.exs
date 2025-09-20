defmodule HelloWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_web,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HelloWeb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.15"},
      {:bandit, "~> 1.5"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
