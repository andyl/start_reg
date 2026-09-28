defmodule Mix.Tasks.StartReg.Add.UsageRules do
  @shortdoc "Add UsageRules"
  @moduledoc """
  Add `usage_rules` as a dependency, and configure it in `mix.exs`.

  `mix usage_rules.sync` refuses to run without a `:usage_rules` key in
  `project/0`, so this step injects:

      def project do
        [
          ...
          usage_rules: usage_rules()
        ]
      end

      defp usage_rules do
        [
          file: "RULES.md",
          usage_rules: :all
        ]
      end

  It then runs `mix usage_rules.sync`, which writes the rules to `RULES.md`.

  Generally: you want to run this step towards the end of your starter.

  References:

  - https://github.com/ash-project/usage_rules
  - https://usage-rules.hexdocs.pm/readme.html
  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :usage_rules

  @usage_rules_defp """
  defp usage_rules do
    [
      file: "RULES.md",
      usage_rules: :all
    ]
  end
  """

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package, only: [:dev, :test])
    |> Igniter.update_elixir_file("mix.exs", &add_usage_rules_defp/1)
    |> Igniter.Project.MixProject.update(:project, [:usage_rules], fn
      nil -> {:ok, {:code, quote(do: usage_rules())}}
      zipper -> {:ok, zipper}
    end)
    # Queued tasks run in a separate `mix` process, after mix.exs is written
    # and `mix deps.get` has run, so sync sees the new config.
    |> Igniter.add_task("#{@package}.sync", ["--yes"])
  end

  # Append `defp usage_rules/0` to the MixProject module, unless it already exists.
  defp add_usage_rules_defp(zipper) do
    with {:ok, zipper} <- Igniter.Code.Module.move_to_defmodule(zipper),
         {:ok, zipper} <- Igniter.Code.Common.move_to_do_block(zipper) do
      case Igniter.Code.Function.move_to_defp(zipper, :usage_rules, 0) do
        {:ok, _} -> {:ok, zipper}
        :error -> {:ok, Igniter.Code.Common.add_code(zipper, @usage_rules_defp)}
      end
    else
      :error -> {:error, "Unable to find the MixProject module in mix.exs"}
    end
  end
end

# CLAUDE:
# When this runs, it generates an annoying prompt:
#
# How would you like to proceed?
# 0. Proceed *without* viewing changes. (default)
# 1. Display the diff inline anyway.
# 2. Write to `.igniter` so you can preview all of the changes, and wait to proceed.
# Input number ❯  0
#
# I solved this in the past by using "echo 0 | mix usage_rules.sync".
# Can this work here?  Is there a usage rules option to force selection of the default option?
# I want to run end-to-end unattended.
