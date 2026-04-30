module helicopter

using ReachabilityModels, MAT, ReachabilityBase.CurrentPath

file = matopen(@current_path("helicopter", "sx/heli.mat"))

A = read(file, "A")

B = read(file, "B")

X = Universe(28)

U = Hyperrectangle(zeros(6), [0, 0, 0, 0.001, 0.001, 0.001])

function model(X0)
    S = @system(x' = A * x + B * u, x ∈ X, u ∈ U)
    return IVP(S, X0)
end
end
