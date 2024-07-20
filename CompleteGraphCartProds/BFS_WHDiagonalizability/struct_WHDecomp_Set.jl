include("isQuasiwithRank.jl")
include("../../WeighingDiagonalizability/isPairwiseOrthogonal.jl")

struct BasicInfo
    numBases::Int64
    eigbases::Vector{Vector{Matrix{Int64}}}
    eigvals::Vector{Int64}
end

struct WHDecomp_Set{T}
    struct WHDecomp
        Eigvecs::Matrix{Int64}
        OrthoRank::Int64
        IsWeighing::Bool
        IsOneNeg::Bool
        IsHadamard::Bool
    end
    
    main_info::BasicInfo
    get_decomps::T

    function WHDecomp_Set(main_info)
        Eigbases = main_info.eigbases
        m = size(Eigbases[1], 1)
        comb_iter = Iterators.product([1:length(opts) for opts in Eigbases]...)
        numCombs = length(comb_iter)
        decomps = [Matrix{Int64}(undef, m, m) for i in 1:numCombs]

        for (idx, idxsDecomp) in enumerate(comb_iter)
            decomps[idx] = reduce(
                hcat, [basis[idxsDecomp[i]] for (i, basis) in enumerate(Eigbases)]
            )
        end

        function decomp_attrs(decomp::Matrix{Int64})
            orthoRank = isQuasiwithRank(decomp)[3]
            isWeighing = isPairwiseOrthogonal(decomp)
            isOneNeg = any.(decomp .== 0) == false
            isHadamard = isWeighing && isOneNeg
            return WHDecomp(decomp, orthoRank, isWeighing, isOneNeg, isHadamard)
        end

        # foo() = [decomp_attrs(decomp) for decomp in decomps]
        foo = [decomp_attrs(decomp) for decomp in decomps]
        new{typeof(foo)}(main_info, foo)
    end
end