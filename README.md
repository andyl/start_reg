# StartReg

A Step Registry for Elixir Starter 

- Parent Project: [starter](https://github.com/jamilabreu/starter)
- Related Project: [startpro](https://github.com/andyl/startpro) 

## Overview 

This project contains two types of assets:

- Steps - self-contained installation tasks 
- Starters - a list of steps 

These are built mostly for my own personal use and experimentation, not as a
public registry.  The steps under `mix/tasks/starter` should be useable by
anyone on any project.  The steps under `mix/tasks/starterp` are `personal`,
and might contain things like path dependencies and calls to local executables
that would not work on your local machine. But anyone is welcome to read reuse
anything as desired. 

## Installation 

This `start_reg` project is not published on Hex.  Add it next to `starter`
or optionally `startpro` as a dev-only dependency, from a local path or from github:

```
def deps do
  [
    {:starter, "~> 0.5", only: :dev},
    {:startpro, git: "https://github.com/andyl/startpro", only: :dev}, 
    {:start_reg, git: "https://github.com/andyl/start_reg", only: :dev}
  ]
end
```

