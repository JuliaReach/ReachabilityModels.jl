using ReachabilityAnalysis, SparseArrays
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=5e-3)),
    "X0"   => Hyperrectangle(spzeros(28), sparsevec(1:8, fill(0.1, 8), 28)),
    "info" => Dict(
        "name" => "helicopter",
        "dim" => 28,
        "linear" => true,
        "hybrid" => false
    )
])
