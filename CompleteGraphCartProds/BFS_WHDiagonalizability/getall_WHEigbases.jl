using Combinatorics, LinearAlgebra
include("../../GeneralFunctions/EigvecsZeroOneNeg.jl")
include("../../WeakHadamardDiagonalizability/isQuasiOrthogonalizable.jl")
include("../../WeighingDiagonalizability/isPairwiseOrthogonal.jl")

function getall_WHEigbases(L::Matrix{Int64}, λ::Int64, μ::Int64)
    eigvecs, numEigvecs = EigvecsZeroOneNeg(L, λ)

    if numEigvecs < μ
        #hasBasis = false
        numBases = 0
        bases = missing
        return numBases, bases
    end

    if μ <= 2
        idxsBases = combinations(1:numEigvecs, μ)
        numBases = length(idxsBases)
    else
        idxsStartOpts = combinations(1:numEigvecs, 2)
        depth = 3

        while depth < μ
            idxsNewOpts = Vector{Vector{Int64}}()
            numNew = 0
            
            for idxsStart in idxsStartOpts
                last = idxsStart[depth - 1]
                for idxNext = (last + 1):numEigvecs
                    idxsComb = vcat(idxsStart, idxNext)
                    eigbasis = eigvecs[:, idxsComb]
                    if isQuasiOrthogonalizable(eigbasis)[1] && rank(eigbasis, 1e-5) == depth
                        push!(idxsNewOpts, idxsComb)
                        numNew += 1
                    end
                end
            end

            idxsStartOpts = idxsNewOpts
            depth += 1
        end

        idxsBases = Vector{Vector{Int64}}()
        numBases = 0

        for idxsStart in idxsStartOpts
            last = idxsStart[μ - 1]
            for idxNext = (last + 1):numEigvecs
                idxsComb = vcat(idxsStart, idxNext)
                eigbasis = eigvecs[:, idxsComb]
                isQuasi, orderQuasi = isQuasiOrthogonalizable(eigbasis)
                if isQuasi && rank(eigbasis, 1e-5) == μ
                    push!(idxsBases, idxsComb[orderQuasi])
                    numBases += 1
                end
            end
        end

        if numBases == 0
            #hasBasis = false
            bases = missing
        end
    end

    #hasBasis = true
    n = size(L, 1)
    bases = [Matrix{Int64}(undef, n, μ) for basis in 1:numBases]
    for (basis, idxsBasis) in enumerate(idxsBases)
        bases[basis] = eigvecs[:, idxsBasis]
    end

    return numBases, bases
end