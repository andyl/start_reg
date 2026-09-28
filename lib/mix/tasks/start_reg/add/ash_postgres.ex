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

  import StartReg.StepHelpers

  @package :ash_postgres

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
