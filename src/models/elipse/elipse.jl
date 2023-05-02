# # Elipse

# ## Model

module elipse   #jl

using ReachabilityAnalysis

A = [3.0 -9.0;
     4.0 -3.0]

function model(X0)
    S = @system(x' = Ax)
    return IVP(S, X0)
end

end #jl

# ## References
