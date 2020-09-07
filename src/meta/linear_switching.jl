using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>1.0, :alg=>GLGM06(δ=1e-4)),
    "X0"   => [(1, Singleton([3.1, 4.0, 0.0, 0.0, 0.0]))],
    "info" => Dict(
        "name" => "linear_switching",
        "dim" => 1,
        "linear" => true,
        "hybrid" => true
    )
])
