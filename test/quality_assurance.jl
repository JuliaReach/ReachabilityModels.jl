using ReachabilityModels, Test
import Aqua, ExplicitImports

@testset "ExplicitImports tests" begin
    @test isnothing(ExplicitImports.check_all_explicit_imports_are_public(ReachabilityModels))
    @test isnothing(ExplicitImports.check_all_explicit_imports_via_owners(ReachabilityModels))
    ignores = (:invokelatest,)
    @test isnothing(ExplicitImports.check_all_qualified_accesses_are_public(ReachabilityModels;
                                                                            ignore=ignores))
    @test isnothing(ExplicitImports.check_all_qualified_accesses_via_owners(ReachabilityModels))
    @test isnothing(ExplicitImports.check_no_implicit_imports(ReachabilityModels;
                                                              allow_unanalyzable=(ReachabilityModels,)))
    @test isnothing(ExplicitImports.check_no_self_qualified_accesses(ReachabilityModels))
    @test isnothing(ExplicitImports.check_no_stale_explicit_imports(ReachabilityModels;
                                                                    allow_unanalyzable=(ReachabilityModels,)))
end

@testset "Aqua tests" begin
    Aqua.test_all(ReachabilityModels)
end
