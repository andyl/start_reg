defmodule Mix.Tasks.StartReg.Add.AshAuthenticationPhoenix do
  @shortdoc "Add AshAuthenticationPhoenix"
  @moduledoc """
  Add `ash_authentication_phoenix` as a dependency and run its Igniter installer

  References:

  - https://ash-authentication-phoenix.hexdocs.pm/readme.html
  - https://github.com/team-alembic/ash_authentication_phoenix

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash_authentication_phoenix

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package, ["--auth-strategy", "password"])
  end
end
