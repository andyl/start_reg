defmodule Mix.Tasks.StartReg.Add.AshPostgres do
  @shortdoc "Add AshPostgres"
  @moduledoc """
  Add `ash_postgres` as a dependency and run its Igniter installer
  (`mix ash_postgres.install`).

  References:

  - https://ash-postgres.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash_postgres
  """

  use Igniter.Mix.Task

  alias StartReg.StepHelpers

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash_postgres)

    igniter
    |> Igniter.Project.Deps.add_dep({package, version})
    |> StepHelpers.fetch_dependencies("ash_postgres")
    |> Igniter.compose_task("ash_postgres.install", igniter.args.argv)
  end
end
