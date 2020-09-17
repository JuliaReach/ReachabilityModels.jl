using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>5.0, :alg=>INT(δ=0.01), :fixpoint_check=>false),
    "X0"   => [(1, Interval(68., 69.))],
    "info" => Dict(
        "name" => "thermostat",
        "dim" => 1,
        "linear" => true,
        "hybrid" => true
    )
])
