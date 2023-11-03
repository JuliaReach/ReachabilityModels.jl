# ## Beam

# ## Model

module beam #jl

using ReachabilityModels, MAT

file = matopen(@modelpath("beam", "beam.mat"))

## system matrix
A = read(file, "A")

## input matrix
B = read(file, "B")

## state domain
X = Universe(348)

## input domain
U = BallInf([0.9], 0.1)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end  #jl

# ## References
