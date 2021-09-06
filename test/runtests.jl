using Test
using GreyDecision

@testset "Grey Numbers" begin
    
    @testset "Data structure - Zero Constructor" begin
        g = GreyNumber()
        @test g.a == 0.0
        @test g.b == 0.0
    end

    @testset "Data structure - Constructor" begin
        g = GreyNumber(5.0, 2.0)
        @test g.a == 5.0
        @test g.b == 2.0
    end
    
    @testset "Whitenization" begin
        g = GreyNumber(10.0, 20.0)
        w = whitenizate(g)
        @test w == 15.0

        w2 = whitenizate(g, t = 1.0)
        @test w2 == 10.0

        w3 = whitenizate(g, t = 0.0)
        @test w3 == 20.0
    end

    @testset "+" begin
        g1 = GreyNumber(1, 2)
        g2 = GreyNumber(5, 10)
        greysum = g1 + g2
        @test greysum isa GreyNumber
        @test greysum.a == 6
        @test greysum.b == 12
    end

    @testset "Additive inverse (negatition)" begin
        g = GreyNumber(10, 20)
        ginv = -g 
        @test ginv isa GreyNumber
        @test ginv.a == -20
        @test ginv.b == - 10
    end

    @testset "Substraction" begin 
        g1 = GreyNumber(10, 20)
        g2 = GreyNumber(1, 2)
        gdiff1 = g1 - g2
        gdiff2 = g2 - g1
        @test gdiff1 isa GreyNumber
        @test gdiff2 isa GreyNumber
        @test gdiff1.a == 8 
        @test gdiff1.b == 19
        @test gdiff2.a == -19
        @test gdiff2.b == -8 
    end

    @testset "Multiplication" begin
        g1 = GreyNumber(3, 4)
        g2 = GreyNumber(5, 10)
        mult = g1 * g2
        @test mult isa GreyNumber
        @test mult.a == 15 
        @test mult.b == 40 
    end

    @testset "Multiplication by scalar" begin
        @testset "Scalar on the right" begin
            g1 = GreyNumber(10, 20)
            result = g1 * 10
            @test result isa GreyNumber
            @test result.a == 100
            @test result.b == 200
        end
        @testset "Scalar on the left" begin
            g1 = GreyNumber(10, 20)
            result = 10 * g1
            @test result isa GreyNumber
            @test result.a == 100
            @test result.b == 200
        end
    end

    @testset "Reciprocal (inverse)" begin
        g = GreyNumber(10, 20)
        repic = inv(g)
        @test repic isa GreyNumber
        @test repic.a == 1/20
        @test repic.b == 1/10
    end

    @testset "Division" begin
        g1 = GreyNumber(3, 4)
        g2 = GreyNumber(5, 10)
        division = g1 / g2
        @test division isa GreyNumber
        @test division.a == 0.3
        @test division.b == 0.8
    end

    @testset "Power" begin
        g = GreyNumber(2, 4)
        powered = g^5
        @test powered isa GreyNumber
        @test powered.a == 32
        @test powered.b == 1024
    end
 end