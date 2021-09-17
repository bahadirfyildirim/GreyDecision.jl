module Utility

import GreyDecision.GreyNumbers: GreyNumber 

mean(x) = sum(x) / length(x)

# euclidean(g1, g2) -> GreyNumber ?
# euclidean(g1, g2) -> Real ?
function euclidean(g1::Array{GreyNumber{T}, 1}, g2::Array{GreyNumber{T}, 1})::GreyNumber where {T <: Real} 
    return (g1 .- g2).^2.0 |> sum |> sqrt
end

function euclidean(v1::Array{GreyNumber{T}, 1})::GreyNumber where {T <: Real} 
    n = length(v1)
    v2 = map(x -> GreyNumber(zero(T), zero(T)), 1:n)
    return euclidean(v1, v2)
end

function apply_columns(fs::Array{Function,1}, data::Array{GreyNumber{T},2}) where {T <: Real}
    _, m = size(data)
    return [fs[i](data[:,i]) for i in 1:m]
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

function Base.zero(::Type{GreyNumber{T}}) where T
    return GreyNumber(zero(T), zero(T))
end

function Base.zero(::Type{GreyNumber})
    return GreyNumber(0.0, 0.0)
end

function Base.zero(g::GreyNumber{T})::GreyNumber{T} where T
    return GreyNumber(zero(T), zero(T))
end
                  

function Base.zeros(::Type{GreyNumber{T}}, n::Int64)::Array{GreyNumber{T}, 1} where T
    gs = Array{GreyNumber{T}, 1}(undef, n)
    for i in 1:n
        gs[i] = GreyNumber(zero(T), zero(T))
    end
    return gs
end

function Base.zeros(::Type{GreyNumber}, n::Int64, m::Int64)::Array{GreyNumber, 2}
    zeros(GreyNumber{Float64}, n, m)
end

function Base.zeros(::Type{GreyNumber}, t::Tuple{Int64, Int64})::Array{GreyNumber, 2}
    zeros(GreyNumber, first(t), last(t))
end

function Base.one(::Type{GreyNumber{T}}) where T
    return GreyNumber(one(T), one(T))
end

function Base.one(::Type{GreyNumber})
    return GreyNumber(1.0, 1.0)
end

function Base.one(g::GreyNumber{T})::GreyNumber{T} where T
    return GreyNumber(one(T), one(T))
end
                  
function Base.ones(::Type{GreyNumber{T}}, n::Int64)::Array{GreyNumber{T}, 1} where T
    gs = Array{GreyNumber{T}, 1}(undef, n)
    for i in 1:n
        gs[i] = GreyNumber(one(T), one(T))
    end
    return gs
end

function Base.ones(::Type{GreyNumber}, n::Int64, m::Int64)::Array{GreyNumber{Float64}, 2}
    ones(GreyNumber{Float64}, n, m)
end

function Base.ones(::Type{GreyNumber}, t::Tuple{Int64, Int64})::Array{GreyNumber{Float64}, 2}
    ones(GreyNumber, first(t), last(t))
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

function normalize(v1::Array{GreyNumber{T},1})::Array{GreyNumber{T},1} where {T <: Real}
    disttoorigin = euclidean(v1)
    return map(x -> x / disttoorigin, v1) 
end

function normalize(datamat::Array{GreyNumber{T},2})::Array{GreyNumber{T},2} where {T <: Real}
    newdata = similar(datamat)
    _, p = size(datamat)
    for i in 1:p
        newdata[:, i] = normalize(datamat[:, i])
    end
    return newdata
end

function unitize(v::Array{T,1})::Array{Float64,1} where {T <: Number}
    return v ./ sum(v)
end


function weightize(data::Array{GreyNumber{T}, 2}, w::Array{Float64, 1})::Array{GreyNumber{T}, 2} where {T <: Real}
    n, p = size(data)
    newdata = Array{GreyNumber{T}, 2}(undef, n, p)
    for i in 1:p
        newdata[:, i] = map(x -> w[i] * x, data[:, i])
    end
    return newdata
end             

function Base.isapprox(x::GreyNumber{T}, y::GreyNumber{T}; atol::Real=0)::Bool where {T <: Real}
    return isapprox(first(x), first(y), atol = atol) && isapprox(last(x), last(y), atol = atol)
end

end # end of module Utility
