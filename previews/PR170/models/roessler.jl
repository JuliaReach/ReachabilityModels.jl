module roessler
using ReachabilityAnalysis
@taylorize function roessler!(du, u, p, t)
    local a, b, c = 0.2, 0.2, 5.7

    du[1] = -u[2] - u[3]
    du[2] = u[1] + (a * u[2])
    du[3] = b + (u[3] * (u[1] - c))

    return du
end

function model(X0)
    S = @system(x' = roessler!(x), dim:3)
    return IVP(S, X0)
end
end # module
