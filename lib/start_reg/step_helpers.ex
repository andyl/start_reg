defmodule StartReg.StepHelpers do
  @moduledoc """
  Helpers shared by StartReg steps.

  A package step names its package once, as an atom, and pipes through:

      import StartReg.StepHelpers

      @package :ash

      igniter
      |> add_package(@package)
      |> fetch_dependencies(@package)
      |> run_installer(@package)

  Steps always run unattended: every prompt is answered "yes", whether or
  not `--yes` was passed on the command line, so a starter can run start to
  finish without stopping for input.
  """

  @doc """
  Add the latest hex version of `package` to mix.exs.

  `opts` are dependency options, e.g. `only: :dev`.
  """
  def add_package(igniter, package, opts \\ []) do
    {package, version} = Starter.Versions.latest_hex_dep(package)

    dep = if opts == [], do: {package, version}, else: {package, version, opts}

    Igniter.Project.Deps.add_dep(igniter, dep)
  end

  @doc """
  Write pending changes and fetch/compile dependencies, so that a freshly
  added dependency's installer can then be run with `run_installer/2`.

  The dependency confirmation prompt is always skipped.

  apply_and_fetch_dependencies/2 raises under Igniter.Test, so in test mode
  the igniter is returned unchanged and tests only see the dep being added.
  """
  def fetch_dependencies(igniter, package) do
    if igniter.assigns[:test_mode?] do
      igniter
    else
      Igniter.apply_and_fetch_dependencies(igniter,
        operation: "compiling #{package}",
        yes: true,
        yes_to_deps: true
      )
    end
  end

  @doc """
  Compose `package`'s Igniter installer (`mix <package>.install`), passing
  the igniter's argv with `--yes` guaranteed so the installer never prompts.

  Call `fetch_dependencies/2` first, so the installer task is available.
  """
  def run_installer(igniter, package) do
    Igniter.compose_task(igniter, "#{package}.install", argv(igniter))
  end

  defp argv(igniter) do
    argv =
      case igniter.args do
        %{argv: argv} when is_list(argv) -> argv
        _ -> []
      end

    if "--yes" in argv, do: argv, else: argv ++ ["--yes"]
  end
end
