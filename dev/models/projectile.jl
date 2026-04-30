module projectile
using ReachabilityAnalysis, SparseArrays

# system matrix
A = sparse([1, 3], [2, 4], [0.5, 0.7], 4, 4)

# affine term
b = sparsevec([4], [-9.81], 4)

function model(X0)
    S = @system(x' = Ax + b)
    return IVP(S, X0)
end
end # module
