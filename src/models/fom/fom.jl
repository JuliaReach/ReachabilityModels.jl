module fom  #jl

using ReachabilityModels, MAT, ReachabilityBase.CurrentPath

file = matopen(@current_path("fom", "fom.mat"))

# system matrix
A = float(read(file, "A"))  # the matrix has Int entries

# input matrix
B = read(file, "B")

# state domain
X = Universe(1006)

# input domain
U = BallInf([0.0], 1.0)

function model(X0)
    S = @system(x' = Ax + Bu, x ∈ X, u ∈ U)
    return IVP(S, X0)
end

end  #jl
