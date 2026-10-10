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

import Pkg
@static if VERSION >= v"1.10"
    # JET v0.9.0 (earliest supported version) requires Julia v1.10
    Pkg.add("JET")
    import JET

    @testset "JET tests" begin
        JET.test_package(ReachabilityModels)
    end
end

@testset "Aqua tests" begin
    Aqua.test_all(ReachabilityModels)
end
