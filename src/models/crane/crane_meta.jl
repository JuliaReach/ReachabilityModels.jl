using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 15.0, :alg => GLGM06(; δ=0.01)),
      "X0"   => Hyperrectangle([2.5, 0.0, 0.0, 0.0, 0.0, 0.0],
      [2.5, 0.0, 0.2, 0.1, 0.0, 0.0]),
      "info" => Dict("name" => "crane",
      "dim" => 6,
      "linear" => true,
      "hybrid" => false)])
