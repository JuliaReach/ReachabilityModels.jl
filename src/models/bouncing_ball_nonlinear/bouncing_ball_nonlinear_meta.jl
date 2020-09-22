using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>10.0, :alg=>TMJets(orderT=5, orderQ=2, abs_tol=1e-10), :disjointness_method=>BoxEnclosure(), :intersect_source_invariant=>false),
    "X0"   => [(2, Hyperrectangle(low=[4.9, -0.2], high=[5.1, 0.0]))],
    "info" => Dict(
        "name" => "bouncing_ball_nonlinear",
        "dim" => 2,
        "linear" => false,
        "hybrid" => true
    )
])
