defmodule Mix.Tasks.StartReg.Add.Tidewave do
  @shortdoc "Add Tidewave"
  @moduledoc """
  Add `tidewave` as a dependency and run its Igniter installer
  (`mix tidewave.install`).

  References:

  - https://tidewave.ai/
  - https://tidewave.hexdocs.pm/welcome.html
  """

  use Igniter.Mix.Task

  alias StartReg.StepHelpers

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:tidewave)

    igniter
    |> Igniter.Project.Deps.add_dep({package, version, only: :dev})
    |> StepHelpers.fetch_dependencies("tidewave")
    |> Igniter.compose_task("tidewave.install", StepHelpers.argv(igniter))
  end
end
