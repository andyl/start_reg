defmodule Mix.Tasks.StartReg.Add.Ash do
  @shortdoc "Add Ash"
  @moduledoc """
  Add `ash` as a dependency and run its Igniter installer
  (`mix ash.install`).

  Reference:

  - https://ash-hq.org/
  - https://ash.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
