include("../GeneralFunctions/EigvalsbyMultiplicity.jl")
include("hasWHEigbasis.jl")

"""
    isWHDiagonalizable(L::Matrix{Int64})

Check whether a given Laplacian matrix is weakly Hadamard diagonalizable.

Returns: a boolean 'WHDiagonalizable', a matrix 'V' of eigenvectors, and a vector
'd' of corresponding eigenvalues if such a diagonalization exists.
"""
function isWHDiagonalizable(L::Matrix{Int64})
    WHD = true # Intialize the returned boolean to 'true'
    d, Λ, M = EigvalsbyMultiplicity(L) # Sort the eigenvalues of 'L' by multiplicity
    V = Matrix{Int64}(undef, size(L, 1), 0) # Initialize an empty matrix of eigenvectors

    for (λ, μ) in zip(Λ, M)
        hasBasis, basis = hasWHEigbasis(L, λ, μ) # Test each eigenspace for WHD
        if hasBasis == false # If any eigenspace is not WHD, terminate and return 'false'
            WHD = false
            V = missing
            break
        else # Otherwise, append the computed basis to the matrix of eigenvectors
            V = hcat(V, basis)
        end
    end

    return WHD, V, d # Return the boolean and the computed diagonalization of 'L'
end