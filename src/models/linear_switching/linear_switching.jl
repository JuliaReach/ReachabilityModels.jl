module linear_switching

using ReachabilityAnalysis, ModelingToolkit, SymEngine
using SpaceExParser.: readsxmodel, _get_coeffs
using ReachabilityModels: @relpath

n = 5  ## state dimension
U = Interval(-1.0, 1.0)  ## common input domain
m = dim(U)  ## input dimension
ε = 1e-6  ## auxiliary bloating of guards for ensuring intersection

file = @relpath "SpaceEx/model.xml"
_model = readsxmodel(file, raw_dict=true)
variables = convert.(Basic, [f.args[1].args[1] for f in _model["flows"][1]])
inputs = [convert(Basic, :u)]
load_dynamics(loc) = _get_coeffs(_model["flows"][loc], n, m, variables, inputs)

const var = @variables t

function mode1()
    A, B, _ = load_dynamics(1)
    X = HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -3.0 + ε)  # x1 ≥ 3
    @system(x' = Ax + Bu, x ∈ X, u ∈ U)
end

function mode2()
    A, B, c = load_dynamics(2)
    X = HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -2.0 + ε)  # x1 ≥ 2
    @system(x' = Ax + Bu, x ∈ X, u ∈ U)
end

function mode3()
    A, B, _ = load_dynamics(3)
    X = HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -1.0 + ε)  # x1 ≥ 1
    @system(x' = Ax + Bu, x ∈ X, u ∈ U)
end

function mode4()
    A, B, _ = load_dynamics(5)
    X = HalfSpace([1.0, 0.0, 0.0, 0.0, 0.0], 1.0 + ε)  # x1 ≤ 1
    @system(x' = Ax + Bu, x ∈ X, u ∈ U)
end

function mode5()
    A, B, _ = load_dynamics(4)
    X = HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], 0.0 + ε)  # x1 ≥ 0
    q4 = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
end

function linear_switching_hybrid()
    ## hybrid automaton
    HA = LightAutomaton(5)

    ## transition mode 1 → mode 2
    add_transition!(HA, 1, 2, 1)
    G = HPolyhedron([HalfSpace([1.0, 0.0, 0.0, 0.0, 0.0], 3.0 + ε),
                     HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -3.0 + ε)])  # x1 = 3
    R12 = ConstrainedIdentityMap(5, G)

    ## transition mode 2 → mode 3
    add_transition!(HA, 2, 3, 2)
    G = HPolyhedron([HalfSpace([1.0, 0.0, 0.0, 0.0, 0.0], 2.0 + ε),
                     HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -2.0 + ε)])  # x1 = 2
    R23 = ConstrainedIdentityMap(5, G)

    ## transition mode 3 → mode 4
    add_transition!(HA, 3, 4, 3)
    G = HPolyhedron([HalfSpace([1.0, 0.0, 0.0, 0.0, 0.0], 1.0 + ε),
                     HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -1.0 + ε)])  # x1 = 1
    R34 = ConstrainedIdentityMap(5, G)

    ## transition mode 4 → mode 5
    add_transition!(HA, 4, 5, 4)
    G = HPolyhedron([HalfSpace([1.0, 0.0, 0.0, 0.0, 0.0], 0.0 + ε),
                     HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -0.0 + ε)])  # x1 = 0
    R45 = ConstrainedIdentityMap(5, G)

    ## transition mode 5 → mode 1
    add_transition!(HA, 5, 1, 5)
    G = HPolyhedron([HalfSpace([1.0, 0.0, 0.0, 0.0, 0.0], 1.0 + ε),
                     HalfSpace([-1.0, 0.0, 0.0, 0.0, 0.0], -1.0 + ε)])  # x1 = 1
    R51 = ConstrainedIdentityMap(5, G)

    ## hybrid system
    return HybridSystem(HA, [mode1(), mode2(), mode3(), mode4(), mode5()], [R12, R23, R34, R45, R51],
                        fill(AutonomousSwitching(), 5))
end

function model(X0)
    H = linear_switching_hybrid()
    return IVP(H, X0)
end

end  # module
