import GreyDecision.Utility: makeminmax
import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Vikor: vikor

@testset "Grey Vikor with real numbers" begin
    tol = 0.0001
    w =  [0.110, 0.035, 0.379, 0.384, 0.002, 0.002, 0.010, 0.077]
    #Amat = [
    #  100 92 10 2 80 70 95 80 ;
    #  80  70 8  4 100 80 80 90 ;
    #  90 85 5 0 75 95 70 70 ; 
    #  70 88 20 18 60 90 95 85
    #]
    Amat = [
    GreyNumber{Float64}(100.0, 100.0) GreyNumber{Float64}(92.0, 92.0) GreyNumber{Float64}(10.0, 10.0) GreyNumber{Float64}(2.0, 2.0) GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(95.0, 95.0) GreyNumber{Float64}(80.0, 80.0);
    GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(8.0, 8.0) GreyNumber{Float64}(4.0, 4.0) GreyNumber{Float64}(100.0, 100.0) GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(80.0, 80.0) GreyNumber{Float64}(90.0, 90.0);
    GreyNumber{Float64}(90.0, 90.0) GreyNumber{Float64}(85.0, 85.0) GreyNumber{Float64}(5.0, 5.0) GreyNumber{Float64}(0.0, 0.0) GreyNumber{Float64}(75.0, 75.0) GreyNumber{Float64}(95.0, 95.0) GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(70.0, 70.0);
    GreyNumber{Float64}(70.0, 70.0) GreyNumber{Float64}(88.0, 88.0) GreyNumber{Float64}(20.0, 20.0) GreyNumber{Float64}(18.0, 18.0) GreyNumber{Float64}(60.0, 60.0) GreyNumber{Float64}(90.0, 90.0) GreyNumber{Float64}(95.0, 95.0) GreyNumber{Float64}(85.0, 85.0)
    ]

    fns = makeminmax([maximum, maximum, maximum, maximum, maximum, maximum, maximum, maximum])
    
    vikorresult = vikor(Amat, w, fns)

    @test vikorresult[:bestindex] == 4
    
    @test isapprox(vikorresult[:scores][1], GreyNumber(0.7489, 0.7489), atol=tol)
    @test isapprox(vikorresult[:scores][2], GreyNumber(0.7332,0.73320), atol=tol)
    @test isapprox(vikorresult[:scores][3], GreyNumber(1.0,1.0), atol=tol)
    @test isapprox(vikorresult[:scores][4], GreyNumber(0.0,0.0), atol=tol) 

end