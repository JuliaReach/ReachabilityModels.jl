using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>5.0, :alg=>TMJets(orderT=8, orderQ=2, max_steps=1_000)),
    "X0"   => Hyperrectangle(low=[4.8, 1.8], high=[5.2, 2.2]),
    "info" => Dict(
        "name" => "lodka_volterra",
        "dim" => 2,
        "linear" => false,
        "hybrid" => false
    )
])
