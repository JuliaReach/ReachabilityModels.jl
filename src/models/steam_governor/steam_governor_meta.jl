using ReachabilityAnalysis

x₀ = Interval(0.9, 1.1)
y₀ = Interval(-0.1, 0.1)
z₀ = Interval(0.9, 1.1)

X₀ = x₀ × y₀ × z₀;

Dict(["opts" => Dict(:T => 10.0, :alg => TMJets(; abstol=1e-10, orderT=6, orderQ=2, maxsteps=1_000)),
      "X0"   => X₀,
      "info" => Dict("name" => "steam_governor",
      "dim" => 3,
      "linear" => false,
      "hybrid" => false)])
