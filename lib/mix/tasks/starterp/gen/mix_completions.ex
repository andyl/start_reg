defmodule Mix.Tasks.Starterp.Gen.MixCompletions do
  @shortdoc "Generates mix completions"
  @moduledoc """
  Generates mix completions

  References:

  - https://erikarow.land/articles/mix-completions
  - https://github.com/erikareads/mix_completions
  """

  use Igniter.Mix.Task

  @completions_file ".mix_completions.bash"

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    if archive_installed?() do
      generate_completions(igniter)
    else
      igniter
      |> Igniter.add_task("archive.install", ["hex", "mix_completions", "--force"])
      |> Igniter.add_notice("""
      mix_completions archive will be installed.
      Re-run `mix starterp.gen.mix_completions` to generate #{@completions_file}.
      """)
    end
  end

  # Archives are loaded into the code path when mix starts, so an installed
  # mix_completions archive makes the `complete.bash` task resolvable.
  defp archive_installed? do
    Mix.Task.get("complete.bash") != nil
  end

  defp generate_completions(igniter) do
    case System.cmd("mix", ["complete.bash"], stderr_to_stdout: true) do
      {output, 0} ->
        igniter
        |> Igniter.create_or_update_file(@completions_file, output, fn source ->
          Rewrite.Source.update(source, :content, fn _ -> output end)
        end)
        |> Igniter.add_notice("""
        To enable mix completions, add this to your ~/.bashrc:

            source #{Path.expand(@completions_file)}
        """)

      {output, status} ->
        Igniter.add_issue(igniter, "`mix complete.bash` failed (exit #{status}):\n#{output}")
    end
  end
end
