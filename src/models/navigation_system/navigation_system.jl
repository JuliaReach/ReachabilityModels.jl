module navigation_system

using ReachabilityAnalysis, ModelingToolkit

const var = @variables x, y, v_x, v_y

function mode0()
    A = [0 0 1 0;
         0 0 0 1;
         0 0 -1.2 0.1;
         0 0 0.1 -1.2]
    B = [0, 0, -0.1, 1.2]
    invariant = UnionSetArray([HalfSpace(x <= 1),
                               HalfSpace(v_x <= 0),
                               HalfSpace(y <= 1),
                               HalfSpace(v_y <= 0)])
    return @system(x' = Ax + B, x ∈ invariant)
end

function mode1()
    A = [0 0 1 0;
         0 0 0 1;
         0 0 -1.2 0.1;
         0 0 0.1 -1.2]
    B = [0, 0, -4.8, 0.4]
    invariant = UnionSetArray([HalfSpace(x >= 1),
                               HalfSpace(v_x <= 0),
                               HalfSpace(y <= 1),
                               HalfSpace(v_y <= 0)])
    return @system(x' = Ax + B, x ∈ invariant)
end

function mode2()
    A = [0 0 1 0;
         0 0 0 1;
         0 0 -1.2 0.1;
         0 0 0.1 -1.2]
    B = [0, 0, 2.4, -0.2]
    invariant = UnionSetArray([HalfSpace(x <= 1),
                               HalfSpace(v_x <= 0),
                               HalfSpace(y >= 1),
                               HalfSpace(v_y >= 0)])
    @system(x' = Ax + B, x ∈ invariant)
end

function mode3()
    A = [0 0 1 0;
         0 0 0 1;
         0 0 -1.2 0.1;
         0 0 0.1 -1.2]
    B = [0, 0, 3.9, -3.9]
    invariant = UnionSetArray([HalfSpace(x >= 1),
                               HalfSpace(v_x >= 0),
                               HalfSpace(y >= 1),
                               HalfSpace(v_y >= 0)])
    @system(x' = Ax + B, x ∈ invariant)
end

function navigation_system_hybrid()
    automaton = GraphAutomaton(4)
    add_transition!(automaton, 1, 2, 1)
    add_transition!(automaton, 2, 1, 2)
    add_transition!(automaton, 2, 4, 3)
    add_transition!(automaton, 4, 2, 4)
    add_transition!(automaton, 1, 3, 5)
    add_transition!(automaton, 3, 1, 6)
    add_transition!(automaton, 3, 4, 7)
    add_transition!(automaton, 4, 3, 8)

    modes = [mode0(), mode1(), mode2(), mode3()]

    ## transition 1 -> 2
    guard = HPolyhedron([HalfSpace(x >= 1), HalfSpace(v_x >= 0)])
    trans1 = ConstrainedIdentityMap(4, guard)
    ## transition 2 -> 1
    guard = HPolyhedron([HalfSpace(x <= 1), HalfSpace(v_x <= 0)])
    trans2 = ConstrainedIdentityMap(4, guard)
    ## transition 2 -> 4
    guard = HPolyhedron([HalfSpace(y >= 1), HalfSpace(v_y >= 0)])
    trans3 = ConstrainedIdentityMap(4, guard)
    ## transition 4 -> 2
    guard = HPolyhedron([HalfSpace(y <= 1), HalfSpace(v_y <= 0)])
    trans4 = ConstrainedIdentityMap(4, guard)
    ## transition 1 -> 3
    guard = HPolyhedron([HalfSpace(y >= 1), HalfSpace(v_y >= 0)])
    trans5 = ConstrainedIdentityMap(4, guard)
    ## transition 3 -> 1
    guard = HPolyhedron([HalfSpace(y <= 1), HalfSpace(v_y <= 0)])
    trans6 = ConstrainedIdentityMap(4, guard)
    ## transition 3 -> 4
    guard = HPolyhedron([HalfSpace(x >= 1), HalfSpace(v_x >= 0)])
    trans7 = ConstrainedIdentityMap(4, guard)
    ## transition 4 -> 3
    guard = HPolyhedron([HalfSpace(x <= 1), HalfSpace(v_x <= 0)])
    trans8 = ConstrainedIdentityMap(4, guard)
    resetmaps = [trans1, trans2, trans3, trans4, trans5, trans6, trans7, trans8]

    return HybridSystem(automaton, modes, resetmaps, [AutonomousSwitching()])
end

function model(X0)
    H = navigation_system_hybrid()
    return IVP(H, [(1, X0)])
end

end  # module
