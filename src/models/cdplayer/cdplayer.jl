# ## CDPlayer

# ## Model

module cdplayer #jl

using ReachabilityAnalysis, MAT
using ReachabilityModels: @relpath

file = matopen(@relpath "cdplayer.mat")

## system matrix
A = read(file, "A")

## input matrix
B = read(file, "B")

## state domain
X = Universe(120)

## input domain
U = BallInf([0.0, 0.0], 1.0)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)                           
end

end  #jl

# ## References
