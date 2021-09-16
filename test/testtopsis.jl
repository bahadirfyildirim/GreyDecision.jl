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

@testset "Grey Topsis with real numbers" begin
    num6 = GreyNumber{Float64}(6.0, 6.0)
    num7 = GreyNumber{Float64}(7.0, 7.0)
    num8 = GreyNumber{Float64}(8.0, 8.0)
    num9 = GreyNumber{Float64}(9.0, 9.0)
    decmat = [
        num9 num7 num6 num7;
        num8 num7 num9 num6;
        num7 num8 num6 num6
    ]
    w = [4.0, 2, 6, 8]
    fns = makeminmax([maximum, maximum, maximum, maximum])
    result = topsis(decmat, w, fns)
    @test result[1] == GreyNumber{Float64}(0.3876869549221182, 0.3876869549221182)
    @test result[2] == GreyNumber{Float64}(0.6503238218850165, 0.6503238218850165)
    @test result[3] == GreyNumber{Float64}(0.08347670030339038, 0.08347670030339038)
end