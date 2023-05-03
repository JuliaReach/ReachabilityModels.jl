using ReachabilityAnalysis, SparseArrays
Dict(["opts" => Dict(:T => 20.0, :alg => GLGM06(; δ=0.5)),
      "X0"   => Singleton([0.0, 5.0, 100.0, 0.0]),
      "info" => Dict("name" => "projectile",
      "dim" => 4,
      "linear" => true,
      "hybrid" => false)])
