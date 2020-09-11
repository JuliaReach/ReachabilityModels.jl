using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.01)),
    "X0"   => Hyperrectangle(zeros(1006), [fill(0.0001, 400); zeros(606)]),
    "info" => Dict(
        "name" => "fom",
        "dim" => 1006,
        "linear" => true,
        "hybrid" => false
    )
])
