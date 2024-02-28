using ReachabilityModels, Test
import Aqua

@testset "Aqua tests" begin
    Aqua.test_all(ReachabilityModels; ambiguities=false)

    # do not warn about ambiguities in dependencies
    Aqua.test_ambiguities(ReachabilityModels)
end
