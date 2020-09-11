using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.05)),
    "X0"   => Hyperrectangle(low=[zeros(300); fill(0.0015, 48)],
                            high=[zeros(300); fill(0.002, 48)]),
    "info" => Dict(
        "name" => "beam",
        "dim" => 348,
        "linear" => true,
        "hybrid" => false
    )
])
