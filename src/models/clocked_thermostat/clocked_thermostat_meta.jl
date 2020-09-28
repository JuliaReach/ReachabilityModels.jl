using ReachabilityAnalysis
Dict([
    "opts" => Dict(:T=>5.0, :alg=>BOX(δ=0.01), :fixpoint_check=>false),
    "X0"   => [(1, Hyperrectangle(low=[68, 0.], high=[69, 0.]))],
    "info" => Dict(
        "name" => "clocked_thermostat",
        "dim" => 2,
        "linear" => true,
        "hybrid" => true
    )
])
