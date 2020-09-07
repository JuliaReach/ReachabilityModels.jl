module biomodel9d
using ReachabilityAnalysis

@taylorize function biomodel9d!(dx, x, p, t)
    dx[1] = 3.0*x[3] - x[1]*x[6]
    dx[2] = x[4] - x[2]*x[6]
    dx[3] = x[1]*x[6] - 3.0*x[3]
    dx[4] = x[2]*x[6] - x[4]
    dx[5] = 3.0*x[3] + 5.0*x[1] - x[5]
    dx[6] = 5.0*x[5] + 3.0*x[3] + x[4] - x[6]*(x[1]+x[2]+2.0*x[8]+1.0)
    dx[7] = 5.0*x[4] + x[2] - 0.5*x[7]
    dx[8] = 5.0*x[7] - 2.0*x[6]*x[8] + x[9] - 0.2*x[8]
    dx[9] = 2.0*x[6]*x[8] - x[9]
    return dx
end

function model(X0)
    S = @system(x' = biomodel9d!(x), dim:9)
    return IVP(S, X0)
end
end #module
