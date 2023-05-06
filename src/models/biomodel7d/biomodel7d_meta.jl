using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 2.0, :alg => TMJets(; maxsteps=1_000, abstol=1e-10, orderT=6, orderQ=2)),
      "X0"   => Hyperrectangle(; low=fill(0.99, 7), high=fill(1.01, 7)),
      "info" => Dict("name" => "biomodel7d",
      "dim" => 7,
      "linear" => false,
      "hybrid" => false)])
