using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>1.0, :alg=>TMJets(abstol=1e-15, orderT=10, orderQ=2, maxsteps=50_000)),
    "X0"   => Hyperrectangle(low=[0.9, 0.0, 0.0], high=[1.1, 0.0, 0.0]),
    "info" => Dict(
        "name" => "lorenz",
        "dim" => 3,
        "linear" => false,
        "hybrid" => false
    )
])
