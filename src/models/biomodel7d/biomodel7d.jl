# ## BioModel7d

# ## Model

module biomodel7d #jl

using ReachabilityAnalysis

@taylorize function biomodel7d!(dx, x, p, t)
    dx[1] = -0.4 * x[1] + 5.0 * x[3] * x[4]
    dx[2] = 0.4 * x[1] - x[2]
    dx[3] = x[2] - 5.0 * x[3] * x[4]
    dx[4] = 5.0 * x[5] * x[6] - 5.0 * x[3] * x[4]
    dx[5] = -5.0 * x[5] * x[6] + 5.0 * x[3] * x[4]
    dx[6] = 0.5 * x[7] - 5.0 * x[5] * x[6]
    dx[7] = -0.5 * x[7] + 5.0 * x[5] * x[6]
    return dx
end

function model(X0)
    S = @system(x' = biomodel7d!(x), dim:7)
    return IVP(S, X0)
end

end #jl

# ## References
