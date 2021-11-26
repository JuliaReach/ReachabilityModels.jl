using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>100.0, :alg=>TMJets(abstol=1e-5, orderT=5, orderQ=2, maxsteps=50_000), :disjointness_method=>BoxEnclosure(), :intersect_source_invariant=>false),
    "X0"   => [(1, Hyperrectangle(low=[-65.0, -0.2], high=[-60.0, 0.2]))],
    "info" => Dict(
        "name" => "spiking_neuron",
        "dim" => 2,
        "linear" => false,
        "hybrid" => true
    )
])
