using ReachabilityAnalysis

Dict([
    "opts" => Dict(:T=>5.0, :alg=>GLGM06(δ=0.005)),
    "X0"   => BallInf([1.0, 0.0, 0.0, 0.0, 0.0], 0.1),
    "info" => Dict(
        "name" => "five_dim_sys",
        "dim" => 5,
        "linear" => true,
        "hybrid" => false
    )
])
