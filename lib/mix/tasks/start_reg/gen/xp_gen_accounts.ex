defmodule Mix.Tasks.StartReg.Gen.XpGenAccounts do
  @shortdoc "Generate Account resources for User"
  @moduledoc """
  Generate Account resources for user

  Run after `start_reg.add.ash_authentication` and
  `start_reg.add.ash_authentication_phoenix`. Updates `$APP.Accounts.User`,
  seeds a user, and migrates, equivalent to:

      mix ash.gen.resource $APP.Accounts.User --uuid-v7-primary-key id \\
        -a username:ci_string -a slug:ci_string -t --conflicts replace --yes
      mix ash.codegen add_user_uuidv7_username_slug
      mix ash.reset
      mix run priv/repo/seeds.exs

  The seeded users are `a@a.com`, `b@b.com` and `c@c.com`, each with password
  `12345678`.

  References:

  - https://hexdocs.pm/ash/Mix.Tasks.Ash.Gen.Resource.html
  - https://hexdocs.pm/ash/Ash.Seed.html
  - https://hexdocs.pm/igniter/Igniter.html#add_task/3

  """

  use Igniter.Mix.Task

  @seeds_file "priv/repo/seeds.exs"
  @emails ["a@a.com", "b@b.com", "c@c.com"]
  @password "12345678"

  @impl Igniter.Mix.Task
  def info(_argv, _composing_task) do
    %Igniter.Mix.Task.Info{composes: ["ash.gen.resource"]}
  end

  @impl Igniter.Mix.Task
  def igniter(igniter) do
    user_module = Igniter.Project.Module.module_name(igniter, "Accounts.User")

    igniter
    |> Igniter.compose_task("ash.gen.resource", [
      inspect(user_module),
      "--uuid-v7-primary-key",
      "id",
      "--attribute",
      "username:ci_string,slug:ci_string",
      "--timestamps",
      "--conflicts",
      "replace"
    ])
    |> add_seed(user_module)
    |> Igniter.add_task("ash.codegen", ["add_user_uuidv7_username_slug"])
    |> Igniter.add_task("ash.reset")
    |> Igniter.add_task("run", [@seeds_file])
  end

  # Igniter runs queued tasks as `mix <task> <args joined by spaces>` with no
  # shell quoting, so `mix run -e "..."` can't be queued. The seed goes in
  # seeds.exs instead, which also re-seeds after `mix ecto.reset`.
  #
  # upsert! (rather than seed!) keeps seeds.exs re-runnable; `:unique_email`
  # is the identity the ash_authentication password strategy adds.
  defp add_seed(igniter, user_module) do
    seeds = Enum.map(@emails, &{&1, seed(user_module, &1)})

    Igniter.create_or_update_file(
      igniter,
      @seeds_file,
      Enum.map_join(seeds, &elem(&1, 1)),
      fn source ->
        Rewrite.Source.update(source, :content, fn content ->
          missing =
            for {email, seed} <- seeds, !String.contains?(content, inspect(email)), do: seed

          content <> Enum.join(missing)
        end)
      end
    )
  end

  defp seed(user_module, email) do
    """

    Ash.Seed.upsert!(
      #{inspect(user_module)},
      %{email: #{inspect(email)}, hashed_password: Bcrypt.hash_pwd_salt(#{inspect(@password)})},
      identity: :unique_email
    )
    """
  end
end
