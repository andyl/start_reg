defmodule Mix.Tasks.StartReg.Add.Tidewave do
  @shortdoc "Add Tidewave"
  @moduledoc """
  Add `tidewave` as a dependency.

  References:

  - https://tidewave.ai/
  - https://tidewave.hexdocs.pm/welcome.html
  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:tidewave)

    Igniter.Project.Deps.add_dep(igniter, {package, version})
  end
end
