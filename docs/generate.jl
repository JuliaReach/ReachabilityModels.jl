import Literate
import ReachabilityBase.CurrentPath: @current_path

source_dir = joinpath(@__DIR__, "..", "src", "models")
target_dir = joinpath(@__DIR__, "src", "models")
mkpath(target_dir)

# overwrite to use the correct model path
macro current_path(prefix::String, filename::String)
    return joinpath(source_dir, prefix, filename)
end

for model in readdir(source_dir)
    input = abspath(joinpath(source_dir, model, model * ".jl"))
    script = Literate.script(input, target_dir; credit=false)
    code = strip(read(script, String))
    mdpost(str) = replace(str, "@__CODE__" => code)
    if get(ENV, "DOCUMENTATIONGENERATOR", "") == "true"
        Literate.markdown(input, target_dir; postprocess=mdpost, credit=false)
    else
        # for the local build, one needs to set `nbviewer_root_url`
        Literate.markdown(input, target_dir; postprocess=mdpost, credit=false,
                          nbviewer_root_url="..")
    end
end
