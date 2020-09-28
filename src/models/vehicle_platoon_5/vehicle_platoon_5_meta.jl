using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.1)),
    "X0"   => Hyperrectangle(low=fill(0.9, 15), high=fill(1.1, 15)),
    "info" => Dict(
        "name" => "vehicle_platoon_5",
        "dim" => 15,
        "linear" => true,
        "hybrid" => false
    )
])
