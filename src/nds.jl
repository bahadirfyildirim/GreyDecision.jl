module NDS 

import ..GreyNumbers: GreyNumber

function dominates(p1::Array{GreyNumber{T}, 1}, p2::Array{GreyNumber{T}, 1})::Bool where {T <: Real}
    n = length(p1)
    notworse = count(i -> p1[i] < p2[i], 1:n)
    better   = count(i -> p1[i] > p2[i], 1:n)
    return (notworse == 0) && (better > 0)
end


function ndsranks(data::Array{GreyNumber{T}, 2})::Array{Int64} where {T <: Real}
    
    n, p = size(data)

    ranks = zeros(Int64, n)
    
    mat = convert(Matrix, data)
    
     for i in 1:n
        for j in 1:n
            if i != j 
                if dominates(mat[i,:], mat[j,:])
                    ranks[i] += 1
                end
            end
        end
    end

    return ranks
end


function nds(data::Array{GreyNumber{T}, 2})::Dict where {T <: Real}

    ranks = ndsranks(data)

    bestIndex = sortperm(ranks) |> last

    result = Dict(
        :ranks => ranks,
        :bestindex => bestIndex
    )

    return result
end

end # end of module NDS
