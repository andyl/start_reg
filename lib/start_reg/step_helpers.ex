defmodule StartReg.StepHelpers do
  @moduledoc """
  Helpers shared by StartReg steps.
  """

  @doc """
  Write pending changes and fetch/compile dependencies, so that a freshly
  added dependency's installer can then be run with `Igniter.compose_task/3`.

  `name` is used in the "compiling <name>" progress message.

  apply_and_fetch_dependencies/2 raises under Igniter.Test, so in test mode
  the igniter is returned unchanged and tests only see the dep being added.
  """
  def fetch_dependencies(igniter, name) do
    if igniter.assigns[:test_mode?] do
      igniter
    else
      argv = igniter.args.argv

      Igniter.apply_and_fetch_dependencies(igniter,
        operation: "compiling #{name}",
        yes: "--yes" in argv,
        yes_to_deps: "--yes-to-deps" in argv
      )
    end
  end
end
