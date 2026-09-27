# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

StartReg is a personal registry of installation **steps** and **starters** for
[starter](https://github.com/jamilabreu/starter) (and the related
[startpro](https://github.com/andyl/startpro)). It is not published on Hex; it
is consumed as a `only: :dev` git/path dependency by apps that use `starter`.

- **Steps**: self-contained Igniter mix tasks that each install/generate/remove one thing.
- **Starters**: ordered lists of steps (e.g. `StartReg.Starter.Base.steps/0`).

## Commands

```bash
mix deps.get
mix compile
mix test                               # all tests
mix test test/start_reg_test.exs:5     # single test by file:line
mix format
```

Requires Elixir `~> 1.20`. Steps can be exercised against a scratch app (one that
depends on this project) with `mix start_reg.add.ash`, `mix start_reg.gen.xp_mix_completions`, etc.

## Layout and conventions

Steps live under `lib/mix/tasks/start_reg/`, split into `add/`, `gen/`, `remove/`, as modules
`Mix.Tasks.StartReg.{Add,Gen,Remove}.*` (run as `mix start_reg.add.<name>`, etc.).

Steps whose name begins with `xp_` (e.g. `Mix.Tasks.StartReg.Gen.XpMixCompletions`) are
**experimental/personal**: they may use path deps or local executables and are not expected
to work on other machines.

Each step is a module that `use Igniter.Mix.Task` and implements `igniter/1`, returning the
(modified) igniter. Include `@shortdoc`, `@moduledoc`, and reference URLs as comments. For
"add a hex dependency" steps, follow the existing pattern:

```elixir
{package, version} = Starter.Versions.latest_hex_dep(:ash)
Igniter.Project.Deps.add_dep(igniter, {package, version})
```

StartReg steps are never reached through step tuples: `starter` maps `{:add, :ash}` to its
own built-in step or the package's upstream installer. `Starter.Steps` discovery
(`mix starter.add <name>`, `--list`) only scans the `:starter` application, so steps defined
here are invoked as their own mix task (`mix start_reg.add.ash`) or referenced by module in a
starter's `steps/0` list (`Mix.Tasks.StartReg.Add.Ash` or `{Mix.Tasks.StartReg.Add.Ash, if: :flag}`).

Starters live in `lib/start_reg/starter/` as `StartReg.Starter.*` modules. Each must
`use Starter` and implement `@impl Starter def steps/0`; `use Starter` defines
`__starter__?/0`, which `mix starter.new --from StartReg.Starter.Base` requires. Apps can
also include one with `{:starter, StartReg.Starter.Base}`.

The `StartReg` module in `lib/start_reg.ex` and its test are leftover `mix new` scaffolding;
all modules (including `StartReg.MixProject`) use the `StartReg` casing.
