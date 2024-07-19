using LinearAlgebra, FreqTables

"""
    EigvalsbyMultiplicity(L::Matrix{Int64})

Sort by ascending multiplicity the eigenvalues of a spectrum-integral Laplacian matrix.

Returns: the diagonal matrix 'D' of eigenvalues and the vectors 'Λ' and 'M' of unique
eigenvalues and their corresponding multiplicities.
"""
function EigvalsbyMultiplicity(L::Matrix{Int64})
    F = sort( # Convert eigenvalues to 'int' and sort by ascending multiplicity
        freqtable(convert.(Int64, round.(eigvals(L))))
    )
    Λ = names(F)[1] # Vector of sorted unique eigenvalues
    M = [μ for μ in F] # Vrray of corresponding multiplicities
    d = reduce(vcat, [repeat([λ], μ) for (λ, μ) in zip(Λ, M)]) # Vector of sorted eigenvalues with repetition
    return d, Λ, M
end