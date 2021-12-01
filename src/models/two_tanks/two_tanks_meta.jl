using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>5.0),
    "X0"   => [(1, Hyperrectangle([2.0, 1], [0.5, 0]))],
    "info" => Dict(
        "name" => "two_tanks",
        "dim" => 2,
        "linear" => true,
        "hybrid" => true
    )
])
