module vanderpol
using ReachabilityAnalysis
@taylorize function vanderpol!(dx, x, params, t)
    local μ = 1.0
    dx[1] = x[2]
    dx[2] = (μ * x[2]) * (1 - x[1]^2) - x[1]
    return dx
end

function model(X0)
    S = @system(x' = vanderpol!(x), dim:2)
    return IVP(S, X0)
end
end # module
