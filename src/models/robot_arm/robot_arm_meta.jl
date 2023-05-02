using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 10.0, :alg => TMJets(; abstol=1e-15, orderT=8, orderQ=1, maxsteps=50_000)),
      "X0"   => Hyperrectangle(; low=[1.3, 1.3, -0.2, -0.2], high=[1.7, 1.7, 0.2, 0.2]),
      "info" => Dict("name" => "robot_arm",
      "dim" => 2,
      "linear" => false,
      "hybrid" => false)])
