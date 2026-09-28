# StartReg

A Registry for Elixir Starter 

- Parent Project: [starter](https://github.com/jamilabreu/starter)
- Related Project: [start_pro](https://github.com/andyl/start_pro) 

## Overview 

This project contains two types of assets:

- Steps - self-contained app-config tasks 
- Starters - a list of steps 

These are built mostly for my own personal use and experimentation, not as a
public registry.  Step names that begin with "xp_" are experimental, with path
and executable dependencies such that they probably will not work on 3rd party
hosts. Anyone is welcome to read reuse anything as desired. 

## Installation 

This `start_reg` project is not published on Hex.  Add it next to `starter`
or optionally `startpro` as a dev-only dependency, from a local path or from github:

```
def deps do
  [
    {:starter, "~> 0.5", only: :dev},
    {:start_pro, git: "https://github.com/andyl/start_pro", only: :dev},
    {:start_reg, git: "https://github.com/andyl/start_reg", only: :dev}
  ]
end
```

## Using StartReg Steps 

Each StartReg step is an Igniter mix task under the `start_reg` namespace
(`lib/mix/tasks/start_reg/{add,gen,remove}/`). You can use a step in three
ways: run it as a mix task, list its module in a starter, or name it with a
`from: StartReg` tuple in a `start_pro` profile.

### As mix tasks

Every step is a mix task you can run by itself in the host app:

```bash
mix start_reg.add.ash
mix start_reg.add.ash_phoenix
mix start_reg.gen.xp_mix_completions
```

The task name comes from the module name: `Mix.Tasks.StartReg.Add.AshPhoenix`
becomes `mix start_reg.add.ash_phoenix`. Like all Igniter tasks, a step shows
a diff and asks you to confirm before it writes anything. Pass `--yes` to
skip the prompt in a script or CI.

Run `mix help | grep start_reg` to list the available steps.

Note that `mix starter.add <name>`, `mix starter.gen <name>` and
`mix starter.add --list` only find steps built into `starter`. They do not
find StartReg steps.

### As module entries in a starter

In a starter's `steps/0` list, refer to a StartReg step by its module name.
Plain `starter` has no tuple form for StartReg steps: `{:add, :ash}` goes to
`starter`'s own step or to the package's upstream installer, never to
StartReg. The shorter `from:` tuple below works only in `start_pro` profiles.

```elixir
defmodule Mix.Tasks.MyApp.Starter do
  use Starter

  @impl Starter
  def steps do
    [
      {:remove, :daisy_ui},                           # built-in starter step
      Mix.Tasks.StartReg.Add.Ash,                     # StartReg step
      Mix.Tasks.StartReg.Add.AshPhoenix,
      {Mix.Tasks.StartReg.Gen.XpMixCompletions, if: :completions}  # only with --completions
    ]
  end
end
```

Module entries run in list order along with the other steps, and all their
changes appear in the same diff. A module entry can take options as a
`{Module, opts}` tuple. `if: :flag` makes the step run only when you pass
`--flag` to `mix starter.run`.

### As tuples in a start_pro profile

[start_pro](https://github.com/andyl/start_pro) profiles accept a shorter
tuple form. Name the step by kind and name, and add `from: StartReg`:

```elixir
# ~/.config/start_pro/profiles.exs
[
  ash_app: [
    {:remove, :daisy_ui},                                          # built-in starter step
    {:add, :ash, from: StartReg},                                  # Mix.Tasks.StartReg.Add.Ash
    {:add, :ash_phoenix, from: StartReg},                          # Mix.Tasks.StartReg.Add.AshPhoenix
    {:gen, :xp_mix_completions, from: StartReg, if: :completions}  # only with --completions
  ]
]
```

```bash
mix start_pro.run ash_app --completions
```

The tuple `{kind, :name, from: StartReg}` names the module
`Mix.Tasks.StartReg.<Kind>.<Name>`:

- The kind is `:add`, `:gen` or `:remove`, one for each step directory.
- The name is camelized, so `:ash_phoenix` becomes `AshPhoenix`.
- `from:` is required. Without it, `{:add, :ash}` is an ordinary `starter`
  step and does not reach StartReg.
- Write `from: StartReg` as a module, not as an atom like `:start_reg`.
- `if: :flag` works as it does on any other step.

`start_pro` translates the tuple to the module just before it runs the
steps. `mix start_pro.list.steps` and the run's commit message show the step
as you wrote it. If `start_reg` isn't a dependency of the app, or no step has
that name, `mix start_pro.run` stops before it changes anything and names the
step.

Use this form only in `start_pro` profiles. `starter` does not understand
`from:`, so starter modules, including the ones in `lib/start_reg/starter/`,
must keep the full module names.

### Using a StartReg starter

The starters in `lib/start_reg/starter/` (such as `StartReg.Starter.Base`)
are lists of steps that you can reuse in two ways.

Include one inside your own starter. Its steps are expanded in place:

```elixir
def steps do
  [
    {:starter, StartReg.Starter.Base},
    {:add, :credo}
  ]
end
```

Or generate a new app's starter from one. The steps are copied into the
generated file, so you can edit them there:

```bash
mix starter.new --from StartReg.Starter.Base
```

