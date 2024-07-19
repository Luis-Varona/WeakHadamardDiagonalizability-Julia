function EigvecsOneNeg(L::Matrix{Int64}, λ::Int64)
    n = size(L, 1)
    eigvecs = Matrix{Int64}(undef, n, 0)
    numEigvecs = 0

    for k in 1:n
        v1 = vcat(zeros(Int64, k - 1), 1)
        eigvecs_iter = Iterators.product(
            Iterators.repeated([-1, 1], n - k)...
        )
        for v2 in eigvecs_iter
            v = vcat(v1, [i for i in v2])
            if isapprox(L * v, λ * v) # Should I add tolerance even with Int64?
                eigvecs = hcat(v, eigvecs)
                numEigvecs += 1
            end
        end
    end

    return eigvecs, numEigvecs
end