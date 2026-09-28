defmodule Mix.Tasks.StartReg.Add.LiveDebugger do
  @shortdoc "Add Live Debugger"
  @moduledoc """
  Add `live_debugger` as a dependency (only: [:dev, test])

  Reference:

  - https://live-debugger.hexdocs.pm/welcome.html
  - https://github.com/software-mansion/live-debugger

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :live_debugger

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package, only: [:dev, :test])
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
