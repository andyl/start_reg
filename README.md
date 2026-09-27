# Stepreg

A Step Registry for Elixir Starter 

- Parent Project: [starter](https://github.com/jamilabreu/starter)
- Related Project: [startpro](https://github.com/andyl/startpro) 

## Overview 

This project contains two types of assets:

- Steps - self-contained installation tasks 
- Starters - a list of steps 

These are build for my own personal use and experimentation, not as a public
registry.  But anyone is welcome to reuse as desired. 

## Installation 

This `stepreg` project is not published on Hex.  Add it next to `starter`
or optionally `startpro` as a dev-only dependency, from a local path or from github:

```
def deps do
  [
    {:starter, "~> 0.5", only: :dev},
    {:startpro, git: "https://github.com/andyl/startpro", only: :dev}, 
    {:startpro, git: "https://github.com/andyl/stepreg", only: :dev}
  ]
end
```

