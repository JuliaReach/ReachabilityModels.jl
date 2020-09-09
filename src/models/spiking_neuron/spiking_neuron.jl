module spiking_neuron
using ReachabilityAnalysis, ModelingToolkit

@taylorize function flow!(dx, x, params, t)
    local a = 0.02
    local b = 0.2
    local I = 40
    dx[1] = (0.04*(x[1]*x[1]) + 5*x[1]) + ((140+I)-x[2])
    dx[2] = a*((b*x[1]) - x[2])
    return dx
end

function spikingNeuron_model()
    ## hybrid automaton
    HA = LightAutomaton(1)

    ## mode 1
    X = HPolyhedron([HalfSpace([1.0, 0.0], 30.0)])  # x1 ≤ 30
    m1 = @system(x' = flow!(x), dim: 2, x ∈ X)

    ## transition mode 1 → mode 1 (self loop)
    add_transition!(HA, 1, 1, 1)
    G = HPolyhedron([HalfSpace([-1.0, 0.0], -30.0)])  # x1 ≥ 30
    A = [0.0 0.0; 0.0 1.0]
    b = [-65.0, 8.0]
    R11 = ConstrainedAffineMap(A, b, G)  # x1 := -65, x2 := x2 + 8

    ## hybrid system
    S = HybridSystem(HA, [m1], [R11], [AutonomousSwitching()])

    return S
end

function model(X0)
    H = spikingNeuron_model()
    return IVP(H, X0)
end
end # module
