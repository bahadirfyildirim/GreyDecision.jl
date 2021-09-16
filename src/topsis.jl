module Topsis

import GreyDecision.GreyNumbers.GreyNumber
import GreyDecision.Utility: normalize, unitize, weightize, apply_columns, reverseminmax, euclidean

function topsis(decisionMat::Array{GreyNumber{T}, 2}, weights::Array{Float64,1}, fns::Array{Function,1}) where {T <: Real}
    w = unitize(weights)
    
    nalternatives, ncriteria = size(decisionMat)

    normalizedMat = normalize(decisionMat)

    weightednormalizedMat = weightize(normalizedMat, weights)

    col_max = apply_columns(fns, weightednormalizedMat)
    col_min = apply_columns(reverseminmax(fns), weightednormalizedMat)

    distances_plus  = zeros(GreyNumber{Float64}, nalternatives)
    distances_minus = zeros(GreyNumber{Float64}, nalternatives)

    scores = zeros(GreyNumber{Float64}, nalternatives)

    for i in 1:nalternatives
        ithrow = weightednormalizedMat[i,:] 
		distances_plus[i]  = euclidean(col_max, ithrow)
		distances_minus[i] = euclidean(col_min, ithrow)
		scores[i] = distances_minus[i] / (distances_minus[i] + distances_plus[i])
    end

    return scores
end


end # End of module Topsis
