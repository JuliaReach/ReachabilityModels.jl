# ReachabilityModels.jl

| **Documentation** | **Community** | **License** |
|:-----------------:|:-------------:|:-----------:|
| [![docs-dev][dev-img]][dev-url] | [![zulip][chat-img]][chat-url] | [![license][lic-img]][lic-url] |

[dev-img]: https://img.shields.io/badge/docs-latest-blue.svg
[dev-url]: https://juliareach.github.io/ReachabilityModels.jl/dev/
[chat-img]: https://img.shields.io/badge/zulip-join_chat-brightgreen.svg
[chat-url]: https://julialang.zulipchat.com/#narrow/stream/278609-juliareach
[lic-img]: https://img.shields.io/github/license/mashape/apistatus.svg
[lic-url]: https://github.com/JuliaReach/ReachabilityModels.jl/blob/master/LICENSE

A repository of models for reachability analysis and safety verification

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
