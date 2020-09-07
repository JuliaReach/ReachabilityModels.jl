module bouncing_ball_nonlinear
using ReachabilityAnalysis, ModelingToolkit

vars = @variables x, v

@taylorize function flow_down!(du, u, params, t)
    du[1] = u[2]
    du[2] = -9.8 + 0.1*(u[2])^2
    return du
end

@taylorize function flow_up!(du, u, params, t)
    du[1] = u[2]
    du[2] = -9.8 - 0.1*(u[2])^2
    return du
end

function bouncingBallNonlinear_model()
    # hybrid automaton with state variables x, v
    HA = LightAutomaton(2)

    # mode 1 ("down")
    X = HPolyhedron([HalfSpace(x ≥ 0, vars),
                     HalfSpace(v ≤ 0, vars)])
    m1 = @system(x' = flow_down!(x), dim: 2, x ∈ X)

    # mode 2 ("up")
    X = HPolyhedron([HalfSpace(x ≥ 0, vars),
                     HalfSpace(v ≥ 0, vars)])
    m2 = @system(x' = flow_up!(x), dim: 2, x ∈ X)

    # α transition down → up
    add_transition!(HA, 1, 2, 1)
    G = HalfSpace(x <= 0, vars)
    A = [1.0 0.0; 0.0 -0.8]
    Rα = ConstrainedLinearMap(A, G)  # v := -0.8v

    # β transition up → down
    add_transition!(HA, 2, 1, 2)
    G = HalfSpace(v <= 0, vars)
    Rβ = ConstrainedIdentityMap(2, G)

    # hybrid system
    S = HybridSystem(HA, [m1, m2], [Rα, Rβ], fill(AutonomousSwitching(), 2))

    return S
end

function model(X0)
    H = bouncingBallNonlinear_model()
    return IVP(H, X0)
end
end # module
