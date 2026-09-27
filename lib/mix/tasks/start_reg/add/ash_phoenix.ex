defmodule Mix.Tasks.StartReg.Add.AshPhoenix do
  @shortdoc "Add AshPhoenix"
  @moduledoc """
  Add `ash_phoenix` as a dependency.

  Referencees:

  - https://ash-phoenix.hexdocs.pm/readme.html
  - https://github.com/ash-project/ash_phoenix
  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    {package, version} = Starter.Versions.latest_hex_dep(:ash_phoenix)

    Igniter.Project.Deps.add_dep(igniter, {package, version})
  end
end
