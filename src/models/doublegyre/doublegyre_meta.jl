using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>20.0, :alg=>TMJets(abs_tol=1e-18, orderT=10, orderQ=4, max_steps=10_000)),
    "X0"   => Hyperrectangle(low=[0.19, 0.89], high=[0.2, 0.9]),
    "info" => Dict(
        "name" => "doublegyre",
        "dim" => 2,
        "linear" => false,
        "hybrid" => false
    )
])
