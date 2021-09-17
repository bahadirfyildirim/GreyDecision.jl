import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Stats: I, mean, var, std, cor
@testset "Stats" begin
    @testset "Identity Matrix" begin
        x = I(3)

        @test x isa Array{GreyNumber{Float64}, 2}
        @test x[1, 1] isa GreyNumber

        @test x[1, 1] == GreyNumber{Float64}(1.0, 1.0)
        @test x[2, 2] == GreyNumber{Float64}(1.0, 1.0)
        @test x[3, 3] == GreyNumber{Float64}(1.0, 1.0)
        @test x[1, 2] == GreyNumber{Float64}(0.0, 0.0)
        @test x[1, 3] == GreyNumber{Float64}(0.0, 0.0)
        @test x[2, 1] == GreyNumber{Float64}(0.0, 0.0)
        @test x[2, 3] == GreyNumber{Float64}(0.0, 0.0)
        @test x[3, 1] == GreyNumber{Float64}(0.0, 0.0)
        @test x[3, 2] == GreyNumber{Float64}(0.0, 0.0)
    end

    @testset "Testing mean" begin
        x = [
            GreyNumber{Float64}(1.0, 1.0),
            GreyNumber{Float64}(2.0, 2.0),
            GreyNumber{Float64}(3.0, 3.0),
            GreyNumber{Float64}(4.0, 4.0),
            GreyNumber{Float64}(5.0, 5.0),
        ]
        mx = mean(x)
        @test mx == GreyNumber{Float64}(3.0, 3.0)
    end

    @testset "Testing var" begin
        x = [
            GreyNumber{Float64}(1.0, 1.0),
            GreyNumber{Float64}(2.0, 2.0),
            GreyNumber{Float64}(3.0, 3.0),
            GreyNumber{Float64}(4.0, 4.0),
            GreyNumber{Float64}(5.0, 5.0),
        ]
        varx = var(x)
        @test varx == GreyNumber{Float64}(2.5, 2.5)
    end

    @testset "Testing std" begin
        tol = 0.001
        x = [
            GreyNumber{Float64}(1.0, 1.0),
            GreyNumber{Float64}(2.0, 2.0),
            GreyNumber{Float64}(3.0, 3.0),
            GreyNumber{Float64}(4.0, 4.0),
            GreyNumber{Float64}(5.0, 5.0),
        ]
        stdx = std(x)
        @test isapprox(GreyNumber{Float64}(1.58113, 1.58113), stdx, atol = tol)
    end

    @testset "Testing cor" begin
        tol = 0.001
        x = [
            GreyNumber{Float64}(1.0, 1.0),
            GreyNumber{Float64}(2.0, 2.0),
            GreyNumber{Float64}(3.0, 3.0),
            GreyNumber{Float64}(4.0, 4.0),
            GreyNumber{Float64}(5.0, 5.0),
        ]
        y = reverse(x)

        cor1 = cor(x, x)
        @test isapprox(GreyNumber{Float64}(1.0, 1.0), cor1, atol = tol)

        cor2 = cor(x, y)
        @test isapprox(GreyNumber{Float64}(-1.0, -1.0), cor2, atol = tol)
    end
end
