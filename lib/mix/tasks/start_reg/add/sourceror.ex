defmodule Mix.Tasks.StartReg.Add.Sourceror do
  @shortdoc "Add Sourceror"
  @moduledoc """
  Add `sourceror` as a dependency
  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :sourceror

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    add_package(igniter, @package)
  end
end
