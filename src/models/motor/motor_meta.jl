using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 20.0, :alg => GLGM06(; δ=0.01)),
      "X0"   => Hyperrectangle(; low=[0.002, 0.0, 0.0, 0.0, 0.001, 0.0, 0.0, 0.0],
      high=[0.0025, 0.0, 0.0, 0.0, 0.0015, 0.0, 0.0, 0.0]),
      "X1"   => Hyperrectangle([0.00225, 0.0, 0.0, 0.0, 0.00125, 0.0, 0.0, 0.0],
      [0.00025, 0.0, 0.0, 0.0, 0.00025, 0.0, 0.0, 0.0]),
      "info" => Dict("name" => "motor",
      "dim" => 8,
      "linear" => true,
      "hybrid" => false)])
