using Documenter, ReachabilityModels
using ReachabilityModels: generate_summary

DocMeta.setdocmeta!(ReachabilityModels, :DocTestSetup, :(using ReachabilityModels); recursive=true)

# Generate notebooks
include("generate.jl")

# Generate bibliography
#include("bibliography.jl")

generate_summary()

makedocs(
    sitename = "Reachability Models",
    modules = [ReachabilityModels],
    format = Documenter.HTML(prettyurls = haskey(ENV, "GITHUB_ACTIONS"),  # disable for local builds
                             collapselevel = 1,
                             assets = ["assets/juliareach-light.css"]),
    pages = [
        "Home" => "index.md",
        "Usage" => "usage.md",
        "Linear ODEs" => Any["Overview" =>  "models/linear_overview.md",
                             "Beam" =>  "models/beam.md",
                             "Building" =>  "models/building.md",
                             "CD Player" =>  "models/cdplayer.md",
                             "Crane" =>  "models/crane.md",
                             "Elipse" =>  "models/elipse.md",
                             "Five Dim System" =>  "models/five_dim_sys.md",
                             "Fom" =>  "models/fom.md",
                             "Heat" =>  "models/heat.md",
                             "Helicopter" =>  "models/helicopter.md",
                             "ISS" =>  "models/iss.md",
                             "MNA1" =>  "models/mna1.md",
                             "MNA5" =>  "models/mna5.md",
                             "Motor" =>  "models/motor.md",
                             "PDE" =>  "models/pde.md",
                             "Projectile" =>  "models/projectile.md"],
        "Nonlinear ODEs" => Any["Biomodel 7d" => "models/biomodel7d.md",
                                "Biomodel 9d" => "models/biomodel9d.md",
                                "Brusselator" => "models/brusselator.md",
                                "Bucking column" => "models/buckling_column.md",
                                "Coupled VanDerPol" => "models/coupled_vanderpol.md",
                                "Double Gyre" => "models/doublegyre.md",
                                "Jet Engine" => "models/jet_engine.md",
                                "Lodka-Volterra" => "models/lodka_volterra.md",
                                "Lorenz" => "models/lorenz.md",
                                "Robot Arm" => "models/robot_arm.md",
                                "Roessler" => "models/roessler.md",
                                "Spring Pendulum" => "models/spring_pendulum.md",
                                "Steam Governor" => "models/steam_governor.md",
                                "VanDerPol" => "models/vanderpol.md"],
        "Hybrid ODEs" => Any["Bouncing ball" => "models/bouncing_ball_nonlinear.md",
                             "Cardiac Cell" => "models/cardiac_cell.md",
                             "Navigation System" => "models/navigation_system.md",
                             "Powertrain Control" => "models/powertrain_control.md",
                             "Spiking Neuron" => "models/spiking_neuron.md",
                             "Thermostat" => "models/thermostat.md"],
        "References" => "references.md",
        "About" => "about.md"
    ],
    strict = false
)

deploydocs(
    repo = "github.com/JuliaReach/ReachabilityModels.jl",
    push_preview=true
)
