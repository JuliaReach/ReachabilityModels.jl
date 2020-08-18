# ReachabilityModels

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://mforets.github.io/ReachabilityModels.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://mforets.github.io/ReachabilityModels.jl/dev)
[![Build Status](https://travis-ci.com/mforets/ReachabilityModels.jl.svg?branch=master)](https://travis-ci.com/mforets/ReachabilityModels.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/mforets/ReachabilityModels.jl?svg=true)](https://ci.appveyor.com/project/mforets/ReachabilityModels-jl)
[![Codecov](https://codecov.io/gh/mforets/ReachabilityModels.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/mforets/ReachabilityModels.jl)



## Usage

```julia
using ReachabilityModels, ReachabilityAnalysis, Plots

model = models["vanderpol"]

prob = model["ivp"] # initial-value problem
opts = model["options"] # default options

sol = solve(prob, opts);
solz = overapproximate(sol, Zonotope)

plot(sol, vars=(1, 2))
```
