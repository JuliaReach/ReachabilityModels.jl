using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>5.0, :alg=>TMJets(orderT=8, orderQ=2, maxsteps=1_000)),
    "X0"   => Hyperrectangle(low=[4.8, 1.8], high=[5.2, 2.2]),
    "info" => Dict(
        "name" => "lotka_volterra",
        "dim" => 2,
        "linear" => false,
        "hybrid" => false
    )
])
