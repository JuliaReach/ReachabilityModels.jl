using ReachabilityModels, Test
import Aqua

@testset "Aqua tests" begin
    Aqua.test_all(ReachabilityModels)
end
