module robot_arm
using ReachabilityAnalysis
@taylorize function robot_arm!(dx, x, params, t)
    dx[1] = x[3]
    dx[2] = x[4]
    dx[3] = (-2x[2] * x[3] * x[4] - 2x[1] - 2x[3] + 4) / (x[2]^2 + 1)
    dx[4] = x[2] * x[3]^2 - x[2] - x[4] + 1
    return dx
end

function model(X0)
    S = @system(x' = robot_arm!(x), dim:4)
    return IVP(S, X0)
end
end # module
