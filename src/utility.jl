module Utility

import GreyDecision.GreyNumbers: GreyNumber 

# euclidean(g1, g2) -> GreyNumber ?
# euclidean(g1, g2) -> Real ?
function euclidean(g1::GreyNumber{T}, g2::GreyNumber{T})::Float64 where {T<: Number} 
    return (g1 .- g2).^2.0 |> sum |> sqrt
end

function euclidean(v1::GreyNumber{T})::Float64 where T <: Number
    v2 = GreyNumber(zero(T), zero(T))
    return euclidean(v1, v2)
end

end # end of module Utility
