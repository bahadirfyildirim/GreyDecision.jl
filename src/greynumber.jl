"""
Liu S., Yang Y., Forrest J. (2017) Grey Numbers and Their Operations. In: Grey Data Analysis. 
Computational Risk Management. Springer, Singapore. https://doi.org/10.1007/978-981-10-1841-1_3
"""
module GreyNumbers 

struct GreyNumber{T<:Real}
    a::T
    b::T
end

GreyNumber()::GreyNumber{Float64} = GreyNumber(0.0, 0.0)

Base.length(g::GreyNumber) = 2


function whitenizate(g::GreyNumber; t::Float64 = 0.5)::Float64
    @assert 0.0 <= t <= 1.0
    return g.a * t + g.b * (1.0 - t)
end

function Base.:+(g1::GreyNumber, g2::GreyNumber)::GreyNumber
    return GreyNumber(g1.a + g2.a, g1.b + g2.b)
end

function Base.:-(g::GreyNumber)::GreyNumber
    minusone = -1 * one(g.a)
    return GreyNumber(minusone * g.b, minusone * g.a)
end

function Base.:-(g1::GreyNumber, g2::GreyNumber)::GreyNumber 
    return GreyNumber(g1.a - g2.b, g1.b - g2.a)
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
    @assert g.a > 0
    @assert g.b > 0
    @assert g.a <= g.b
    return GreyNumber(inv(g.b), inv(g.a))
end


function Base.:/(g1::GreyNumber, g2::GreyNumber)::GreyNumber
    @assert g2.a != 0
    @assert g2.b != 0
    @assert g2.a * g2.b > 0
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
    @assert g1.a <= g1.b 
    @assert g2.a <= g2.b
    return g1.a < g2.a 
end

function Base.:≤(g1::GreyNumber, g2::GreyNumber)::Bool
    @assert g1.a <= g1.b 
    @assert g2.a <= g2.b
    return g1.a <= g2.a 
end

function Base.isgreater(g1::GreyNumber, g2::GreyNumber)::Bool
    @assert g1.a <= g1.b 
    @assert g2.a <= g2.b
    return g1.b > g2.b 
end

function Base.:≥(g1::GreyNumber, g2::GreyNumber)::Bool
    @assert g1.a <= g1.b 
    @assert g2.a <= g2.b
    return g1.b >= g2.b 
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

end # end of module GreyNumbers
