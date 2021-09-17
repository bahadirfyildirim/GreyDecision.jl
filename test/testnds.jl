import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.NDS: nds


@testset "Test nondominated-sorting on white numbers in type of Grey Numbers" begin
    #cases = [
    #    1.0 2.0 3.0;
    #    2.0 1.0 3.0;
    #    1.0 3.0 2.0;
    #    4.0 5.0 6.0
    #]
    cases = [
        GreyNumber{Float64}(1.0, 1.0) GreyNumber{Float64}(2.0, 2.0) GreyNumber{Float64}(3.0, 3.0);
        GreyNumber{Float64}(2.0, 2.0) GreyNumber{Float64}(1.0, 1.0) GreyNumber{Float64}(2.0, 2.0);
        GreyNumber{Float64}(1.0, 1.0) GreyNumber{Float64}(3.0, 3.0) GreyNumber{Float64}(2.0, 2.0);
        GreyNumber{Float64}(4.0, 4.0) GreyNumber{Float64}(5.0, 5.0) GreyNumber{Float64}(6.0, 6.0)
    ]


    result = nds(cases)

    bestindex = result[:bestindex]
    ranks = result[:ranks]

    @test bestindex == 4

    @test ranks == [0, 0, 0, 3]
end