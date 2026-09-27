defmodule Mix.Tasks.Starterp.Gen.MixCompletions do
  @shortdoc "Generates mix completions"
  @moduledoc """
  Generates mix completions

  References
  - https://erikarow.land/articles/mix-completions
  - https://github.com/erikareads/mix_completions
  """

  use Igniter.Mix.Task

  @impl Igniter.Mix.Task
  def igniter(_igniter) do
    # CLAUDE: please fill in this block.  It should:
    # 1) check that mix completions are installed in the 'global' mix namespace
    # 2) install it if is not there (mix archive.install hex mix_completions)
    # 3) run the bash command "mix complete.bash"
  end
end
