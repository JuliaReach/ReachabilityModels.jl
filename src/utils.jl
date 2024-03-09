MODEL_DIR = joinpath(dirname(pathof(ReachabilityModels)), "..", "src/models")

function load_model(model::String; kwargs...)
    X0 = get(kwargs, :X0, nothing)
    if isnothing(X0)
        X0 = load_meta(model)["X0"]
    end
    file = joinpath(MODEL_DIR, model, model * ".jl")
    if isfile(file)
        include(file)
        model_module = getfield(ReachabilityModels, Symbol(model))
        Base.invokelatest(model_module.model, X0)
    else
        throw(ArgumentError("Model $model not found"))
    end
end

function load_meta(model::String)
    file = joinpath(MODEL_DIR, model, model * "_meta.jl")
    if isfile(file)
        return include(file)
    else
        throw(ArgumentError("Meta for $model not found"))
    end
end

function list_models(category, predicate)
    models = Vector()
    for model in readdir(MODEL_DIR)
        meta = include(joinpath(MODEL_DIR, model, model * "_meta.jl"))
        dict = meta["info"]
        if predicate(dict[category])
            push!(models, dict["name"])
        end
    end
    return models
end

function write_overview_file(models, TYPE, type)
    open(joinpath(dirname(@__FILE__), "../docs/src/overview_$type.md"), "w") do file
        print(file,
              """
              # $TYPE models

              The following models have $type dynamics.

              | Name  | State dimension |
              |:------|----------------:|
              """)

        #   | Name  | State dim | Input dim | Safety Property | Application Domain |
        #   |:------|----------:|----------:|----------------:|-------------------:|
        for model in models
            meta = load_meta(model)["info"]
            name = replace(meta["name"], "_" => "\\_")
            println(file, "| **$name** | $(meta["dim"]) |")# $(-) | $(-) | $(-) |")
        end
    end
end

# generate models summary in documentation
function generate_summary()
    linear_models = list_models("linear", x -> x)
    nonlinear_models = list_models("linear", x -> !x)
    hybrid_models = list_models("hybrid", x -> x)

    open(joinpath(dirname(@__FILE__), "../docs/src/overview_total.md"), "w") do file
        nlinear = length(linear_models)
        nnonlinear = length(nonlinear_models)
        nhybrid = length(hybrid_models)
        ntotal = nlinear + nnonlinear + nhybrid
        print(file, """
                    # Model overview

                    The following table shows the number of models for each type of system.

                    | Linear | Nonlinear | Hybrid | Total |
                    |:------:|:---------:|:------:|:-----:|
                    |$nlinear|$nnonlinear|$nhybrid|$ntotal|
                    """)
        return nothing
    end

    write_overview_file(linear_models, "Linear", "linear")

    write_overview_file(nonlinear_models, "Nonlinear", "nonlinear")

    return write_overview_file(hybrid_models, "Hybrid", "hybrid")
end
