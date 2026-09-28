defmodule Mix.Tasks.StartReg.Add.AshAi do
  @shortdoc "Add AshAi"
  @moduledoc """
  Add `ash_ai` as a dependency and run its Igniter installer
  (`mix ash_ai.install`).

  Reference:

  - https://github.com/ash-project/ash_ai
  - https://ash-ai.hexdocs.pm/readme.html

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash_ai

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
