"""
Liu S., Yang Y., Forrest J. (2017) Grey Numbers and Their Operations. In: Grey Data Analysis. 
Computational Risk Management. Springer, Singapore. https://doi.org/10.1007/978-981-10-1841-1_3
"""
module GreyNumbers 

struct GreyNumber{T<:Real}
    a::T
    b::T
    GreyNumber{T}(x::T, y::T) where {T <: Real} = new{T}(min(x, y), max(x, y))
end

GreyNumber(x::T, y::T) where {T<:Real} = GreyNumber{T}(x,y)

GreyNumber()::GreyNumber{Float64} = GreyNumber(0.0, 0.0)

GreyNumber(x::T) where {T <: Real} = GreyNumber{T}(x, x)

GreyNumber{T}(x::GreyNumber{T}) where {T <: Real} = GreyNumber{T}(x.a, x.b)

GreyNumber{T}(x::Bool)  where {T <: Real}= GreyNumber(Float64(x), Float64(x))


Base.transpose(x::GreyNumber{T}) where {T <: Real} = x

Base.adjoint(x::GreyNumber{Float64}) where {T <: Real} = x

Base.copy(x::GreyNumber{T}) where {T <: Real} = GreyNumber{T}(x.a, x.b)

Base.length(g::GreyNumber) = 1


function whitenizate(g::GreyNumber; t::Float64 = 0.5)::Float64
    @assert 0.0 <= t <= 1.0
    return g.a * t + g.b * (1.0 - t)
end

function Base.:+(g1::GreyNumber, g2::GreyNumber)::GreyNumber
    return GreyNumber(g1.a + g2.a, g1.b + g2.b)
end

function Base.:+(g::GreyNumber{T}, k::T)::GreyNumber{T} where T <: Real
    return GreyNumber(g.a + k, g.b + k)
end

function Base.:+(k::T, g::GreyNumber{T})::GreyNumber{T} where T <: Real
    return g + k
end


function Base.:-(g::GreyNumber)::GreyNumber
    minusone = -1 * one(g.a)
    return GreyNumber(minusone * g.b, minusone * g.a)
end

function Base.:-(g1::GreyNumber, g2::GreyNumber)::GreyNumber 
    return GreyNumber(g1.a - g2.b, g1.b - g2.a)
end

function Base.:-(g::GreyNumber{T}, k::T)::GreyNumber{T} where T <: Real
    return g - GreyNumber(k, k)
end

function Base.:-(k::T, g::GreyNumber{T})::GreyNumber{T} where T <: Real
    return GreyNumber(k, k) - g
end


function Base.:*(g1::GreyNumber, g2::GreyNumber)::GreyNumber
    return GreyNumber(
        min(g1.a * g2.a, g1.a * g2.b, g1.b * g2.a, g1.b * g2.b),
        max(g1.a * g2.a, g1.a * g2.b, g1.b * g2.a, g1.b * g2.b),
    )
end

function Base.:*(k::T where {T <: Number}, g1::GreyNumber)::GreyNumber
    a = g1.a * k
    b = g1.b * k
    return GreyNumber(min(a, b), max(a,b))
end

function Base.:*(g1::GreyNumber, k::T where {T <: Number})::GreyNumber
    return k * g1
end

function Base.inv(g::GreyNumber)::GreyNumber
    newa = min(inv(g.a), inv(g.b))
    newb = max(inv(g.a), inv(g.b))
    return GreyNumber(newa, newb)
end


function Base.:/(g1::GreyNumber, g2::GreyNumber)::GreyNumber
    #@assert g2.a != 0
    #@assert g2.b != 0
    #@assert g2.a * g2.b > 0
    return GreyNumber(
        min(g1.a / g2.a, g1.a / g2.b, g1.b / g2.a, g1.b / g2.b), 
        max(g1.a / g2.a, g1.a / g2.b, g1.b / g2.a, g1.b / g2.b)
    )
end

function Base.:/(k::T where {T <: Real}, g1::GreyNumber)::GreyNumber
    return g1 / GreyNumber(k, k)
end

function Base.:/(g1::GreyNumber, k::T where {T <: Real})::GreyNumber
    return g1 / GreyNumber(k, k)
end

function Base.:^(g::GreyNumber, k::T where {T <: Real})::GreyNumber
    @assert k > 0
    @assert g.a <= g.b
    anew = g.a^k
    bnew = g.b^k
    return GreyNumber(min(anew, bnew), max(anew, bnew))
end

function Base.isless(g1::GreyNumber, g2::GreyNumber)::Bool
    if g1.a < g2.a 
        return true
    elseif g1.a == g2.a 
        return g1.b < g2.b
    else
        return false
    end
end

function Base.:≤(g1::GreyNumber, g2::GreyNumber)::Bool
    if g1.a <= g2.a 
        return true
    elseif g1.a == g2.a 
        return g1.b <= g2.b
    else
        return false
    end
end

function Base.isgreater(g1::GreyNumber, g2::GreyNumber)::Bool
    if g1.a > g2.a 
        return true
    elseif g1.a == g2.a 
        return g1.b > g2.b
    else
        return false
    end 
end

function Base.:≥(g1::GreyNumber, g2::GreyNumber)::Bool
    if g1.a >= g2.a 
        return true
    elseif g1.a == g2.a 
        return g1.b >= g2.b
    else
        return false
    end 
end

function Base.isequal(g1::GreyNumber, g2::GreyNumber)::Bool
    return (g1.a == g2.a) && (g1.b == g2.b) 
end

function Base.isreal(g::GreyNumber)::Bool
    return isreal(g.a)
end

function Base.isinteger(g::GreyNumber)::Bool
    return isinteger(g.a)
end

function Base.isinf(g::GreyNumber)::Bool 
    return isinf(g.a) || isinf(g.b)
end

function Base.iszero(g::GreyNumber)::Bool
    return iszero(g.a) && iszero(g.b)
end

function Base.isone(g::GreyNumber)::Bool
    return isone(g.a) && isone(g.b)
end

function Base.iseven(g::GreyNumber)::Bool
    @assert eltype(g.a) <: Int
    return iseven(g.a) && iseven(g.b)
end

function Base.isodd(g::GreyNumber)::Bool
    @assert eltype(g.a) <: Int
    return isodd(g.a) && isodd(g.b)
end
                               

function Base.sum(g::GreyNumber{T})::T where {T <: Number}
    return g.a + g.b
end

function Base.eltype(g::GreyNumber)::Type
    return eltype(g.a)
end

function Base.iterate(g::GreyNumber, state=1)
    if state == 1
        (g.a, state + 1)
    elseif  state == 2
        (g.b, state + 1)
    else
        nothing 
    end
end 

function Base.sqrt(g::GreyNumber)::GreyNumber
    return g^0.5
end

function Base.cbrt(g::GreyNumber)::GreyNumber
    return GreyNumber(cbrt(g.a), cbrt(g.b))
end


function Base.abs(g::GreyNumber)::GreyNumber
    return GreyNumber(abs(g.a), abs(g.b))
end

function Base.getindex(g::GreyNumber{T}, index::Int64)::T where T
    @assert index == 1 || index == 2
    if index == 1
        g.a
    else
        g.b
    end
end

function Base.last(g::GreyNumber{T})::T where T
    return g.b
end




end # end of module GreyNumbers
