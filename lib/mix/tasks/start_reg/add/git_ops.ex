defmodule Mix.Tasks.StartReg.Add.GitOps do
  @shortdoc "Add GitOps"
  @moduledoc """
  Add `git_ops` as a dependency (only: [:dev, test])

  Reference:

  - https://github.com/zachdaniel/git_ops

  """

  use Igniter.Mix.Task

  import StartReg.StepHelpers

  @package :git_ops

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    igniter
    |> add_package(@package, only: [:dev, :test])
    |> fetch_dependencies(@package)
    |> run_installer(@package)
  end
end
