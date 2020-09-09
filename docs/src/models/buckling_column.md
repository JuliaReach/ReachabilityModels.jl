```@meta
EditURL = "<unknown>/src/models/buckling_column/buckling_column.jl"
```

```@example buckling_column
module buckling_column
using ReachabilityAnalysis
@taylorize function buckling_column!(dx, x, params, t)
    dx[1] = x[2]
    dx[2] = 2 * x[1] - x[1]^3 - 0.2 * x[2] + 0.1
    return dx
end

function model(X0)
    S = @system(x' = buckling_column!(x), dim:2)
    return IVP(S, X0)
end
end # module
```

