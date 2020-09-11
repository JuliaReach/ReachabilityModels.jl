using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.01)),
    "X0"   => Hyperrectangle(low=[fill(0.6, 2); zeros(198)],
                            high=[fill(0.625, 2); zeros(198)]),
    "info" => Dict(
        "name" => "heat",
        "dim" => 200,
        "linear" => true,
        "hybrid" => false
    )
])
