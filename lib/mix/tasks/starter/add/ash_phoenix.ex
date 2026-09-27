defmodule Mix.Tasks.Starter.Add.AshPhoenix do
  @shortdoc "Adds AshPhoenix"
  @moduledoc "Adds `ash_phoenix` as a dependency."

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash_phoenix)

    Igniter.Project.Deps.add_dep(igniter, {package, version})
  end
end
