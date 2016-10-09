defmodule StemEx.Mixfile do
  use Mix.Project

  def project do
    [
      # APP
      app: :stem_ex,
      version: "0.0.1",
      elixir: "~> 1.3",
      escript: [main_module: StemEx.CLI],
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      # DOCS
      name: "StemEx",
      source_url: "https://github.com/andyl/stem_ex",
      homepage_url: "https://github.com/andyl/stem_ex",
      docs: [
        #logo: "/path/to/logo",
        cannonical: "https://hexdocs/stem_ex",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    "Implementation of the Porter stemming algorithm."
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev}]
  end

  defp package do
    [
      name: :stem_ex,
      maintainers: ["AndyL"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/andyl/stem_ex"}
    ]
  end
end
