```@meta
EditURL = "<unknown>/src/models/brusselator/brusselator.jl"
```

## Brusselator

## Model

```@example brusselator
using ReachabilityAnalysis

const A = 1.0
const B = 1.5
const B1 = B + 1

@taylorize function brusselator!(du, u, p, t)
    x, y = u
    x² = x * x
    aux = x² * y
    du[1] = A + aux - B1*x
    du[2] = B*x - aux
    return du
end

function model(X0)
    S = @system(x' = brusselator!(x), dim:2)
    return IVP(S, X0)
end
```

## References

