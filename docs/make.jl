using Documenter, ReachabilityModels

makedocs(;
    modules=[ReachabilityModels],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/mforets/ReachabilityModels.jl/blob/{commit}{path}#L{line}",
    sitename="ReachabilityModels.jl",
    authors="Marcelo Forets",
    assets=String[],
)

deploydocs(;
    repo="github.com/mforets/ReachabilityModels.jl",
)
