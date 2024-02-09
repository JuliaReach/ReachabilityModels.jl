module iss  #jl

using ReachabilityModels, MAT, ReachabilityBase.CurrentPath

file = matopen(@current_path("iss", "iss.mat"))

# system matrix
A = read(file, "A")

# input matrix
B = read(file, "B")

# state domain
X = Universe(270)

# input domain
U = Hyperrectangle([0.05, 0.9, 0.95], [0.05, 0.1, 0.05])

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end  #jl
