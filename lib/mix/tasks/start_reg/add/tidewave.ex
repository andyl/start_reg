defmodule Mix.Tasks.StartReg.Add.Tidewave do
  @shortdoc "Add Tidewave"
  @moduledoc """
  Add `tidewave` as a dependency and run its Igniter installer
  (`mix tidewave.install`).

  References:

  - https://tidewave.ai/
  - https://tidewave.hexdocs.pm/welcome.html
  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :tidewave

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package, only: :dev)
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
