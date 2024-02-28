# # Cardiac cell

# ## Model

module cardiac_cell     #jl

using ReachabilityAnalysis, ModelingToolkit

vars = @variables u, v, t

@taylorize function cardiac_cell_on!(dx, x, params, t)
    dx[1] = -0.9 * x[1]^2 - x[1]^3 - 0.9 * x[1] - x[2] + 1
    dx[2] = x[1] - 2 * x[2]
    dx[3] = one(x[3])
    return dx
end

@taylorize function cardiac_cell_off!(dx, x, params, t)
    dx[1] = -0.9 * x[1]^2 - x[1]^3 - 0.9 * x[1] - x[2]
    dx[2] = x[1] - 2 * x[2]
    dx[3] = one(x[3])
    return dx
end

function cardiac_cell_hybrid()
    n = 2 + 1 # variables + time

    automaton = GraphAutomaton(2)
    add_transition!(automaton, 1, 2, 1)
    add_transition!(automaton, 2, 1, 2)

    ## mode 1 "approaching"
    invariant = HalfSpace(t <= 5, vars)
    mode1 = @system(x' = cardiac_cell_on!(x), dim:3, x ∈ invariant)
    ## mode 1 "approaching"
    invariant = HalfSpace(t <= 20, vars)
    mode2 = @system(x' = cardiac_cell_off!(x), dim:3, x ∈ invariant)
    modes = [mode1, mode2]

    reset = Dict(n => 0.0)

    ## transition on -> off
    guard = HalfSpace(t >= 5)
    trans1 = ConstrainedResetMap(n, guard, reset)
    ## transition off -> on
    guard = HalfSpace(t >= 20)
    trans2 = ConstrainedResetMap(n, guard, reset)
    resetmaps = [trans1, trans2]

    return HybridSystems.HybridSystem(automaton, modes, resetmaps, [AutonomousSwitching()])
end

function model(X0)
    H = cardiac_cell_hybrid()
    return IVP(H, X0)
end

end #jl

# ## References
