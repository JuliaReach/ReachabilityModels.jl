module doublegyre
using ReachabilityAnalysis
@taylorize function doublegyre!(dx, x, params, t)
    local A = 0.1
    dx[1] = -π*A*sin(π*x[1])*cos(π*x[2])
    dx[2] = π*A*cos(π*x[1])*sin(π*x[2])
    return dx
end

function model(X0)
    S = @system(x' = doublegyre!(x), dim:2)
    return IVP(S, X0)
end
end # module
