struct GreyNumber{T<:Real}
    a::T
    b::T
end

GreyNumber()::GreyNumber{Float64} = GreyNumber(0.0, 0.0)

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

function Base.:*(g1::GreyNumber, k::T where {T <: Real})::GreyNumber
    return GreyNumber(g1.a * k, g1.b * k)
end

function Base.:*(k::T where {T <: Real}, g1::GreyNumber)::GreyNumber
    return GreyNumber(g1.a * k, g1.b * k)
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

function Base.:^(g::GreyNumber, k::T where {T <: Real})::GreyNumber
    @assert k > 0
    @assert g.a <= g.b
    return GreyNumber(g.a^k, g.b^k)
end