module two_tanks #jl

using ReachabilityAnalysis, Symbolics

function _two_tanks()
    var = @variables x1 x2

    HA = LightAutomaton(4)

    B = hcat([1.0, 1])
    U = Interval(-0.1, 0.1)

    ## off/off
    X = HPolyhedron([x1 ≥ -1, x2 ≤ 1], var)
    A = [-1.0 0; 1 0]
    c = [-2.0, 0]
    m1 = @system(x' = A*x + B*u + c, x ∈ X, u ∈ U)

    ## on/off
    X = HPolyhedron([x2 ≤ 1], var)
    A = [-1.0 0; 1 0]
    c = [3.0, 0]
    m2 = @system(x' = A*x + B*u + c, x ∈ X, u ∈ U)

    ## off/on
    X = HPolyhedron([x1 ≥ -1, x2 ≥ 0], var)
    A = [-1.0 0; 1 -1]
    c = [-2.0, -5]
    m3 = @system(x' = A*x + B*u + c, x ∈ X, u ∈ U)

    ## on/on
    X = HPolyhedron([x1 ≤ -1, x2 ≥ 0], var)
    A = [-1.0 0; 1 -1]
    c = [3.0, -5]
    m4 = @system(x' = A*x + B*u + c, x ∈ X, u ∈ U)

    ## transition off/off -> on/off
    add_transition!(HA, 1, 2, 1)
    G = Hyperplane(x1 == -1, var)
    t1 = ConstrainedIdentityMap(2, G)

    ## transition off/off -> off/on
    add_transition!(HA, 1, 3, 2)
    G = Hyperplane(x2 == 1, var)
    t2 = ConstrainedIdentityMap(2, G)

    ## transition on/off -> off/on
    add_transition!(HA, 2, 3, 3)
    G = Hyperplane(x2 == 1, var)
    t3 = ConstrainedIdentityMap(2, G)

    ## transition off/on -> off/off
    add_transition!(HA, 3, 1, 4)
    G = Hyperplane(x2 == 0, var)
    t4 = ConstrainedIdentityMap(2, G)

    ## transition off/on -> on/on
    add_transition!(HA, 3, 4, 5)
    G = Hyperplane(x1 == -1, var)
    t5 = ConstrainedIdentityMap(2, G)

    ## transition on/on -> on/off
    add_transition!(HA, 4, 2, 6)
    G = Hyperplane(x2 == 0, var)
    t6 = ConstrainedIdentityMap(2, G)

    ## transition on/on -> off/on
    add_transition!(HA, 4, 3, 7)
    G = Hyperplane(x1 == 1, var)
    t7 = ConstrainedIdentityMap(2, G)

    ## hybrid system
    S = HybridSystem(HA, [m1, m2, m3, m4], [t1, t2, t3, t4, t5, t6, t7])

    return S
end

function model(X0)
    H = _two_tanks()
    return IVP(H, X0)
end

end #jl

# ## References

# https://ths.rwth-aachen.de/research/projects/hypro/two-tank/
