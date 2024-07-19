include("../../GeneralFunctions/EigvalsbyMultiplicity.jl")
include("getall_WHEigbases.jl")
include("struct-WHDecomp_Set.jl")

# struct WeakHadamardDecomps
#     Eigvals::Vector{Int64}
#     fullDecomps::Vector{Matrix{Int64}}
#     perEigspace::Vector{Vector{Matrix{Int64}}}
# end

function getall_WHDecomps(L::Matrix{Int64})
    #WHD = true # Intialize the returned boolean to 'true'
    numDecomps = 1 # Initialize the number of decompositions to 1
    d, Λ, M = EigvalsbyMultiplicity(L) # Sort the eigenvalues of 'L' by multiplicity
    eigspace_iter = 1:length(Λ) # [Annotate later]
    #Eigbases = Vector{Vector{Matrix{Int64}}}(undef, length(Λ))
    Eigbases = [Vector{Matrix{Int64}}() for i in eigspace_iter] ## [Annotate later]
    #iter_sets = Vector{UnitRange{Int64}}(undef, length(Λ)) # [Annotate later]

    for (i, λ, μ) in zip(eigspace_iter, Λ, M)
        numBases, bases = getall_WHEigbases(L, λ, μ) # get all possible WHD bases for each eigenspace
        numDecomps *= numBases # Update the total number of decompositions

        if numBases == 0 # If any eigenspace is not WHD, terminate and return 'false'
            decomp_info = missing
            break
        end

        Eigbases[i] = bases # [Annotate later]
        #iter_sets[i] = 1:numBases # [Annotate later]
    end

    if numDecomps > 0
        decomp_info = WHDecomp_Set(BasicInfo(numDecomps, Eigbases, d))
    end

    return decomp_info # numDecomps

    # idxsDecomps = Iterators.product(iter_sets...) # [Annotate later]
    # numDecomps = length(idxsDecomps)
    # EigvecsOpts = [Matrix{Int64}(undef, size(L)) for i in 1:numDecomps] # [Annotate later]
    
    # for (decomp, idxsDecomp) in enumerate(idxsDecomps) # [Annotate later]
    #     EigvecsOpts[decomp] = reduce(hcat, [Eigbases[i][idxsDecomp[i]] for i in eigspace_iter])
    # end
    
    # decomps = WeakHadamardDecomps(d, EigvecsOpts, Eigbases) # [Annotate later]
    # return WHD, numDecomps, decomps # Return the boolean and the computed diagonalization of 'L'
end