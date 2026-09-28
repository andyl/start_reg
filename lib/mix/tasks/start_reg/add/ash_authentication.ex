defmodule Mix.Tasks.StartReg.Add.AshAuthentication do
  @shortdoc "Add AshAuthentication"
  @moduledoc """
  Add `ash_authentication` as a dependency and run its Igniter installer
  with the password strategy, equivalent to:

      mix igniter.install ash_authentication --auth-strategy password --yes

  References:

  - https://ash-authentication.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash_authentication
  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash_authentication

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package, ["--auth-strategy", "password"])
  end
end

