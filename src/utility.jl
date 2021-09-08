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

function Base.zeros(::Type{GreyNumber}, n::Int64)::Array{GreyNumber, 1}
    gs = Array{GreyNumber{Float64}, 1}(undef, n)
    for i in 1:n
        gs[i] = GreyNumber(0.0, 0.0)
    end
    return gs
end

function Base.zeros(::Type{GreyNumber}, n::Int64, m::Int64)::Array{GreyNumber, 2}
    gs = Array{GreyNumber{Float64}, 2}(undef, n, m)
    for i in 1:n
        for j in 1:m
            gs[i, j] = GreyNumber(0.0, 0.0)
        end
    end
    return gs
end

function Base.zeros(::Type{GreyNumber}, t::Tuple{Int64, Int64})::Array{GreyNumber, 2}
    zeros(GreyNumber, first(t), last(t))
end

function Base.isvalid(g::GreyNumber)::Bool
    return g.a <= g.b
end


function Base.convert(::Type{Array{T, 1}}, g::GreyNumber)::Array{T, 1} where T
    arr = Array{T, 1}(undef, 2)
    arr[1] = min(g.a, g.b)
    arr[2] = max(g.a, g.b)
    return arr
end


function reverseminmax(fns::Array{Function,1})::Array{Function,1}
    newfs = map(x -> if x == minimum maximum else minimum end, fns)
    return newfs
end

function makeminmax(fns::Array{K,1} where K)::Array{Function,1}
    return convert(Array{Function,1}, fns)
end

                                       

end # end of module Utility
