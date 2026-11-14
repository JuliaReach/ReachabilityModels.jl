module henon_heiles
using ReachabilityAnalysis
@taylorize function henon_heiles!(du, u, p, t)
    p₁, p₂, q₁, q₂ = u[1], u[2], u[3], u[4]
    du[1] = -q₁ * (1 + 2q₂)
    du[2] = -q₂ - (q₁^2 - q₂^2)
    du[3] = p₁
    return du[4] = p₂
end

function model(X0)
    S = @system(x' = henon_heiles!(x), dim:4)
    return IVP(S, X0)
end
end # module
