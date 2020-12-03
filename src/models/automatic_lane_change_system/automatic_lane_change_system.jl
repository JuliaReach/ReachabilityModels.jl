# Automatic lane change system

# ## Model

module automatic_lane_change_system #jl
using ReachabilityAnalysis, ModelingToolkit

vars = @variables vx, sx, ax, w, vy, sy

@taylorize function mode0!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.01 * sx - 0.103 + 0.84 - 0.3 * vx - 0.5 * ax
    du[4] = -2 * w
    du[5] = -2 * vy
    du[6] = 0.1 * vy
    return du
end

@taylorize function mode1!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.5 *1.4 - 0.5 * ax
    du[4] = 3 - 0.15 * w + 0.2 - 0.01 * sy
    du[5] = 7.5 - 0.45 * w + 0.5 - 0.025 * sy - 0.05 * vy
    du[6] = 0.1 * vy
    return du
end

@taylorize function mode2!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.5 * vx + 1.4 - 0.5 * ax
    du[4] = 0.15 * w + 0.2 - 0.01 * sy
    du[5] = 0.25 * w + 0.5 - 0.025 * sy - 0.05 * vy
    du[6] = 0.1 * vy
    return du
end

@taylorize function mode3!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.5 * vx + 1.4 - 0.5 * ax
    du[4] = -0.1 * w + 0.2 - 0.01 * sy
    du[5] = -0.25 * w + 0.5 - 0.025 * sy - 0.05 * vy
    du[6] = 0.1 * vy
    return du
end

@taylorize function mode4!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.5 * vx + 1.4 - 0.5 * ax
    du[4] = -3 - 0.15 * w + 0.2 - 0.01 * sy
    du[5] = -7.5 - 0.45 * w + 0.5 - 0.025 * sy - 0.05 * vy
    du[6] = 0.1 * vy
    return du
end

@taylorize function mode5!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.01 * sx - 0.103 + 0.84 - 0.3 * vx - 0.5 * ax
    du[4] = -2 * w
    du[5] = -2 * vy
    du[6] = 0.1 * vy
    return du
end

@taylorize function mode6!(du, u, params, t)
    vx, sx, ax, w, vy, sy = u
    du[1] = 0.1 * ax
    du[2] = vx - 2.5
    du[3] = -0.5 * vx + 1.4 - 0.5 * ax
    du[4] = -2 * w
    du[5] = -2 * vy
    du[6] = 0.1 * vy
    return du
end

function acc_model()
    HA = LightAutomaton(7)

    ## mode 0
    X = HalfSpace(sx + 10 < 0, vars)
    m0 = @system(x' = mode0!(x), dim: 6, x ∈ X)

    ## mode 1
    X = HalfSpace(sy < 12, vars)
    m1 = @system(x' = mode1!(x), dim: 6, x ∈ X)

    ## mode 2
    X = HalfSpace(vy > 0.05, vars)
    m2 = @system(x' = mode2!(x), dim: 6, x ∈ X)

    ## mode 3
    X = HalfSpace(vy + 0.05 < 0, vars)
    m3 = @system(x' = mode3!(x), dim: 6, x ∈ X)

    ## mode 4
    X = HalfSpace(sy > 3.5, vars)
    m4 = @system(x' = mode4!(x), dim: 6, x ∈ X)

    ## mode 5
    X = Universe(6)
    m5 = @system(x' = mode5!(x), dim: 6, x ∈ X)

    ## mode 6
    X = HalfSpace(vy < 0.05, vars)
    m6 = @system(x' = mode6!(x), dim: 6, x ∈ X)

    ## modo 0 → 1
    add_transition!(HA, 1, 2, 1)
    G = HalfSpace(sx + 10 >= 0, vars)
    R0 = ConstrainedIdentityMap(6, G)

    ## modo 1 → 2
    add_transition!(HA, 2, 3, 2)
    G = HalfSpace(sy >= 12, vars)
    R1 = ConstrainedIdentityMap(6, G)

    ## modo 4 → 3
    add_transition!(HA, 5, 4, 5)
    G = HalfSpace(sy <= 3.5, vars)
    R2 = ConstrainedIdentityMap(6, G)

    ## modo 5 → 4
    add_transition!(HA, 6, 5, 6)
    G = HalfSpace(sx >= 10, vars)
    R3 = ConstrainedIdentityMap(6, G)

    ## modo 2 → 5
    add_transition!(HA, 3, 6, 3)
    G = HalfSpace(sx >= 10, vars)
    R4 = ConstrainedIdentityMap(6, G)

    ## modo 3 → 6
    add_transition!(HA, 4, 7, 4)
    G = HalfSpace(vy + 0.07 >= 0, vars)
    R5 = ConstrainedIdentityMap(6, G)

    modes = [m1, m2, m3, m4, m5, m6]

    resets = [R0, R1, R2, R3, R4, R5]

    ## hybrid system
    S = HybridSystem(HA, modes, resets, fill(AutonomousSwitching(), 6))

    return S
end

function model(X0)
    H = acc_model()
    return IVP(H, X0)
end
end #jl

# ## References
