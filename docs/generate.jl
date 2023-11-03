import Literate
using Literate: script, markdown
import ReachabilityModels: @modelpath

src_dir = joinpath(@__DIR__, "..", "src", "models")

trgt_dir = joinpath(@__DIR__, "src", "models")
mkpath(trgt_dir)

macro modelpath(model_path::String, name::String)
    return joinpath(src_dir, model_path, name)
end

for dir in readdir(src_dir)
    src_path = abspath(joinpath(src_dir, dir, dir * ".jl"))
    text = script(src_path, trgt_dir; credit=false)
    code = strip(read(text, String))
    mdpost(str) = replace(str, "@__CODE__" => code)
    markdown(src_path, trgt_dir; postprocess=mdpost, credit=false)
end
