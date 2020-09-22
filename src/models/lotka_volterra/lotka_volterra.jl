module lotka_volterra
using ReachabilityAnalysis
@taylorize function lotka_volterra!(du, u, p, t)
    local α, β, γ, δ = 1.5, 1.0, 3.0, 1.0
    du[1] = u[1] * (α - β*u[2])
    du[2] = -u[2] * (γ - δ*u[1])
    return du
end

function model(X0)
    S = @system(x' = lotka_volterra!(x), dim:2)
    return IVP(S, X0)
end
end # module
