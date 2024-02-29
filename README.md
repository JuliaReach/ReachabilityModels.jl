# ReachabilityModels.jl

| **Documentation** | **Status** | **Community** | **License** |
|:-----------------:|:----------:|:-------------:|:-----------:|
| [![docs-dev][dev-img]][dev-url] | [![CI][ci-img]][ci-url] [![codecov][cov-img]][cov-url] [![aqua][aqua-img]][aqua-url] | [![zulip][chat-img]][chat-url] | [![license][lic-img]][lic-url] |

[dev-img]: https://img.shields.io/badge/docs-latest-blue.svg
[dev-url]: https://juliareach.github.io/ReachabilityModels.jl/dev/
[ci-img]: https://github.com/JuliaReach/ReachabilityModels.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/JuliaReach/ReachabilityModels.jl/actions/workflows/test-master.yml
[cov-img]: https://codecov.io/github/JuliaReach/ReachabilityModels.jl/coverage.svg
[cov-url]: https://app.codecov.io/github/JuliaReach/ReachabilityModels.jl
[aqua-img]: https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg
[aqua-url]: https://github.com/JuliaTesting/Aqua.jl
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
