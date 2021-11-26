using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>15.0, :alg=>TMJets(abstol=1e-15, orderT=10, orderQ=2, maxsteps=50_000)),
    "X0"   => Hyperrectangle(low=[0.6353, 14.7, 0.5573, 0.017, 0.0], high=[0.6353, 14.7, 0.5573, 0.017, 0.0]),
    "info" => Dict(
        "name" => "powertrain_control",
        "dim" => 5,
        "linear" => false,
        "hybrid" => true
    )
])
