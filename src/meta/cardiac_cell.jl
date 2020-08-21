using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>10.0, :alg=>TMJets(abs_tol=1e-15, orderT=10, orderQ=2, max_steps=50_000)),
    "X0"   => Hyperrectangle(low=[0.0, 0.0, 0.0], high=[0.0, 0.0, 0.0]),
    "info" => Dict(
        "name" => "cardiac_cell",
        "dim" => 3,
        "linear" => false,
        "hybrid" => true
    )
])
