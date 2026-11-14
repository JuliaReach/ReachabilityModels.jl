module jet_engine
using ReachabilityAnalysis
@taylorize function jet_engine!(dx, x, params, t)
    dx[1] = -x[2] - 1.5 * x[1]^2 - 0.5 * x[1]^3 - 0.5
    dx[2] = 3 * x[1] - x[2]
    return dx
end

function model(X0)
    S = @system(x' = jet_engine!(x), dim:2)
    return IVP(S, X0)
end
end # module
