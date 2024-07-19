using Combinatorics, LinearAlgebra
include("../GeneralFunctions/EigvecsZeroOneNeg.jl")
include("isPairwiseOrthogonal.jl")

function hasWeighingEigbasis(L::Matrix{Int64}, λ::Int64, μ::Int64)
    eigvecs, numEigvecs = EigvecsZeroOneNeg(L, λ)

    if numEigvecs < μ
        hasBasis = false
        basis = missing
    elseif μ == 1
        hasBasis = true
        basis = eigvecs[:, 1]
    else
        function DFS(μ::Int64, idxsComb::Vector{Int64}, eigvecs::Matrix{Int64}, numEigvecs::Int64)
            eigbasis = eigvecs[:, idxsComb]
            depth = length(idxsComb)

            if isPairwiseOrthogonal(eigbasis) == false || rank(eigbasis, 1e-5) != depth
                ortho = false
                idxsFinal = missing
                return ortho, idxsFinal
            elseif depth == μ
                ortho = true
                idxsFinal = idxsComb
                return ortho, idxsFinal
            else
                ortho = false
                idxsFinal = idxsComb
            end
            
            last = idxsComb[depth]
            
            for idxNext in (last + 1):numEigvecs
                idxsCombNext = vcat(idxsComb, idxNext)
                ortho, idxsFinal = DFS(μ, idxsCombNext, eigvecs, numEigvecs)
                if ortho
                    return ortho, idxsFinal
                end
            end

            return ortho, idxsFinal
        end

        idxsStartOpts = combinations(1:numEigvecs, 2)
        
        for idxsComb in idxsStartOpts
            hasBasis, idxsBasis = DFS(μ, idxsComb, eigvecs, numEigvecs)
            if hasBasis
                basis = eigvecs[:, idxsBasis]
                break
            end
        end

        if hasBasis == false
            basis = missing
        end
    end

    return hasBasis, basis
end