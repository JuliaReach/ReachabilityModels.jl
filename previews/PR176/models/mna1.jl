module mna1

using ReachabilityModels, MAT, SparseArrays, ReachabilityBase.CurrentPath

file = matopen(@current_path("mna1", "mna1.mat"))

A = sparse(read(file, "A"))

b = sparsevec(570:578, [fill(-0.1, 5); fill(-0.2, 4)], 578)

function model(X0)
    S = @system(x' = Ax + b)
    return IVP(S, X0)
end

end
