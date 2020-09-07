using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>5.0, :alg=>BOX(δ=0.01)),
    "X0"   => [(1, Interval(68., 69.))],
    "info" => Dict(
        "name" => "thermostat",
        "dim" => 1,
        "linear" => true,
        "hybrid" => true
    )
])
