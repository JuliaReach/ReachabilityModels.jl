module pde

using ReachabilityModels, MAT, ReachabilityBase.CurrentPath

file = matopen(@current_path("pde", "pde.mat"))

# system matrix
A = float(read(file, "A"))  # the matrix has Int entries

# input matrix
B = read(file, "B")

# state domain
X = Universe(84)

# input domain
U = BallInf([0.75], 0.25)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end
