module spring_pendulum
using ReachabilityAnalysis
@taylorize function spring_pendulum!(du, u, p, t)
    local g, k, L = 9.8, 2.0, 1.0
    du[1] = u[3]
    du[2] = u[4]
    du[3] = ((u[1] * (u[4]*u[4])) + g*cos(u[2])) - k*(u[1]-L)
    du[4] = -((2*u[3]*u[4]) + g*sin(u[2]))/(u[1])

    # change of variables: r <- r - L
    #du[3] = (((u[1]+L) * (u[4]*u[4])) + g*cos(u[2])) - k*(u[1])
    #du[4] = -((2*u[3]*u[4]) + g*sin(u[2]))/(u[1]+L)

    return du
end

function model(X0)
    S = @system(x' = spring_pendulum!(x), dim:4)
    return IVP(S, X0)
end
end # module
