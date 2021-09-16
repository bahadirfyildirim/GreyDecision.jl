import GreyDecision.Utility: makeminmax
import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Topsis: topsis

@testset "Topsis sample" begin
    decmat = [
        GreyNumber(1.0, 2.0) GreyNumber(2.0, 3.0) GreyNumber(3.0, 4.0);
        GreyNumber(2.0, 3.0) GreyNumber(1.0, 2.0) GreyNumber(3.0, 4.0);
        GreyNumber(3.0, 4.0) GreyNumber(2.0, 3.0) GreyNumber(1.0, 2.0);
    ]
    w = [0.5, 0.4, 0.1]
    fns = makeminmax([maximum, maximum, minimum])

    scores = topsis(decmat, w, fns)
    @test scores[1] == GreyNumber{Float64}(0.2350699228751952, 0.83613099715003)
    @test scores[2] == GreyNumber{Float64}(0.24317523558639148, 1.002942207810138)
    @test scores[3] == GreyNumber{Float64}(0.10851899761349458, 1.23913068959885)
end