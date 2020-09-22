# using GLGM06 + template hull intersection
Dict([
    "opts" => Dict(:T=>3.0, :alg=>GLGM06(δ=1e-2, max_order=10),
                   :intersection_method=>TemplateHullIntersection(BoxDirections(2)),
                   :clustering_method=>ZonotopeClustering(),
                   :intersect_source_invariant=>true),
    "X0"   => Hyperrectangle(low=[10.0, 0.0], high=[10.2, 0.0]),
    "info" => Dict(
        "name" => "bouncing_ball",
        "dim" => 2,
        "linear" => true,
        "hybrid" => true
    )
])
