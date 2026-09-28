defmodule Mix.Tasks.StartReg.Add.AshTui do
  @shortdoc "Add AshTui"
  @moduledoc """
  Add `ash_tui` as a dependency
  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :ash_tui

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    add_package(igniter, @package)
  end
end
