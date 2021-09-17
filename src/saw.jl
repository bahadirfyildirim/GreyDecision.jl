module Saw

import GreyDecision.GreyNumbers.GreyNumber
import GreyDecision.Utility: unitize, rowsums, weightize, reverseminmax

function saw(decisionMat::Array{GreyNumber{T}, 2}, weights::Array{Float64,1}, fns::Array{Function,1};  v::Float64=0.5) where {T <: Real}
    n, p = size(decisionMat)
    
    normalizedDecisionMat = similar(decisionMat)
        
    w = unitize(weights)
            
    colminmax = zeros(GreyNumber{Float64}, p)

    for i in 1:p
        colminmax[i] = decisionMat[:, i] |> fns[i]
        if fns[i] == maximum
            normalizedDecisionMat[:, i] = map(x -> x / colminmax[i], decisionMat[:, i]) 
        elseif fns[i] == minimum 
            normalizedDecisionMat[:, i] = map(x -> colminmax[i] / x, decisionMat[:, i])
        else
            @error fns[i]
            error("Function not found")
        end
    end
    
    scores = weightize(normalizedDecisionMat, w) |> rowsums

    rankings = scores |> sortperm |> reverse
    
    bestIndex = rankings |> first

    return Dict(
        :scores => scores, 
        :rankings => rankings,
        :bestindex => bestIndex
    )
end


end # End of module saw