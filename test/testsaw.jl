import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Saw: saw


@testset "Saw in white numbers" begin
    tol = 0.0001
        mat = [
            GreyNumber{Float64}(25.0, 25.0) GreyNumber{Float64}(65.0, 65.0) GreyNumber{Float64}(07.0, 07.0) GreyNumber{Float64}(20.0, 20.0);
            GreyNumber{Float64}(21.0, 21.0) GreyNumber{Float64}(78.0, 78.0) GreyNumber{Float64}(06.0, 06.0) GreyNumber{Float64}(24.0, 24.0);
            GreyNumber{Float64}(19.0, 19.0) GreyNumber{Float64}(53.0, 53.0) GreyNumber{Float64}(05.0, 05.0) GreyNumber{Float64}(33.0, 33.0);
            GreyNumber{Float64}(22.0, 22.0) GreyNumber{Float64}(25.0, 25.0) GreyNumber{Float64}(02.0, 02.0) GreyNumber{Float64}(31.0, 31.0)
        ]
        weights = [0.25, 0.25, 0.25, 0.25]
        fns = [maximum, maximum, minimum, maximum]
        result = saw(mat, weights, fns)
        @test isapprox(result[:scores][1], GreyNumber{Float64}(0.681277, 0.681277), atol = tol)
        @test isapprox(result[:scores][2], GreyNumber{Float64}(0.725151, 0.725151), atol = tol)
        @test isapprox(result[:scores][3], GreyNumber{Float64}(0.709871, 0.709871), atol = tol)
        @test isapprox(result[:scores][4], GreyNumber{Float64}(0.784976, 0.784976), atol = tol)
end