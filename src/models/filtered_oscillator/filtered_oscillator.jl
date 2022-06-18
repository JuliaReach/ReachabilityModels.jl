# # Filtered Oscillator

# ## Model

module filtered_oscillator      #jl

using ReachabilityAnalysis

one_loop_iteration = false
n0 = 4
n1 = (one_loop_iteration ? n0 + 1 : n0)
n = n1 + 2
z = zeros(n1)

## common flow
A = zeros(n, n)
A[1,1], A[2,2] = -2., -1.
A[3,1], A[3,3] = 5., -5.
for i = 4 : n-1
    A[i,i-1], A[i,i] = 5., -5.
end

function mode1(z)
    b = [1.4; -0.7; z]
    X = HPolyhedron([HalfSpace([-0.714286; -1.0; z], 0.0),  # 0.714286*x + y >= 0
                     HalfSpace([1.0; 0.0; z], 0.0)])  # x <= 0
    @system(x' = Ax + b, x ∈ X)
end

function mode2(z)
    b = [-1.4; 0.7; z]
    X = HPolyhedron([HalfSpace([1.0; 0.0; z], 0.0),  # x <= 0
                     HalfSpace([0.714286; 1.0; z], 0.0)])  # 0.714286*x + y <= 0
    @system(x' = Ax + b, x ∈ X)
end

function mode3(z)
    b = [1.4; -0.7; z]
    X = HPolyhedron([HalfSpace([-1.0; 0.0; z], 0.0),  # x >= 0
                     HalfSpace([-0.714286; -1.0; z], 0.0)])  # 0.714286*x + y >= 0
    @system(x' = Ax + b, x ∈ X)
end

function mode4(z, one_loop_iteration)
    b = [-1.4; 0.7; z]
    X = HPolyhedron([HalfSpace([0.714286; 1.0; z], 0.0),  # 0.714286*x + y <= 0
                     HalfSpace([-1.0; 0.0; z], 0.0)])  # x >= 0

    if one_loop_iteration
        ## k <= 2 (2.1 to avoid numerical issues)
        addconstraint!(X, HalfSpace([zeros(n-1); 1.], 2.1))
    end
    @system(x' = Ax + b, x ∈ X)
end


function filtered_oscillator_hybrid(n0, one_loop_iteration)

    n1 = (one_loop_iteration ? n0 + 1 : n0)
    n = n1 + 2
    z = zeros(n1)

    ## transition graph (automaton)
    a = GraphAutomaton(4)
    add_transition!(a, 3, 4, 1)
    add_transition!(a, 4, 2, 2)
    add_transition!(a, 2, 1, 3)
    add_transition!(a, 1, 3, 4)

    mode1 = mode1(z)
    mode2 = mode2(z)
    mode3 = mode3(z)
    mode4 = mode4(z, one_loop_iteration)
    m = [mode1, mode2, mode3, mode4]

    ## transitions

    ## transition l3 -> l4
    X_l3l4 = HPolyhedron([HalfSpace([-1.0; 0.0; z], 0.0),  # x >= 0
                          HalfSpace([-0.714286; -1.0; z], 0.0),  # 0.714286*x + y >= 0
                          HalfSpace([0.714286; 1.0; z], 0.0)])  # 0.714286*x + y <= 0
    if one_loop_iteration
        A_trans_34 = Matrix(1.0I, n, n)
        A_trans_34[n, n] = 2.  # k' = k * 2
        r1 = ConstrainedLinearMap(A_trans_34, X_l3l4)
    else
        r1 = ConstrainedIdentityMap(n, X_l3l4)
    end

    ## transition l4 -> l2
    X_l4l2 = HPolyhedron([HalfSpace([0.714286; 1.0; z], 0.0),  # 0.714286*x + y <= 0
                          HalfSpace([-1.0; 0.0; z], 0.0),  # x >= 0
                          HalfSpace([1.0; 0.0; z], 0.0)])  # x <= 0
    r2 = ConstrainedIdentityMap(n, X_l4l2)

    ## transition l2 -> l1
    X_l2l1 = HPolyhedron([HalfSpace([1.0; 0.0; z], 0.0),  # x <= 0
                          HalfSpace([-0.714286; -1.0; z], 0.0),  # 0.714286*x + y >= 0
                          HalfSpace([0.714286; 1.0; z], 0.0)])  # 0.714286*x + y <= 0
    r3 = ConstrainedIdentityMap(n, X_l2l1)

    ## transition l1 -> l3
    X_l1l3 = HPolyhedron([HalfSpace([-0.714286; -1.0; z], 0.0),  # 0.714286*x + y >= 0
                          HalfSpace([-1.0; 0.0; z], 0.0),  # x >= 0
                          HalfSpace([1.0; 0.0; z], 0.0)])  # x <= 0
    r4 = ConstrainedIdentityMap(n, X_l1l3)

    r = [r1, r2, r3, r4]

    ## switchings
    s = [HybridSystems.AutonomousSwitching()]

    return HybridSystem(a, m, r, s)
end

function model(X0; n0::Int=4, one_loop_iteration::Bool=false)
    H = filtered_oscillator_hybrid(n0, one_loop_iteration)
    return IVP(H, [(1, X0)])
end

end #jl

# ## References
