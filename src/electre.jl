module Electre

import GreyDecision.GreyNumbers: GreyNumber
import GreyDecision.Utility:
    unitize, normalize, weightize, apply_columns, reverseminmax, rowmaxs


function electre(
    decisionMat::Array{GreyNumber{T},2},
    weights::Array{Float64,1},
    fns::Array{Function,1},
) where {T<:Real}

    w = unitize(weights)

    nalternatives, ncriteria = size(decisionMat)

    normalizedMat = normalize(decisionMat)
    weightednormalizedMat = weightize(normalizedMat, w)

    fitnessTable = []
    nonfitnessTable = []

    for i = 1:nalternatives
        for j = 1:nalternatives
            if i != j
                betterlist = []
                worselist = []
                for h = 1:ncriteria
                    if fns[h] == maximum
                        if weightednormalizedMat[i, h] >= weightednormalizedMat[j, h]
                            push!(betterlist, h)
                        else
                            push!(worselist, h)
                        end
                    else
                        if weightednormalizedMat[i, h] <= weightednormalizedMat[j, h]
                            push!(betterlist, h)
                        else
                            push!(worselist, h)
                        end
                    end
                end
                fitnesstableelement = Dict(:i => i, :j => j, :set => betterlist)
                push!(fitnessTable, fitnesstableelement)

                nonfitnesstableelement = Dict(:i => i, :j => j, :set => worselist)
                push!(nonfitnessTable, nonfitnesstableelement)
            end
        end
    end

    fitnessmatrix = Array{GreyNumber{Float64}, 2}(undef, nalternatives, nalternatives)
    nonfitnessmatrix = Array{GreyNumber{Float64}, 2}(undef, nalternatives, nalternatives)

    for elements in fitnessTable
        i = elements[:i]
        j = elements[:j]
        elemlist = elements[:set]

        CC = sum(w[elemlist])
        fitnessmatrix[i, j] = GreyNumber(CC, CC)
    end

    nonfitnessmatrix = Array{GreyNumber{Float64}, 2}(undef, nalternatives, nalternatives)
    for elements in nonfitnessTable
        i = elements[:i]
        j = elements[:j]
        elemlist = elements[:set]

        r_ik = weightednormalizedMat[i, elemlist]
        r_jk = weightednormalizedMat[j, elemlist]
        r_ik_full = weightednormalizedMat[i, :]
        r_jk_full = weightednormalizedMat[j, :]

        nom = maximum(abs.(r_ik - r_jk))
        dom = maximum(abs.(r_ik_full - r_jk_full))
        nonfitnessmatrix[i, j] = nom / dom
    end

    C = Array{GreyNumber{Float64}, 1}(undef, nalternatives)
    D = Array{GreyNumber{Float64}, 1}(undef, nalternatives)
    for i = 1:nalternatives
        C[i] = sum(fitnessmatrix[i, :]) - sum(fitnessmatrix[:, i])
        D[i] = sum(nonfitnessmatrix[i, :]) - sum(nonfitnessmatrix[:, i])
    end

    best_C_index = sortperm(C) |> last
    best_D_index = sortperm(D) |> first
    best = nothing

    if best_C_index == best_D_index
        best = (best_C_index,)
    else
        best = (best_C_index, best_D_index)
    end

    result = Dict(
        :C => C,
        :D => D,
        :bestindex => best
    )

    return result
end
end # end of module Electre