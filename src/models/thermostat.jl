module thermostat

using ReachabilityAnalysis, ModelingToolkit

const A1 = 40.0
const A2 = 30.0
const B = 0.5
const t1 = 75
const t2 = 65

const var = @variables t

function thermostat_on()
    invariant = HalfSpace(t <= t1)
    @system(x' = -Bx + A1, x ∈ invariant)
end

function thermostat_off()
    invariant = HalfSpace(t >= t2)
    @system(x' = -Bx + A2, x ∈ invariant)
end

function thermostat_hybrid()
    automaton = LightAutomaton(2)
    add_transition!(automaton, 1, 2, 1)
    add_transition!(automaton, 2, 1, 2)

    mode1 = thermostat_on()
    mode2 = thermostat_off()
    modes = [mode1, mode2]

    # transition on -> off
    guard = HalfSpace(t >= t1)
    trans1 = ConstrainedIdentityMap(1, guard)
    # transition off -> on
    guard = HalfSpace(t <= t2)
    trans2 = ConstrainedIdentityMap(1, guard)
    resetmaps = [trans1, trans2]

    return HybridSystem(automaton, modes, resetmaps, [AutonomousSwitching()])
end

function model(X0)
    H = thermostat_hybrid()
    return IVP(H, [(1, X0)])
end

end  # module
