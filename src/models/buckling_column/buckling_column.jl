# ## Buckling column

# ## Model

module buckling_column   #jl

using ReachabilityAnalysis

@taylorize function buckling_column!(dx, x, params, t)
    dx[1] = x[2]
    dx[2] = 2 * x[1] - x[1]^3 - 0.2 * x[2] + 0.1
    return dx
end

function model(X0)                                  #jl
    S = @system(x' = buckling_column!(x), dim:2)    #jl
    return IVP(S, X0)                               #jl
end                                                 #jl

end  #jl

# ## References
