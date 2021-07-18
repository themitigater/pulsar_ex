defmodule PulsarEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :pulsar_ex,
      version: "0.1.2",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_paths: test_paths(Mix.env()),
      aliases: aliases(),
      package: package(),
      description: "Elixir client for Apache Pulsar, wrapped around erlang client pulserl"
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {PulsarEx.Application, []}
    ]
  end

  defp test_paths(:integration), do: ["test/integration"]
  defp test_paths(_), do: ["test/unit"]

  defp deps do
    [
      {:pulserl,
       git: "https://github.com/blueshift-labs/pulserl.git", tag: "0.1.3", only: [:dev, :test]},
      {:timex, "~> 3.0"},
      {:logger_json, "~> 4.0"},
      {:rec_struct, "~> 0.3.0"},
      {:telemetry, "~> 0.4"},
      {:credo, "~> 1.5", only: [:dev], runtime: false},
      {:divo, "~> 1.3", only: [:test, :integration], override: true},
      {:divo_pulsar,
       git: "https://github.com/blueshift-labs/divo_pulsar.git",
       tag: "0.2.1",
       only: [:test, :integration]},
      {:stream_data, "~> 0.5", only: [:test, :integration]},
      {:dialyxir, "~> 1.1.0", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      files: ~w(lib include .formatter.exs mix.exs README* LICENSE*),
      licenses: ~w(MIT),
      links: %{"GitHub" => "https://github.com/blueshift-labs/pulsar_ex"}
    ]
  end
end
