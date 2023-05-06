using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 18.0, :alg => TMJets(; orderT=6, orderQ=2)),
      "X0"   => (0.8 .. 1.0) × (0.0 .. 0.2),
      "info" => Dict("name" => "brusselator",
      "dim" => 2,
      "linear" => false,
      "hybrid" => false)])
