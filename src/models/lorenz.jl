# ================================================
# Lorenz
#
# system type: continuous blackbox system
# state dimension: 3
#
# See https://en.wikipedia.org/wiki/Lorenz_system.
# ================================================
using ReachabilityAnalysis

function lorenz(; σ=10.0, β=8.0/3.0, ρ=28.0)
    function lorenz!(dx, x, params, t)
        dx[1] = σ * (x[2] - x[1])
        dx[2] = x[1] * (ρ - x[3]) - x[2]
        dx[3] = x[1] * x[2] - β * x[3]
        return dx
    end
    S = @system(x' = lorenz!(x), dim:3)
    return S
end
