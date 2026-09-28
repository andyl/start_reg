defmodule Mix.Tasks.StartReg.Add.Sourceror do
  @shortdoc "Add Sourceror"
  @moduledoc """
  Add `sourceror` as a dependency
  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:sourceror)

    igniter
    |> Igniter.Project.Deps.add_dep({package, version})
  end
end
