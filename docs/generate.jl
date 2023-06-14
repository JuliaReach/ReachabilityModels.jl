import Literate
using Literate: script, markdown, notebook

src_dirs = [joinpath(@__DIR__, "..", "src", "models")]

trgt_dir_test = joinpath(@__DIR__, "..", "test", "models")
trgt_dir = joinpath(@__DIR__, "src", "models")
mkpath(trgt_dir)

for src_dir in src_dirs
    for dir in readdir(src_dir)
        if endswith(dir, ".jl")
            #@warn "ignoring $src_dir/$file"
        else
            src_path = abspath(joinpath(src_dir, dir, dir * ".jl"))
            text = script(src_path, trgt_dir_test; credit=false)
            code = strip(read(text, String))
            mdpost(str) = replace(str, "@__CODE__" => code)
            markdown(src_path, trgt_dir; postprocess=mdpost, credit=false)
        end
    end
end
