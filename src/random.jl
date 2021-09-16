module Random 

import GreyDecision.GreyNumbers: GreyNumber

function Base.rand(::Type{GreyNumber})::GreyNumber{Float64}
    return GreyNumber(rand(), rand())
end

function Base.rand(::Type{GreyNumber{T}})::GreyNumber{T} where {T <: Real}
    return GreyNumber(rand(T), rand(T))
end


function Base.rand(::Type{GreyNumber{T}}, n::Int)::Array{GreyNumber{T}, 1} where {T <: Real}
    return map(x -> rand(GreyNumber{T}), 1:n)
end


function Base.rand(::Type{GreyNumber}, n::Int)::Array{GreyNumber{Float64}, 1}
    return rand(GreyNumber{Float64}, n)
end


function Base.rand(::Type{GreyNumber{T}}, n::Int, m::Int)::Array{GreyNumber{T}, 2} where {T <: Real}
    mat = Array{GreyNumber{T}, 2}(undef, n, m)
    for i in 1:n
        for j in 1:m
            mat[i, j] = rand(GreyNumber{T})
        end
    end
    return mat
end


function Base.rand(::Type{GreyNumber}, n::Int, m::Int)::Array{GreyNumber{Float64}, 1} where {T <: Real}
    return rand(GreyNumber{Float64}, n, m)
end


end # End of module Random2