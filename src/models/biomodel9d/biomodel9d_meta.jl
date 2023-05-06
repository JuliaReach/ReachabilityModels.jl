using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 2.0, :alg => TMJets(; maxsteps=1_000, abstol=1e-12, orderT=6, orderQ=2)),
      "X0"   => Hyperrectangle(; low=fill(0.99, 9), high=fill(1.01, 9)),
      "info" => Dict("name" => "biomodel9d",
      "dim" => 9,
      "linear" => false,
      "hybrid" => false)])
