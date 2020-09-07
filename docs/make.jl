using Documenter, ReachabilityModels

DocMeta.setdocmeta!(ReachabilityModels, :DocTestSetup, :(using ReachabilityModels); recursive=true)

# Generate notebooks
#include("generate.jl")

# Generate bibliography
#include("bibliography.jl")

makedocs(
    sitename = "Reachability Models",
    modules = [ReachabilityModels],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
        "Home" => "index.md",
        "Usage" => "usage.md",
        #"Linear ODEs" => Any["Helicopter" =>  "models/helicopter.md"],
        #"Nonlinear ODEs" => Any["Lorenz" => "models/lorenz.md"],
        #"Hybrid ODEs" => Any["Bouncing ball" => "models/bouncing_ball.md"],
        "References" => "references.md",
        "About" => "about.md"
    ],
    strict = false
)

deploydocs(
    repo = "github.com/JuliaReach/ReachabilityModels.jl",
    push_preview=true
)
