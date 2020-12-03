using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>40.0, :alg=>TMJets(orderT=10, orderQ=2, abs_tol=1e-10), :disjointness_method=>BoxEnclosure(), :intersect_source_invariant=>false),
    "X0"   => [(1, Hyperrectangle(low=[-15, 3.25, 0, 0, 0, 0], high=[-14.95, 3.25, 0, 0, 0, 0]))],
    "info" => Dict(
        "name" => "automatic_lane_change_system",
        "dim" => 6,
        "linear" => false,
        "hybrid" => true
    )
])
