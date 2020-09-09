using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>2.0, :alg=>BOX(δ=0.01)),
    "X0"   => Hyperrectangle(low=[0.5, 0.5, 0.0, 0.0], high=[0.55, 0.55, 0, 0]),
    "info" => Dict(
        "name" => "navigation_system",
        "dim" => 4,
        "linear" => true,
        "hybrid" => true
    )
])
