using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 10.0, :alg => TMJets(; abstol=1e-15, orderT=8, orderQ=1, maxsteps=50_000)),
      "X0"   => Hyperrectangle(; low=[0.8, 0.8], high=[1.2, 1.2]),
      "info" => Dict("name" => "jet_engine",
      "dim" => 2,
      "linear" => false,
      "hybrid" => false)])
