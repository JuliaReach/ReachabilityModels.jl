# ## Heat

# ## Model

module heat #jl

using ReachabilityAnalysis, MAT, SparseArrays
using ReachabilityModels: @relpath

file = matopen(@relpath "heat.mat")

## system matrix
A = read(file, "A")

## input matrix
B = sparse([67], [1], [1.0], size(A, 1), 1)

## state domain
X = Universe(200)

## input domain
U = BallInf([0.0], 0.5)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end  #jl

# ## References
