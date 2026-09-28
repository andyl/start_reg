defmodule StartReg.StepHelpers do
  @moduledoc """
  Helpers shared by StartReg steps.

  Steps always run unattended: every prompt is answered "yes", whether or
  not `--yes` was passed on the command line, so a starter can run start to
  finish without stopping for input.
  """

  @doc """
  Write pending changes and fetch/compile dependencies, so that a freshly
  added dependency's installer can then be run with `Igniter.compose_task/3`.

  `name` is used in the "compiling <name>" progress message. The dependency
  confirmation prompt is always skipped.

  apply_and_fetch_dependencies/2 raises under Igniter.Test, so in test mode
  the igniter is returned unchanged and tests only see the dep being added.
  """
  def fetch_dependencies(igniter, name) do
    if igniter.assigns[:test_mode?] do
      igniter
    else
      Igniter.apply_and_fetch_dependencies(igniter,
        operation: "compiling #{name}",
        yes: true,
        yes_to_deps: true
      )
    end
  end

  @doc """
  The igniter's argv with `--yes` guaranteed, for passing to
  `Igniter.compose_task/3` so composed installers never prompt.
  """
  def argv(igniter) do
    argv =
      case igniter.args do
        %{argv: argv} when is_list(argv) -> argv
        _ -> []
      end

    if "--yes" in argv, do: argv, else: argv ++ ["--yes"]
  end
end
