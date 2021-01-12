```@meta
EditURL = "<unknown>/src/models/coupled_vanderpol/coupled_vanderpol.jl"
```

## Coupled Van der Pol oscillator

## Model

```@example coupled_vanderpol
using ReachabilityAnalysis

@taylorize function coupled_vanderpol!(du, u, p, t)
    du[1] = u[2]
    du[2] = (1.0 - u[1]^2)*u[2] - u[1] + (u[3]-u[1])
    du[3] = u[4]
    du[4] = (1.0 - u[3]^2)*u[4] - u[3] + (u[1]-u[3])
    return du
end

function model(X0)
    S = @system(x' = coupled_vanderpol!(x), dim:4)
    return IVP(S, X0)
end
```

## References

