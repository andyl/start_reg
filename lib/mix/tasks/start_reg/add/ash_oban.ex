defmodule Mix.Tasks.StartReg.Add.AshOban do
  @shortdoc "Add AshOban"
  @moduledoc """
  Add `ash_oban` as a dependency and run its Igniter installer
  (`mix ash_oban.install`).

  Reference:

  - https://github.com/ash-project/ash_oban
  - https://ash-oban.hexdocs.pm/readme.html

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash_oban

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
