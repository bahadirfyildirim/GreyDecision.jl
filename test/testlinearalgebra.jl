import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Utility: makeminmax
import LinearAlgebra: det


@testset "Transpose" begin
    x = [
        GreyNumber(5.0) GreyNumber(3.0) GreyNumber(-2.0);
        GreyNumber(-8.0) GreyNumber(6.0) GreyNumber(1.0);
        GreyNumber(10.0) GreyNumber(7.0) GreyNumber(13.0)
    ]
    xt = transpose(x)

    @test size(xt) == size(x)
    @test xt[1, 2] == x[2, 1]
    @test xt[1, 3] == x[3, 1]
    @test xt[1, 1] == x[1, 1]
    @test xt[2, 2] == x[2, 2]
    @test xt[3, 3] == x[3, 3]
end

@testset "det(x)" begin
    x = [
        GreyNumber(5.0) GreyNumber(3.0) GreyNumber(-2.0);
        GreyNumber(-8.0) GreyNumber(6.0) GreyNumber(1.0);
        GreyNumber(10.0) GreyNumber(7.0) GreyNumber(13.0)
    ]
    y = [
        5.0 3.0 -2.0;
        -8.0 6.0 1.0;
        10.0 7.0 13.0
    ]
    xdet = det(transpose(x) * x) 
    ydet = det(transpose(y) * y)
    
    @test ydet == xdet.a 
    @test ydet == xdet.b
end

@testset "inv(x)" begin
    atol = 0.001
     x = [
        GreyNumber(5.0) GreyNumber(3.0) GreyNumber(-2.0);
        GreyNumber(-8.0) GreyNumber(6.0) GreyNumber(1.0);
        GreyNumber(10.0) GreyNumber(7.0) GreyNumber(13.0)
    ]
    xtx = transpose(x) * x 
    invxyx = inv(xtx)
    result = invxyx * xtx
    
    @test isapprox(result[1,1].a, 1.0, atol = atol)
    @test isapprox(result[2,2].a, 1.0, atol = atol)
    @test isapprox(result[3,3].a, 1.0, atol = atol)
    @test isapprox(result[1,2].a, 0.0, atol = atol)
    @test isapprox(result[1,3].a, 0.0, atol = atol)
    @test isapprox(result[2,1].a, 0.0, atol = atol)
    @test isapprox(result[2,3].a, 0.0, atol = atol)
    @test isapprox(result[3,1].a, 0.0, atol = atol)
    @test isapprox(result[3,2].a, 0.0, atol = atol)
    
end