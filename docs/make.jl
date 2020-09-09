using Documenter, ReachabilityModels

DocMeta.setdocmeta!(ReachabilityModels, :DocTestSetup, :(using ReachabilityModels); recursive=true)

# Generate notebooks
include("generate.jl")

# Generate bibliography
#include("bibliography.jl")

makedocs(
    sitename = "Reachability Models",
    modules = [ReachabilityModels],
    format = Documenter.HTML(prettyurls = haskey(ENV, "GITHUB_ACTIONS"),  # disable for local builds
                             collapselevel = 1,
                             assets = ["assets/juliareach-light.css"]),
    pages = [
        "Home" => "index.md",
        "Usage" => "usage.md",
        "Linear ODEs" => Any["Helicopter" =>  "models/helicopter.md"],
        "Nonlinear ODEs" => Any["Lorenz" => "models/lorenz.md"],
        "Hybrid ODEs" => Any["Bouncing ball" => "models/bouncing_ball_nonlinear.md"],
        "References" => "references.md",
        "About" => "about.md"
    ],
    strict = false
)

deploydocs(
    repo = "github.com/JuliaReach/ReachabilityModels.jl",
    push_preview=true
)
