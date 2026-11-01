defmodule ScratchKitchen.MixProject do
  use Mix.Project

  def project do
    [
      app: :scratch_kitchen,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Photo-first kitchen app: inventory from photos, specific meals from ingredients on hand, reuse into new meals, share the extra.",
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ScratchKitchen.Application, []}
    ]
  end

  defp deps do
    []
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hamanakam1/scratch-kitchen"}
    ]
  end
end
