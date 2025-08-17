module fom

using ReachabilityModels, MAT, ReachabilityBase.CurrentPath

file = matopen(@current_path("fom", "fom.mat"))

A = float(read(file, "A"))  # the matrix has Int entries

B = read(file, "B")

X = Universe(1006)

U = BallInf([0.0], 1.0)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end
