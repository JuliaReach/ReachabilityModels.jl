using SpaceExParser
using SpaceExParser: _get_coeffs
using MathematicalSystems
using MAT

H = readsxmodel("heli_modif.xml"; raw_dict=true, ST=ConstrainedLinearControlContinuousSystem)

state_vars = convert.(SpaceExParser.Basic, collect(keys(H["variables"]))[1:28])
input_vars = convert.(SpaceExParser.Basic, collect(keys(H["variables"]))[29:34]);

A, B = _get_coeffs(H["flows"][1], 28, 6, state_vars, input_vars);

matwrite("heli.mat", Dict("A" => A, "B" => B))
