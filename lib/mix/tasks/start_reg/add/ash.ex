defmodule Mix.Tasks.StartReg.Add.Ash do
  @shortdoc "Add Ash"
  @moduledoc """
  Add `ash` as a dependency and run its Igniter installer
  (`mix ash.install`).

  References:

  - https://ash-hq.org/
  - https://ash.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash
  """

  use Igniter.Mix.Task

  alias StartReg.StepHelpers

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash)

    igniter
    |> Igniter.Project.Deps.add_dep({package, version})
    |> StepHelpers.fetch_dependencies("ash")
    |> Igniter.compose_task("ash.install", StepHelpers.argv(igniter))
  end
end
