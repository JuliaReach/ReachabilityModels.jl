using ReachabilityAnalysis
Dict(["opts" => Dict(:T => 20.0, :alg => GLGM06(; δ=0.01)),
      "X0"   => Hyperrectangle(; low=[zeros(64); fill(0.001, 16); fill(-0.002, 4)],
      high=[zeros(64); fill(0.0015, 16); fill(-0.0015, 4)]),
      "info" => Dict("name" => "pde",
      "dim" => 84,
      "linear" => true,
      "hybrid" => false)])
