using Documenter, ReachabilityModels
using ReachabilityModels: generate_summary

DocMeta.setdocmeta!(ReachabilityModels, :DocTestSetup,
                    :(using ReachabilityModels); recursive=true)

# generate notebooks
include("generate.jl")

# generate bibliography
#include("bibliography.jl")

generate_summary()

makedocs(; sitename="ReachabilityModels",
         modules=[ReachabilityModels],
         format=Documenter.HTML(; prettyurls=get(ENV, "CI", nothing) == "true",
                                assets=["assets/aligned.css"]),
         pagesonly=true,
         pages=["Home" => "index.md",
                "Usage" => "usage.md",
                "Overview" => "overview_total.md",
                "Linear Dynamics" => Any["Overview" => "overview_linear.md",
                                         "Beam" => "models/beam.md",
                                         "Building" => "models/building.md",
                                         "CD Player" => "models/cdplayer.md",
                                         "Crane" => "models/crane.md",
                                         "Ellipse" => "models/ellipse.md",
                                         "Five Dim System" => "models/five_dim_sys.md",
                                         "Fom" => "models/fom.md",
                                         "Heat" => "models/heat.md",
                                         "Helicopter" => "models/helicopter.md",
                                         "ISS" => "models/iss.md",
                                         "MNA1" => "models/mna1.md",
                                         "MNA5" => "models/mna5.md",
                                         "Motor" => "models/motor.md",
                                         "PDE" => "models/pde.md",
                                         "Projectile" => "models/projectile.md"],
                "Nonlinear Dynamics" => Any["Overview" => "overview_nonlinear.md",
                                            "Biomodel 7d" => "models/biomodel7d.md",
                                            "Biomodel 9d" => "models/biomodel9d.md",
                                            "Brusselator" => "models/brusselator.md",
                                            "Bucking column" => "models/buckling_column.md",
                                            "Coupled VanDerPol" => "models/coupled_vanderpol.md",
                                            "Double Gyre" => "models/doublegyre.md",
                                            "Jet Engine" => "models/jet_engine.md",
                                            "Henon-Helies" => "models/henon_heiles.md",
                                            "Lotka-Volterra" => "models/lotka_volterra.md",
                                            "Lorenz" => "models/lorenz.md",
                                            "Robot Arm" => "models/robot_arm.md",
                                            "Roessler" => "models/roessler.md",
                                            "Spring Pendulum" => "models/spring_pendulum.md",
                                            "Steam Governor" => "models/steam_governor.md",
                                            "VanDerPol" => "models/vanderpol.md"],
                "Hybrid Dynamics" => Any["Overview" => "overview_hybrid.md",
                                         "Bouncing ball" => "models/bouncing_ball.md",
                                         "Nonlinear Bouncing ball" => "models/bouncing_ball_nonlinear.md",
                                         "Cardiac Cell" => "models/cardiac_cell.md",
                                         "Clocked Thermostat" => "models/clocked_thermostat.md",
                                         "Navigation System" => "models/navigation_system.md",
                                         "Powertrain Control" => "models/powertrain_control.md",
                                         "Spiking Neuron" => "models/spiking_neuron.md",
                                         "Thermostat" => "models/thermostat.md"],
                "References" => "references.md",
                "About" => "about.md"])

deploydocs(; repo="github.com/JuliaReach/ReachabilityModels.jl",
           push_preview=true)
