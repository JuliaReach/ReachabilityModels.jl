using ReachabilityAnalysis, SparseArrays
Dict([
    "opts" => Dict(:T=>20.0, :alg=>GLGM06(δ=5e-3)),
    "X0"   => Hyperrectangle(spzeros(28), sparsevec(1:8, fill(0.1, 8), 28)),
    "info" => Dict(
        "name" => "helicopter",
        "dim" => 28,
        "linear" => true,
        "continuous" => true,
        "domain" => "Automatic Control",
        "hybrid" => false,
        "description" => "An 8-dimensional helicopter model with a 20-dimensional controller. The controlled plant is a 28-dimensional continuous linear time-invariant (LTI) system. The plant is a small disturbance model of a helicopter, given as an 8-dimensional LTI system. The controller we examine is an H∞ mixed-sensitivity design for rejecting atmospheric turbulence, given as a 20-dimensional LTI system. ",
        "source" => "S. Skogestad and I. Postlethwaite. Multivariable Feedback Control: Analysis and Design. John Wiley & Sons, 2005. The model is taken from the Example Mdels from SpaceEx state space explorer (see http://spaceex.imag.fr/download-6)."
    )
])
