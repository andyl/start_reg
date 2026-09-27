# StartReg

A Registry for Elixir Starter 

- Parent Project: [starter](https://github.com/jamilabreu/starter)
- Related Project: [start_pro](https://github.com/andyl/start_pro) 

## Overview 

This project contains two types of assets:

- Steps - self-contained app-=config tasks 
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
    {:startpro, git: "https://github.com/andyl/startpro", only: :dev}, 
    {:start_reg, git: "https://github.com/andyl/start_reg", only: :dev}
  ]
end
```

## Using StartReg Steps 

CLAUDE: describe how to use steps, as mix tasks, and as module entries in a starter profile.

