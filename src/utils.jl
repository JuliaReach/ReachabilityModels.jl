RM_dir = joinpath(dirname(pathof(ReachabilityModels)), "..")

function fetch_model(instance::AbstractString; kwargs...)

    nakeinstance = replace(instance, Pair(".jl", ""))

    if isfile(joinpath(RM_dir, "src/models", "$(nakeinstance).jl"))
        file = include(joinpath(RM_dir, "src/models", "$(nakeinstance).jl"))
        return getfield(ReachabilityModels, Symbol(instance))(kwargs...)
    else
        throw(ArgumentError("Model $instance not found"))
    end
    return S
end

function fetch_meta(instance::AbstractString)

    nakeinstance = replace(instance, Pair(".jl", ""))

    if isfile(joinpath(RM_dir, "src/meta", "$(nakeinstance).jl"))
        return include(joinpath(RM_dir, "src/meta", "$(nakeinstance).jl"))
    else
        throw(ArgumentError("Meta for $instance not found"))
    end
    return S
end
