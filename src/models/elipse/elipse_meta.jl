using ReachabilityAnalysis

X0₁ = Singleton([1.0, 0.0]) ⊕ BallInf(zeros(2), 0.01)
X0₂ = Singleton([1.5, 0.0]) ⊕ BallInf(zeros(2), 0.02)

α = 0.8
Z0 = α * X0₁ + (1 - α) * X0₂;

Dict(["opts" => Dict(:T => 15.0, :alg => GLGM06(; δ=0.05)),
      "X0"   => Z0,
      "info" => Dict("name" => "elipse",
      "dim" => 2,
      "linear" => true,
      "hybrid" => false)])
