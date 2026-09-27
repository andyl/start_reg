defmodule Mix.Tasks.StartReg.Add.AshPostgres do
  @shortdoc "Add AshPostgres"
  @moduledoc """
  Add `ash_postgres` as a dependency.

  Referencees:

  - https://ash-postgres.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash_postgres
  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash_postgres)

    Igniter.Project.Deps.add_dep(igniter, {package, version})
  end
end
