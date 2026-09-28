defmodule Mix.Tasks.StartReg.Add.AshAdmin do
  @shortdoc "Add AshAdmin"
  @moduledoc """
  Add `ash_admin` as a dependency and run its Igniter installer
  (`mix ash_admin.install`).

  Reference:

  - https://github.com/ash-project/ash_admin
  - https://ash-admin.hexdocs.pm/readme.html

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash_admin

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
