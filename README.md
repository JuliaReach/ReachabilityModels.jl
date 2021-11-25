# Reachability Models: A repository of pre-made models for Reachability Analysis and Safety Verification

[![Build Status](https://github.com/JuliaReach/ReachabilityModels.jl/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/JuliaReach/ReachabilityModels.jl/actions/workflows/ci.yml?query=branch%3Amaster)
[![Docs latest](https://img.shields.io/badge/docs-latest-blue.svg)](http://juliareach.github.io/ReachabilityModels.jl/latest/)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/JuliaReach/ReachabilityModels.jl/blob/master/LICENSE.md)
[![Code coverage](http://codecov.io/github/JuliaReach/ReachabilityModels.jl/coverage.svg?branch=master)](https://codecov.io/github/JuliaReach/ReachabilityModels.jl?branch=master)
[![Join the chat at https://gitter.im/JuliaReach/Lobby](https://badges.gitter.im/JuliaReach/Lobby.svg)](https://gitter.im/JuliaReach/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Usage

```julia
using ReachabilityModels, Plots

prob = load_model("building") # initial-value problem

sol = solve(prob, T=5.0); # solve it using default options

plot(sol, vars=(0, 25)) # plot the solution
```

or

```julia
prob = load_model("lorenz") # initial-value problem

meta = load_meta("lorenz") # load meta-information of this model

opts = meta["opts"] # default options
sol = solve(prob; opts...);
```
