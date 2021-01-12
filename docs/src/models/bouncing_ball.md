```@meta
EditURL = "<unknown>/src/models/bouncing_ball/bouncing_ball.jl"
```

# Bouncing ball

## Model

We model the bouncing ball as a hybrid automaton with one location and a self-loop.
See for example [^LG09] pp. 79-83.

```@example bouncing_ball
using ReachabilityAnalysis, ModelingToolkit

function _bouncing_ball()

    var = @variables x v

    # "falling" mode with invariant x >= 0
    invariant = HalfSpace(x ≥ 0, var)
    flow = @system(z' = [0.0 1.0; 0.0 0.0] * z + [0.0, -9.81], z ∈ invariant)

    # guard x == 0 && v ≤ 0
    guard = HPolyhedron([0 ≤ x, x ≤ 0, v ≤ 0], var)

    # reset map v⁺ := -cv
    assignment = ConstrainedLinearMap([1.0 0.0; 0.0 -0.75], guard)

    # initial-value problem
    return HybridSystem(flow, assignment)
end

function model(X0)
    H = _bouncing_ball()
    return @ivp(H, z(0) ∈ X0)
end
```

## References

[^LG09]: Le Guernic, Colas. Reachability analysis of hybrid systems with linear continuous dynamics. Diss. 2009.

