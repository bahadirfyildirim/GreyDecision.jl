import GreyDecision.Random
import GreyDecision.Utility
import GreyDecision.GreyNumbers: GreyNumber

@testset "Random Grey Numbers" begin

    @testset "Single Random GreyNumber" begin
        g = rand(GreyNumber)
        @test first(g) >= 0.0
        @test last(g) <= 1.0
    end

    @testset "Typed Random GreyNumber" begin
        g = rand(GreyNumber{Float64})
        @test first(g) >= 0.0
        @test last(g) <= 1.0

        h = rand(GreyNumber{UInt8})
        @test first(h) < 256
        @test last(h) >= 0
    end

    @testset "Array of random grey numbers" begin
        v = rand(GreyNumber{Float64}, 10)

        @test length(v) == 10
        @test typeof(v[1]) == GreyNumber{Float64}
        @test first(v[1]) >= 0.0
        @test last(v[1]) <= 1.0
    end

    @testset "Matrix of random grey numbers" begin
        v = rand(GreyNumber{Float64}, 10, 20)

        @test size(v) == (10, 20)
        @test typeof(v[1, 1]) == GreyNumber{Float64}
        @test first(v[1, 1]) >= 0.0
        @test last(v[1, 2]) <= 1.0
        @test first(v[2, 1]) >= 0.0
        @test last(v[2, 2]) <= 1.0
    end

end
