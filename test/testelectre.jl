import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Utility: makeminmax
import GreyDecision.Electre: electre

@testset "Electre with white numbers" begin 
    tol = 0.00001
        w = [0.110, 0.035, 0.379, 0.384, 0.002, 0.002, 0.010, 0.077]
        Amat = [
            100 92 10 2 80 70 95 80
            80 70 8 4 100 80 80 90
            90 85 5 0 75 95 70 70
            70 88 20 18 60 90 95 85
        ]
        greyamat = Array{GreyNumber{Float64}, 2}(undef, 4, 8)
        for i in 1:4
            for j in 1:8
                greyamat[i,j] = GreyNumber{Float64}(Float64(Amat[i,j]), Float64(Amat[i, j]))
            end
        end
        dmat = greyamat
        fns = makeminmax([maximum for i = 1:8])
        result = electre(dmat, w, fns)

        @test isa(result, Dict)
        @test isa(result[:bestindex], Tuple)
        @test result[:bestindex][1] == 4

        @test isapprox(result[:C][1], GreyNumber(0.36936937,0.36936937), atol = tol)
        @test isapprox(result[:C][2], GreyNumber(0.01501502, 0.01501502),  atol = tol)
        @test isapprox(result[:C][3], GreyNumber(-2.47347347, -2.47347347),  atol = tol)
        @test isapprox(result[:C][4], GreyNumber(2.08908909, 2.08908909), atol = tol)
            
        @test isapprox(result[:D][1], GreyNumber(0.1914244, 0.1914244), atol = tol)
        @test isapprox(result[:D][2], GreyNumber(-0.1903929,-0.1903929),  atol = tol)
        @test isapprox(result[:D][3], GreyNumber(2.8843076, 2.8843076),  atol = tol)
        @test isapprox(result[:D][4], GreyNumber(-2.8853391, -2.8853391), atol = tol)
end