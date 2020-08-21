module lorenz
using ReachabilityAnalysis
@taylorize function lorenz!(dx, x, params, t)
    σ, β, ρ = params
    dx[1] = σ * (x[2] - x[1])
    dx[2] = x[1] * (ρ - x[3]) - x[2]
    dx[3] = x[1] * x[2] - β * x[3]
    return dx
end

function model(X0; σ=10.0, β=8.0/3.0, ρ=28.0)
    params = [σ, β, ρ]
    S = @system(x' = lorenz!(x), dim:3)
    return IVP(S, X0)
end
end # module
