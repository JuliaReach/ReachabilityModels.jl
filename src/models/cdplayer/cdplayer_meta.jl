using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=0.001)),
    "X0"   => BallInf(zeros(120), 1.0),
    "info" => Dict(
        "name" => "cdplayer",
        "dim" => 120,
        "linear" => true,
        "hybrid" => false
    )
])
