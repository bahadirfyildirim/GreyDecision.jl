module Moora 

import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Utility: unitize, normalize, weightize, apply_columns, reverseminmax, rowmaxs

function moora(decisionMat::Array{GreyNumber{T}, 2}, weights::Array{Float64,1}, fns::Array{Function,1};  v::Float64=0.5) where {T <: Real}

    w = unitize(weights)

    nalternatives, ncriteria = size(decisionMat)

    normalizedMat = normalize(decisionMat)
    weightednormalizedMat = weightize(normalizedMat, w)

    # cmaxs = colmaxs(weightednormalizedMat)
    cmaxs = apply_columns(fns, weightednormalizedMat)
    cmins = apply_columns(reverseminmax(fns), weightednormalizedMat)

    refmat = similar(weightednormalizedMat)

    for rowind in 1:nalternatives
        if fns[rowind] == maximum 
            refmat[rowind, :] .= cmaxs - weightednormalizedMat[rowind, :]
        elseif fns[rowind] == minimum
            refmat[rowind, :] .= weightednormalizedMat[rowind, :] - cmins
        else
            @warn fns[rowind]
            error("Function must be either maximize or minimize")
        end
    end

    scores = rmaxs = rowmaxs(refmat)

    bestIndex = sortperm(rmaxs) |> first 

    return Dict(
        :scores => scores, 
        :bestindex => bestIndex
    )
end


end # end of module Moora