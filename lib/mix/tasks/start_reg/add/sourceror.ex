defmodule Mix.Tasks.StartReg.Add.Sourceror do
  @shortdoc "Add Sourceror"
  @moduledoc """
  Add `sourceror` as a dependency

  Reference:

  - https://github.com/doorgan/sourceror

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :sourceror

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    add_package(igniter, @package)
  end
end
