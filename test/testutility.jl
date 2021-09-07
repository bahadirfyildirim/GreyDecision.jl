import GreyDecision.Utility
import GreyDecision.GreyNumbers: GreyNumber

@testset "Euclidean distance" begin
    @testset "Distance to origin" begin
        @test Utility.euclidean(GreyNumber()) == 0.0        
    end
    @testset "Distance to two grey numbers" begin
        @test Utility.euclidean(
            GreyNumber(0.0, 0.0),
            GreyNumber(0.0, 1.0)) == 1.0        
    end
end

@testset "Apply columns" begin
    @testset "Apply sum to columns" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_columns(sum, greys)
        @test length(result) == 2
        @test result[1] == GreyNumber(8, 11)
        @test result[2] == GreyNumber(80, 110)
    end
    
    @testset "Apply minimum to columns" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_columns(minimum, greys)
        @test length(result) == 2
        @test result[1] == GreyNumber(1, 2)
        @test result[2] == GreyNumber(10, 20)
    end
    
     @testset "Apply maximum to columns" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_columns(maximum, greys)
        @test length(result) == 2
        @test result[1] == GreyNumber(4, 5)
        @test result[2] == GreyNumber(40, 50)
    end
end


@testset "Apply rows" begin
    @testset "Apply sum to rows" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_rows(sum, greys)
        @test length(result) == 3
        @test result[1] == GreyNumber(11, 22)
        @test result[2] == GreyNumber(33, 44)
        @test result[3] == GreyNumber(44, 55)
    end

     @testset "Apply minimum to rows" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_rows(minimum, greys)
        @test length(result) == 3
        @test result[1] == GreyNumber(1, 2)
        @test result[2] == GreyNumber(3, 4)
        @test result[3] == GreyNumber(4, 5) 
    end
    
     @testset "Apply maximum to rows" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_rows(maximum, greys)
        @test length(result) == 3
        @test result[1] == GreyNumber(10, 20)
        @test result[2] == GreyNumber(30, 40)
        @test result[3] == GreyNumber(40, 50) 
    end
end
