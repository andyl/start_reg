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
    case ensure_archive_installed() do
      :ok -> generate_completions(igniter)
      {:error, issue} -> Igniter.add_issue(igniter, issue)
    end
  end

  # Archives are loaded into the code path when mix starts, so an installed
  # mix_completions archive makes the `complete.bash` task resolvable.
  defp ensure_archive_installed do
    if Mix.Task.get("complete.bash") do
      :ok
    else
      install_archive()
    end
  end

  # Installs synchronously in a separate mix process, so the archive is
  # available to the `mix complete.bash` call that follows.
  defp install_archive do
    Mix.shell().info("Installing mix_completions archive...")

    case System.cmd("mix", ["archive.install", "hex", "mix_completions", "--force"],
           stderr_to_stdout: true
         ) do
      {_output, 0} ->
        :ok

      {output, status} ->
        {:error, "`mix archive.install hex mix_completions` failed (exit #{status}):\n#{output}"}
    end
  end

  defp generate_completions(igniter) do
    case System.cmd("mix", ["complete.bash"], stderr_to_stdout: true) do
      {output, 0} ->
        igniter
        |> Igniter.create_or_update_file(@completions_file, output, fn source ->
          Rewrite.Source.update(source, :content, fn _ -> output end)
        end)
        |> Igniter.add_notice("""
        mix completions are installed in #{@completions_file}
        """)

      {output, status} ->
        Igniter.add_issue(igniter, "`mix complete.bash` failed (exit #{status}):\n#{output}")
    end
  end
end
