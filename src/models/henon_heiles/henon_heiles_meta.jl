using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 100.0, :alg => TMJets(; abstol=1e-15)),
      "X0"   => BallInf([0.1, 0.0, 0.0, 0.5], 0.001),
      "info" => Dict("name" => "henon_heiles",
      "dim" => 4,
      "linear" => false,
      "hybrid" => false)])
