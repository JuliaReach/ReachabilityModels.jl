RM_dir = joinpath(dirname(pathof(ReachabilityModels)), "..")

function fetch_model(instance::AbstractString; kwargs...)

    nakeinstance = replace(instance, Pair(".jl", ""))
    if haskey(kwargs, :X0)
        X0 = kwargs[:X0]
    else
        X0 = fetch_meta(nakeinstance)["X0"]
    end
    dir = joinpath(RM_dir, "src/models", "$(nakeinstance).jl")
    if isfile(dir)
        include(dir)
        m = getfield(ReachabilityModels, Symbol(nakeinstance))
        Base.invokelatest(m.model, X0)
    else
        throw(ArgumentError("Model $nakeinstance not found"))
    end
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

function list(arg, f)
    models = Vector()
    for model in readdir(joinpath(RM_dir, "src/meta"))
        meta = include(joinpath(RM_dir, "src/meta", model))
        if f(meta["info"][arg])
            push!(models, meta["info"]["name"])
        end
    end
    return models
end
