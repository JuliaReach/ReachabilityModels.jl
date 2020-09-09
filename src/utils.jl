RM_dir = joinpath(dirname(pathof(ReachabilityModels)), "..")

function fetch_model(instance::AbstractString; kwargs...)

    nakeinstance = replace(instance, Pair(".jl", ""))
    if haskey(kwargs, :X0)
        X0 = kwargs[:X0]
    else
        X0 = fetch_meta(nakeinstance)["X0"]
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

function fetch_meta(instance::AbstractString)

    nakeinstance = replace(instance, Pair(".jl", ""))

    file = joinpath(RM_dir, "src/models", "$(nakeinstance)/$(nakeinstance)_meta.jl")
    if isfile(file)
        return include(file)
    else
        throw(ArgumentError("Meta for $instance not found"))
    end
    return S
end

function list(arg, f)
    models = Vector()
    dir = joinpath(RM_dir, "src/models")
    for model in readdir(dir)
        meta = include(joinpath(dir, model, model*"_meta.jl"))
        if f(meta["info"][arg])
            push!(models, meta["info"]["name"])
        end
    end
    return models
end

"""
   @relpath(name)
Return the absolute path to file `name` relative to the executing script.
### Input
- `name` -- file name
### Output
A string.
### Notes
This macro is equivalent to `joinpath(@__DIR__, name)`.
The `@relpath` macro is used in model scripts to load data files relative to the
location of the model, without having to change the directory of the Julia session.
For instance, suppose that the folder `/home/projects/models` contains the script
`my_model.jl`, and suppose that the data file `my_data.dat` located in the same
directory is required to be loaded by `my_model.jl`.
Then,
```julia
# suppose the working directory is /home/julia/ and so we ran the script as
# julia -e "include("../projects/models/my_model.jl")"
# in the model file /home/projects/models/my_model.jl we write:
d = open(@relpath "my_data.dat")
# do stuff with d
```
In this example, the macro `@relpath "my_data.dat"` evaluates to the string
`/home/projects/models/my_data.dat`. If the script `my_model.jl` only had
`d = open("my_data.dat")`, without `@relpath`, this command would fail as julia
would have looked for `my_data.dat` in the *working* directory, resulting in an
error that the file `/home/julia/my_data.dat` is not found.
"""
macro relpath(name::String)
    __source__.file === nothing && return nothing
    _dirname = dirname(String(__source__.file))
    dir = isempty(_dirname) ? pwd() : abspath(_dirname)
    return joinpath(dir, name)
end
