module iss

using ReachabilityModels, MAT, ReachabilityBase.CurrentPath

file = matopen(@current_path("iss", "iss.mat"))

A = read(file, "A")

B = read(file, "B")

X = Universe(270)

U = Hyperrectangle([0.05, 0.9, 0.95], [0.05, 0.1, 0.05])

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end
