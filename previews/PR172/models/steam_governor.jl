module steam_governor
using ReachabilityAnalysis
@taylorize function steam_governor!(du, u, p, t)
    local ϵ = 3.0
    local α = 1.0
    local β = 1.0

    du[1] = u[2]
    du[2] = u[3]^2 * sin(u[1]) * cos(u[1]) - sin(u[1]) - ϵ * u[2]
    du[3] = α * (cos(u[1]) - β)

    return du
end

function model(X0)
    S = @system(x' = steam_governor!(x), dim:3)
    return IVP(S, X0)
end
end # module
