# # Helicopter
#
#md # !!! note "Overview"
#md #     System type: linear continuous system\
#md #     State dimension: 28\
#md #     Application domain:

# This is a 28-dimensional controlled helicopter model.

module helicopter #jl

using ReachabilityModels: @relpath
using ReachabilityAnalysis, MAT

file = matopen(@relpath "sx/heli.mat")

# system matrix
A = read(file, "A")

# input matrix
B = read(file, "B")

# state domain
X = Universe(28)

# input domain
#U = Hyperrectangle(zeros(6), fill(0.01, 6))
U = Hyperrectangle(zeros(6), [0, 0, 0, 0.001, 0.001, 0.001])

function model(X0)
    S = @system(x' = A*x + B*u, x ∈ X, u ∈ U)
    return IVP(S, X0)
end
end #jl
