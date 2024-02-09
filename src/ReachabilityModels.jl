module ReachabilityModels

using Reexport
@reexport using ReachabilityAnalysis
@reexport using ReachabilityBase.CurrentPath: @current_path

include("utils.jl")

# name alias
fetch_model = load_model
fetch_meta = load_meta

export fetch_model, fetch_meta,
       load_model, load_meta,
       list_models

end  # module
