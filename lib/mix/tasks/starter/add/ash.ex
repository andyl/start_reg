defmodule Mix.Tasks.Starter.Add.Ash do
  @shortdoc "Adds Ash"
  @moduledoc "Adds `ash` as a dependency."

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash)

    Igniter.Project.Deps.add_dep(igniter, {package, version})
  end
end
