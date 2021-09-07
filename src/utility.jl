module Utility

import GreyDecision.GreyNumbers: GreyNumber 

mean(x) = sum(x) / length(x)

# euclidean(g1, g2) -> GreyNumber ?
# euclidean(g1, g2) -> Real ?
function euclidean(g1::GreyNumber{T}, g2::GreyNumber{T})::Float64 where {T<: Number} 
    return (g1 .- g2).^2.0 |> sum |> sqrt
end

function euclidean(v1::GreyNumber{T})::Float64 where T <: Number
    v2 = GreyNumber(zero(T), zero(T))
    return euclidean(v1, v2)
end

function apply_columns(f::Function, data::Array{GreyNumber{T},2}) where T <: Real
    _, p = size(data)
    return [f(data[:,i]) for i in 1:p]
end

function apply_rows(f::Function, data::Array{GreyNumber{T},2}) where T <: Real
    n, _ = size(data)
    return [f(data[i,:]) for i in 1:n]
end

function colmins(data::Array{GreyNumber{T}, 2}) where T <: Real 
    return apply_columns(minimum, data)
end

function colmaxs(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_columns(maximum, data)
end

function colsums(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_columns(sum, data)
end

function colmeans(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_columns(mean, data)
end

function rowmins(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_rows(minimum, data)
end

function rowmaxs(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_rows(maximum, data)
end

function rowsums(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_rows(sum, data)
end

function rowmeans(data::Array{GreyNumber{T}, 2}) where T <: Real
    return apply_rows(mean, data)
end

end # end of module Utility
