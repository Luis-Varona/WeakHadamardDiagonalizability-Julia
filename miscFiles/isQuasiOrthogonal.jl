function isQuasiOrthogonal(X::Matrix)
    #Need to account for adjoint/transpose before typing as matrix
    n = size(X, 2)

    for j in 1:(n - 2)
        for k in (j + 2):n
            dotProduct = X[:, j]' * X[:, k]
            if isapprox(dotProduct, 0) == false
                isQuasi = false
                return isQuasi
            end
        end
    end

    isQuasi = true
    return isQuasi
end

#isQuasiOrthogonal([1 -1; 1 5; 1 1.01]')
#true: isQuasiOrthogonal([1 1 1; -1 5 1])
#false: isQuasiOrthogonal([1 1 1; -1 5 1.01])
#false: isQuasiOrthogonal([1 1 1; -1 5 1.00001])
#false: isQuasiOrthogonal([1 1 1; -1 5 1.00000000001])
#true: isQuasiOrthogonal([1 1 1; -1 5 1.000000000000000000001])