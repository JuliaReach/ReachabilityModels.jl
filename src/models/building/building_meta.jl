using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.005)),
    "X0"   => Hyperrectangle(low=[fill(0.0002, 10); zeros(14); -0.0001; zeros(23)],
                            high=[fill(0.00025, 10); zeros(14); 0.0001; zeros(23)]),
    "info" => Dict(
        "name" => "building",
        "dim" => 48,
        "linear" => true,
        "hybrid" => false
    )
])
