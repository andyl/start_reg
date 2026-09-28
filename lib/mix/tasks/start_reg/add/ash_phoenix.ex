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

  import StartReg.StepHelpers

  @package :ash_phoenix

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
