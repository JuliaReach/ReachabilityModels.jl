using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 20.0, :alg => GLGM06(; δ=0.01)),
      "X0"   => Hyperrectangle(; low=[fill(0.0002, 10); zeros(10903)],
      high=[fill(0.00025, 10); zeros(10903)]),
      "info" => Dict("name" => "mna5",
      "dim" => 10913,
      "linear" => true,
      "hybrid" => false)])
