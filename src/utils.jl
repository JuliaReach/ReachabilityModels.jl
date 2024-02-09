RM_dir = joinpath(dirname(pathof(ReachabilityModels)), "..")

function load_model(instance::AbstractString; kwargs...)
    nakeinstance = replace(instance, Pair(".jl", ""))
    if haskey(kwargs, :X0)
        X0 = kwargs[:X0]
    else
        X0 = load_meta(nakeinstance)["X0"]
    end
    dir = joinpath(RM_dir, "src/models", "$(nakeinstance)/$(nakeinstance).jl")
    if isfile(dir)
        include(dir)
        m = getfield(ReachabilityModels, Symbol(nakeinstance))
        Base.invokelatest(m.model, X0)
    else
        throw(ArgumentError("Model $nakeinstance not found"))
    end
end

function load_meta(instance::AbstractString)
    nakeinstance = replace(instance, Pair(".jl", ""))

    file = joinpath(RM_dir, "src/models", "$(nakeinstance)/$(nakeinstance)_meta.jl")
    if isfile(file)
        return include(file)
    else
        throw(ArgumentError("Meta for $instance not found"))
    end
    return S
end

function list_models(arg, f)
    models = Vector()
    dir = joinpath(RM_dir, "src/models")
    for model in readdir(dir)
        meta = include(joinpath(dir, model, model * "_meta.jl"))
        if f(meta["info"][arg])
            push!(models, meta["info"]["name"])
        end
    end
    return models
end

# generate models overview in documentation
function generate_summary()

    ### OVERVIEW
    open(joinpath(dirname(@__FILE__), "../docs/src/overview.md"), "w") do file
        nmodels = length(list_models("dim", x -> x > 0))
        nlinear = length(list_models("linear", x -> x == true))
        nnonlinear = length(list_models("linear", x -> x == false))
        nhybrid = length(list_models("hybrid", x -> x == true))
        return print(file, """
                           # Models
                           Here is a table showing the number of models for each type
                           of system.

                           | Linear   | Nonlinear   | Hybrid   | Total    |
                           |:---------|------------:|---------:|---------:|
                           |$(nlinear)|$(nnonlinear)|$(nhybrid)|$(nmodels)|
                           """)
    end

    ### LINEAR
    open(joinpath(dirname(@__FILE__), "../docs/src/models/linear_overview.md"), "w") do file
        function printrow(model)
            meta = load_meta(model)["info"]
            return println(file, "| **$(meta["name"])** | $(meta["dim"]) | $(-) | $(-) | $(-) |")
        end

        print(file,
              """
              # Linear models
              Here are the models with linear dynamics.

              | Name  | State dim | Input dim | Safety Property | Application Domain | Nominal Runtime (sec) |
              |:------|----------:|----------:|-----------------:|-------------------:|----------------:|
              """)

        linear_models = list_models("linear", x -> x == true)
        for model in linear_models
            printrow(model)
        end
    end

    ### NONLINEAR
    open(joinpath(dirname(@__FILE__), "../docs/src/models/nonlinear_overview.md"), "w") do file
        function printrow(model)
            meta = load_meta(model)["info"]
            return println(file, "| **$(meta["name"])** | $(meta["dim"]) | $(-) | $(-) | $(-) |")
        end

        print(file,
              """
              # Nonlinear models
              Here are the models with nonlinear dynamics.

              | Name  | State dim | Input dim | Safesty Property | Application Domain | Nominal Runtime |
              |:------|----------:|----------:|-----------------:|-------------------:|----------------:|
              """)

        nonlinear_models = list_models("linear", x -> x == false)
        for model in nonlinear_models
            printrow(model)
        end
    end

    ### HYBRID
    open(joinpath(dirname(@__FILE__), "../docs/src/models/hybrid_overview.md"), "w") do file
        function printrow(model)
            meta = load_meta(model)["info"]
            return println(file, "| **$(meta["name"])** | $(meta["dim"]) | $(-) | $(-) | $(-) |")
        end

        print(file,
              """
              # Hybrid models
              Here are the models with hybrid systems.

              | Name  | State dim | Input dim | Safesty Property | Application Domain | Nominal Runtime |
              |:------|----------:|----------:|-----------------:|-------------------:|----------------:|
              """)

        hybrid_models = list_models("hybrid", x -> x == true)
        for model in hybrid_models
            printrow(model)
        end
    end
end
