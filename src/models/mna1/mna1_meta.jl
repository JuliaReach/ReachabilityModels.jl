using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 20.0, :alg => GLGM06(; δ=0.01)),
      "X0"   => Hyperrectangle(; low=[fill(0.001, 2); zeros(576)],
      high=[fill(0.0015, 2); zeros(576)]),
      "info" => Dict("name" => "mna1",
      "dim" => 578,
      "linear" => true,
      "hybrid" => false)])
