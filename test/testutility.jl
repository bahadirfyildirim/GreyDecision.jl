import GreyDecision.Utility
import GreyDecision.GreyNumbers: GreyNumber

@testset "Euclidean distance" begin
    @testset "Distance to origin" begin
        @test Utility.euclidean(GreyNumber()) == 0.0        
    end
    @testset "Distance to two grey numbers" begin
        @test Utility.euclidean(
            GreyNumber(0.0, 0.0),
            GreyNumber(0.0, 1.0)) == 1.0        
    end
end