using Combinatorics, LinearAlgebra
include("../GeneralFunctions/EigvecsZeroOneNeg.jl")
include("isQuasiOrthogonalizable.jl")

"""
    hasWHEigbasis(L::Matrix{Int64}, λ::Int64, μ::Int64)

Determine whether a given eigenspace has a quasi-orthogonal {-1,0,1}-basis.

Returns: a boolean 'hasBasis' and a matrix 'basis' if such an eigenbasis exists.

# Arguments
- `L::Matrix{Int64}`: an integer Laplacian matrix with integral spectra.
- `λ::Int64`: the eigenvalue of 'L' corresponding to the eigenspace.
- `μ::Int64`: the multiplicity of `λ`.
"""
function hasWHEigbasis(L::Matrix{Int64}, λ::Int64, μ::Int64)
    eigvecs, numEigvecs = EigvecsZeroOneNeg(L, λ)

    if numEigvecs < μ
        hasBasis = false
        basis = missing
    elseif μ <= 2
        hasBasis = true
        basis = eigvecs[:, 1:μ]
    else
        function DFS(μ::Int64, idxsComb::Vector{Int64}, eigvecs::Matrix{Int64}, numEigvecs::Int64)
            eigbasis = eigvecs[:, idxsComb]
            depth = length(idxsComb)
            isQuasi, orderQuasi = isQuasiOrthogonalizable(eigbasis)

            if isQuasi == false || rank(eigbasis, 1e-5) != depth
                quasi = false
                idxsFinal = missing
                return quasi, idxsFinal
            elseif depth == μ
                quasi = true
                idxsFinal = idxsComb[orderQuasi]
                return quasi, idxsFinal
            else
                quasi = false
                idxsFinal = idxsComb
            end
            
            last = idxsComb[depth]
            
            for idxNext in (last + 1):numEigvecs
                idxsCombNext = vcat(idxsComb, idxNext)
                quasi, idxsFinal = DFS(μ, idxsCombNext, eigvecs, numEigvecs)
                if quasi
                    return quasi, idxsFinal
                end
            end

            return quasi, idxsFinal
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