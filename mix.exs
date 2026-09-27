defmodule StartReg.MixProject do
  use Mix.Project

  def project do
    [
      app: :start_reg,
      version: "0.1.0",
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:starter, "~> 0.5"},
      {:igniter, "~> 0.8"},
    ]
  end
end
