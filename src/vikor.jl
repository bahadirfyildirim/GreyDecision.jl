module Vikor

import GreyDecision.GreyNumbers.GreyNumber
import GreyDecision.Utility: unitize, apply_columns, weightize, reverseminmax

function vikor(decisionMat::Array{GreyNumber{T}, 2}, weights::Array{Float64,1}, fns::Array{Function,1};  v::Float64=0.5) where {T <: Real}
    
    w = unitize(weights)

    nalternatives, ncriteria = size(decisionMat)
    
    col_max = apply_columns(fns, decisionMat)
    col_min = apply_columns(reverseminmax(fns), decisionMat)

    A = similar(decisionMat)

    for i in 1:nalternatives
        for j in 1:ncriteria
            if fns[j] == maximum
                 A[i, j] = abs((col_max[j] - decisionMat[i, j]) / (col_max[j] - col_min[j]))
            elseif fns[j] == minimum 
                 A[i, j] = abs((decisionMat[i, j] - col_min[j]) / (col_max[j] - col_min[j]))
            else
                @warn fns[j]
                error("Function must be either maximum or minimum.")
            end    
        end
    end

    weightedA = weightize(A, w)

    s = Array{GreyNumber{Float64},1}(undef, nalternatives)
    r = similar(s)
    q = similar(s)

    for i in 1:nalternatives
        s[i] = sum(weightedA[i,:])
        r[i] = maximum(weightedA[i,:])
    end

    smin = minimum(s)
    smax = maximum(s)
    rmin = minimum(r)
    rmax = maximum(r)
    ranges = (smax - smin)
    ranger = (rmax - rmin)
    for i in 1:nalternatives
        #q = v .* ((s .- smin ./ (smax - smin))) .+ (1 - v) .* ((r .- rmin ./ (rmax - rmin)))
        q[i] = v * (s[i] - smin / ranges) + (1.0-v) * (r[i] - rmin / ranger)
    end

    best_index = sortperm(q) |> first

    return Dict(
        :scores => q,
        :bestindex => best_index
    )
end # end of Vikor function


end # End of module Vikor
