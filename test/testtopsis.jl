import GreyDecision.Utility: makeminmax
import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Topsis: topsis

@testset "Topsis sample" begin
    atol = 0.001
    decmat = [
        GreyNumber(1.0, 2.0) GreyNumber(2.0, 3.0) GreyNumber(3.0, 4.0);
        GreyNumber(2.0, 3.0) GreyNumber(1.0, 2.0) GreyNumber(3.0, 4.0);
        GreyNumber(3.0, 4.0) GreyNumber(2.0, 3.0) GreyNumber(1.0, 2.0);
    ]
    w = [0.5, 0.4, 0.1]
    fns = makeminmax([maximum, maximum, minimum])

    scores = topsis(decmat, w, fns)
    @test isapprox(scores[1], GreyNumber{Float64}(0.23506, 0.83613), atol = atol)
    @test isapprox(scores[2], GreyNumber{Float64}(0.24317, 1.00294), atol = atol)
    @test isapprox(scores[3], GreyNumber{Float64}(0.10851, 1.23913), atol = atol)
end

@testset "Grey Topsis with real numbers" begin
    atol = 0.001
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
    @test isapprox(result[1], GreyNumber{Float64}(0.38768, 0.38768), atol = atol)
    @test isapprox(result[2], GreyNumber{Float64}(0.65032, 0.65032), atol = atol)
    @test isapprox(result[3], GreyNumber{Float64}(0.08347, 0.08347), atol = atol)
end