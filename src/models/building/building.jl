# ## Building

# ## Model

module building #jl

using ReachabilityAnalysis, MAT
using ReachabilityModels: @relpath

file = matopen(@relpath "building.mat")

## system matrix
A = read(file, "A")

## input matrix
B = read(file, "B")

## state domain
X = Universe(48)

## input domain
U = BallInf([0.5], 0.3)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)                       
end

end  #jl

# ## References
