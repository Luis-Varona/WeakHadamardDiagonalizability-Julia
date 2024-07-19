include("../GeneralFunctions/EigvalsbyMultiplicity.jl")
include("../GeneralFunctions/EigvecsOneNeg.jl")

function isOneNegDiagonalizable(L::Matrix{Int64})
    d, Λ, M = EigvalsbyMultiplicity(L)
    numSpaces = length(Λ)
    Eigbases = Vector{Matrix{Int64}}(undef, numSpaces)

    for (i, λ, μ) in zip(1:numSpaces, Λ, M)
        eigvecs, numEigvecs = EigvecsOneNeg(L, λ)
        if numEigvecs >= μ
            Eigbases[i] = eigvecs
        else
            return false, missing, d
        end
    end
    
    return true, Eigbases, d
end