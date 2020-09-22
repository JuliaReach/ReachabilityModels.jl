using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.1)),
    "X0"   => Hyperrectangle(low=fill(0.9, 30), high=fill(1.1, 30)),
    "info" => Dict(
        "name" => "vehicle_platoon_10",
        "dim" => 30,
        "linear" => true,
        "hybrid" => false
    )
])
