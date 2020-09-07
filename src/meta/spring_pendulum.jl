using ReachabilityAnalysis

r₀ = Interval(1.19, 1.21)
θ₀ = Interval(0.49, 0.51)
vr₀ = Singleton([0.0])
vθ₀ = Singleton([0.0])

X₀ = r₀ × θ₀ × vr₀ × vθ₀;

Dict([
    "opts" => Dict(:T=>5.0, :alg=>TMJets(orderT=8, orderQ=2, max_steps=1_000)),
    "X0"   => X₀,
    "info" => Dict(
        "name" => "spring_pendulum",
        "dim" => 4,
        "linear" => false,
        "hybrid" => false
    )
])
