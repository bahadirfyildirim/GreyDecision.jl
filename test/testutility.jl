import GreyDecision.Utility
import GreyDecision.GreyNumbers: GreyNumber

@testset "Euclidean distance" begin
    @testset "Distance to origin" begin
        @test Utility.euclidean(GreyNumber()) == 0.0        
    end
end