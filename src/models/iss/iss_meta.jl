using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.01)),
    "X0"   => BallInf(zeros(270), 1e-4),
    "info" => Dict(
        "name" => "iss",
        "dim" => 270,
        "linear" => true,
        "hybrid" => false
    )
])
