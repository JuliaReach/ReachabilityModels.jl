module mna1  #jl

using ReachabilityAnalysis, MAT, SparseArrays
using ReachabilityModels: @relpath

file = matopen(@relpath "mna1.mat")

# system matrix
A = sparse(read(file, "A"))

# affine term
b = sparsevec(570:578, [fill(-0.1, 5); fill(-0.2, 4)], 578)

function model(X0)
    S = @system(x' = Ax + b)
    return IVP(S, X0)
end

end  #jl
