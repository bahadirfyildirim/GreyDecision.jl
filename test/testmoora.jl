import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Utility: makeminmax
import GreyDecision.Moora: moora

@testset "Moora with white numbers" begin
    tol = 0.0001
    w =  [0.110, 0.035, 0.379, 0.384, 0.002, 0.002, 0.010, 0.077]
    Amat = [
        GreyNumber{Float64}(100.0, 100.0) GreyNumber{Float64}(92.0, 92.0) GreyNumber{Float64}(10.0, 10.0) GreyNumber{Float64}(2.0, 2.0) GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(95.0, 95.0) GreyNumber{Float64}(80.0, 80.0)
        GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(8.0, 8.0) GreyNumber{Float64}(4.0, 4.0) GreyNumber{Float64}(100.0, 100.0) GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(90.0, 90.0)
        GreyNumber{Float64}(90.0, 90.0) GreyNumber{Float64}(85.0, 85.0) GreyNumber{Float64}(5.0, 5.0) GreyNumber{Float64}(0.0, 0.0) GreyNumber{Float64}(75.0, 75.0) GreyNumber{Float64}(95.0, 95.0) GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(70.0, 70.0)
        GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(88.0, 88.0) GreyNumber{Float64}(20.0, 20.0) GreyNumber{Float64}(18.0, 18.0) GreyNumber{Float64}(60.0, 60.0) GreyNumber{Float64}(90.0, 90.0) GreyNumber{Float64}(95.0, 95.0) GreyNumber{Float64}(85.0, 85.0)
    ]
    fns = makeminmax([maximum, maximum, maximum, maximum, maximum, maximum, maximum, maximum])
    
    result = moora(Amat, w, fns)
    scores = result[:scores]

    @test result[:bestindex] == 4
    
    @test isapprox(scores[1], GreyNumber(0.33159387), atol = tol)
    @test isapprox(scores[2], GreyNumber(0.29014464), atol = tol)
    @test isapprox(scores[3], GreyNumber(0.37304311), atol = tol)
    @test isapprox(scores[4], GreyNumber(0.01926526), atol = tol)
 end


