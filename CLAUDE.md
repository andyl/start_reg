# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

StepReg is a personal registry of installation **steps** and **starters** for
[starter](https://github.com/jamilabreu/starter) (and the related
[startpro](https://github.com/andyl/startpro)). It is not published on Hex; it
is consumed as a `only: :dev` git/path dependency by apps that use `starter`.

- **Steps**: self-contained Igniter mix tasks that each install/generate/remove one thing.
- **Starters**: ordered lists of steps (e.g. `StepReg.Starter.Base.steps/0`).

## Commands

```bash
mix deps.get
mix compile
mix test                               # all tests
mix test test/stepreg_test.exs:5       # single test by file:line
mix format
```

Requires Elixir `~> 1.20`. Steps can be exercised against a scratch app (one that
depends on this project) with `mix starter.add.ash`, `mix starterp.gen.mix_completions`, etc.

## Layout and conventions

Steps live under `lib/mix/tasks/` in two namespaces, each split into `add/`, `gen/`, `remove/`:

- `starter/` → `Mix.Tasks.Starter.{Add,Gen,Remove}.*` — general-purpose steps usable by anyone.
- `starterp/` → `Mix.Tasks.Starterp.{Add,Gen,Remove}.*` — **personal** steps that may use
  path deps or local executables and are not expected to work on other machines.

Each step is a module that `use Igniter.Mix.Task` and implements `igniter/1`, returning the
(modified) igniter. Include `@shortdoc`, `@moduledoc`, and reference URLs as comments. For
"add a hex dependency" steps, follow the existing pattern:

```elixir
{package, version} = Starter.Versions.latest_hex_dep(:ash)
Igniter.Project.Deps.add_dep(igniter, {package, version})
```

Naming matters: `starter` maps a step tuple like `{:add, :ash_phoenix}` to the module
`Mix.Tasks.Starter.Add.AshPhoenix` (underscored last segment). Note that
`Starter.Steps` discovery (`mix starter.add <name>`, `--list`) only scans modules in the
`:starter` application itself, so steps defined here are invoked as their own mix task
(`mix starter.add.ash`) or referenced by module in a starter's `steps/0` list. Avoid
naming a step the same as one already built into `deps/starter/lib/mix/tasks/starter/`.

The `Stepreg` module in `lib/step_reg.ex` and its test are leftover `mix new` scaffolding;
the project module is `Stepreg.MixProject`, while code modules use the `StepReg` casing.
