include("../GeneralFunctions/EigvalsbyMultiplicity.jl")
include("hasWeighingEigbasis.jl")

function isWeighingDiagonalizable(L::Matrix{Int64})
    WD = true # Intialize the returned boolean to 'true'
    d, Λ, M = EigvalsbyMultiplicity(L) # Sort the eigenvalues of 'L' by multiplicity
    V = Matrix{Int64}(undef, size(L, 1), 0) # Initialize an empty matrix of eigenvectors

    for (λ, μ) in zip(Λ, M)
        hasBasis, basis = hasWeighingEigbasis(L, λ, μ) # Test each eigenspace for WD
        if hasBasis == false # If any eigenspace is not WHD, terminate and return 'false'
            WD = false
            V = missing
            break
        else # Otherwise, append the computed basis to the matrix of eigenvectors
            V = hcat(V, basis)
        end
    end

    return WD, V, d # Return the boolean and the computed diagonalization of 'L'
end