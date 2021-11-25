using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>7.0, :alg=>TMJets(maxsteps=1_000, abstol=1e-10, orderT=6, orderQ=2)),
    "X0"   => Hyperrectangle(low=[1.25, 2.25, 1.25, 2.25], high=[1.55, 2.35, 1.55, 2.35]),
    "info" => Dict(
        "name" => "coupled_vanderpol",
        "dim" => 4,
        "linear" => false,
        "hybrid" => false
    )
])
