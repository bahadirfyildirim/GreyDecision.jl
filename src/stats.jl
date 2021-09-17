module Stats

import ..GreyNumbers: GreyNumber

function I(n::Int)::Array{GreyNumber{Float64}, 2} 
    mat = zeros(GreyNumber, n, n)
    for i in 1:n
        mat[i, i] = GreyNumber{Float64}(1.0, 1.0)
    end
    return mat
end

function mean(x::Array{GreyNumber{T}, 1})::GreyNumber{T} where {T <: Real}
     return sum(x) / length(x)
end

function var(x::Array{GreyNumber{T}, 1})::GreyNumber{T} where {T <: Real} 
    m = mean(x)
    xm = map(a -> a - m, x)
    return sum((xm .* xm) / (length(x) - 1)) 
end 

function std(x::Array{GreyNumber{T}, 1})::GreyNumber{T} where {T <: Real} 
    return var(x) |> sqrt
end

function geomean(x::Array{GreyNumber{T}, 1})::GreyNumber{T} where {T <: Real} 
    return exp(sum(log.(x)) / length(x))
end 

function cor(x::Array{GreyNumber{T}, 1}, y::Array{GreyNumber{T}, 1})::GreyNumber{T} where {T <: Real}
    mx = mean(x)
    my = mean(y)
    xmd= map(a -> a - mx, x)
    ymd =map(a -> a - my, y)
    return (sum(xmd .* ymd) / sqrt(var(x) * var(y))) / (length(x) - 1.0)
end

function cor(x::Array{GreyNumber{T}, 1})::GreyNumber{T} where {T <: Real}
    _, p = size(x)
    cormat = ones(p, p)
    for i in 1:p
        for j in i:p
            if i != j 
                cr = cor(x[:,i], x[:,j])
                cormat[i, j] = cr
                cormat[j, i] = cr
            end
        end
    end
    return cormat
end

end # end of module Stats
