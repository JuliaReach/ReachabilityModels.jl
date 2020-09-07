# ReachabilityModels

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliareach.github.io/ReachabilityModels.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliareach.github.io/ReachabilityModels.jl/dev)
[![Build Status](https://travis-ci.com/juliareach/ReachabilityModels.jl.svg?branch=master)](https://travis-ci.com/juliareach/ReachabilityModels.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/juliareach/ReachabilityModels.jl?svg=true)](https://ci.appveyor.com/project/juliareach/ReachabilityModels-jl)

## Usage

```julia
using ReachabilityModels, Plots

prob = fetch_model("building") # initial-value problem

sol = solve(prob, T=5.0); # solve it using default options

plot(sol, vars=(0, 25)) # plot the solution
```

or


```julia
prob = fetch_model("lorenz") # initial-value problem

meta = fetch_meta("lorenz") # load meta-information of this model

opts = meta["opts"] # default options
sol = solve(prob; opts...);
```

## Filtering models
