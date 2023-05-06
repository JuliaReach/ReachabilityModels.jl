using ReachabilityAnalysis
#=low = [0.2; -0.1; zeros(n1)]
high = [0.3; 0.1; zeros(n1)]
if one_loop_iteration
    low[end] = 1.0
    high[end] = 1.0
end
X0 = Hyperrectangle(low=low, high=high)=#
Dict(["opts" => Dict(:T => 99.0, :alg => BOX(; δ=0.01)),
      #"X0"   => [(3, X0)],
      "info" => Dict("name" => "filtered_oscillator",
                     "dim" => 3,
                     "linear" => true,
                     "hybrid" => true)])
