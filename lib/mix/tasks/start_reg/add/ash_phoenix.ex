defmodule Mix.Tasks.StartReg.Add.AshPhoenix do
  @shortdoc "Add AshPhoenix"
  @moduledoc """
  Add `ash_phoenix` as a dependency and run its Igniter installer
  (`mix ash_phoenix.install`).

  References:

  - https://ash-phoenix.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash_phoenix
  """

  use Igniter.Mix.Task

  alias StartReg.StepHelpers

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash_phoenix)

    igniter
    |> Igniter.Project.Deps.add_dep({package, version})
    |> StepHelpers.fetch_dependencies("ash_phoenix")
    |> Igniter.compose_task("ash_phoenix.install", igniter.args.argv)
  end
end
