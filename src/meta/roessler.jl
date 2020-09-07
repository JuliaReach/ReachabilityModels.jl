using ReachabilityAnalysis

x₀ = Interval(-0.2, 0.2)
y₀ = Interval(-8.6, -8.2)
z₀ = Interval(-0.2, 0.2)

X₀ = x₀ × y₀ × z₀;

Dict([
    "opts" => Dict(:T=>6.0, :alg=>TMJets(abs_tol=1e-10, orderT=6, orderQ=2, max_steps=1_000)),
    "X0"   => X₀,
    "info" => Dict(
        "name" => "roessler",
        "dim" => 3,
        "linear" => false,
        "hybrid" => false
    )
])
