import GreyDecision.Utility
import GreyDecision.GreyNumbers: GreyNumber

@testset "zeros" begin
    @testset "zero" begin
        @test zero(GreyNumber{Int64}) == GreyNumber(0, 0)
        @test zero(GreyNumber{Float64}) == GreyNumber(0.0, 0.0)
    end
    
    @testset "zeros vector" begin
        z = zeros(GreyNumber, 10)
        g = z[1]
        @test length(z) == 10
        @test g isa GreyNumber
        @test g.a isa Float64
        @test g.b isa Float64
    end

    @testset "zeros matrix" begin
        z = zeros(GreyNumber, 10, 3)
        @test size(z) == (10, 3)
        @test z isa Matrix
        @test z[1, 1] == GreyNumber(0.0, 0.0)
    end

    @testset "zeros matrix with tuple" begin
        z = zeros(GreyNumber, (20, 2))
        @test size(z) == (20, 2)
        @test z isa Matrix
        @test z[1, 1] == GreyNumber(0.0, 0.0)
    end
    
end

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
        @test result == Utility.colsums(greys)
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
        @test result == Utility.colmins(greys)
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
        @test result == Utility.colmaxs(greys)
     end

     @testset "Apply mean to columns" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_columns(Utility.mean, greys)
        @test length(result) == 2
        @test result[1] == GreyNumber(8/3, 11/3)
        @test result[2] == GreyNumber(80/3, 110/3)
        @test result == Utility.colmeans(greys)
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
        @test result == Utility.rowsums(greys)
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
        @test result == Utility.rowmins(greys) 
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
        @test result == Utility.rowmaxs(greys) 
     end

     @testset "Apply mean to rows" begin
        greys = [
            GreyNumber(1, 2) GreyNumber(10, 20);
            GreyNumber(3, 4) GreyNumber(30, 40);
            GreyNumber(4, 5) GreyNumber(40, 50);
        ]
        result = Utility.apply_rows(Utility.mean, greys)
        @test length(result) == 3
        @test result[1] == GreyNumber(11/2, 22/2)
        @test result[2] == GreyNumber(33/2, 44/2)
        @test result[3] == GreyNumber(44/2, 55/2) 
        @test result == Utility.rowmeans(greys)
     end
 end

@testset "isvalid" begin
    @test isvalid(GreyNumber())
    @test isvalid(GreyNumber(7, 8))
    # if lower bound is not less or equal
    # than the upper bound, the type
    # constructor automatically replace
    # them to make the number valid.
    @test isvalid(GreyNumber(8, 7))
end

@testset "convert" begin
    g = GreyNumber(2, 5)
    arr = convert(Array{Float64, 1}, g)
    @test arr isa Array{Float64, 1}
    @test arr[1] == 2.0
    @test arr[2] == 5.0
end


@testset "Reverse minimum & maximum array" begin
    fns = [minimum, maximum, maximum, minimum, maximum]
    revfns = [maximum, minimum, minimum, maximum, minimum]
    @test Utility.reverseminmax(fns) == revfns 
    @test Utility.reverseminmax(revfns) == fns 
end

@testset "Make Array of minimum and maximum" begin
    result1 = Utility.makeminmax([maximum, maximum, maximum, maximum])
    @test typeof(result1) == Array{Function,1}
    @test typeof(result1[1]([1.0, 2.0, 3.0])) == Float64 
    @test result1[1]([1.0, 2.0, 3.0]) == 3.0 
end

@testset "Product weight vector with columns of matrix" begin
    data = [
        GreyNumber(1.0, 2.0) GreyNumber(2.0, 3.0) GreyNumber(3.0, 4.0);
        GreyNumber(1.0, 2.0) GreyNumber(2.0, 3.0) GreyNumber(3.0, 4.0);
        GreyNumber(1.0, 2.0) GreyNumber(2.0, 3.0) GreyNumber(3.0, 4.0)
    ]
    w = [0.5, 10, 100]
    result = Utility.weightize(data,  w)

    @test size(result) == (3, 3)
    @test typeof(result) == Array{GreyNumber, 2}
    
    @test result[:,1] == [
        GreyNumber(0.5, 1.0),
        GreyNumber(0.5, 1.0),
        GreyNumber(0.5, 1.0)
    ]

    @test result[:,2] == [
        GreyNumber(2.0 * 10, 3.0 * 10),
        GreyNumber(2.0 * 10, 3.0 * 10),
        GreyNumber(2.0 * 10, 3.0 * 10)
    ]

     @test result[:,3] == [
        GreyNumber(3.0 * 100, 4.0 * 100),
        GreyNumber(3.0 * 100, 4.0 * 100),
        GreyNumber(3.0 * 100, 4.0 * 100)
    ]

end
