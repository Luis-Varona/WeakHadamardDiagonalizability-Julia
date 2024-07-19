using LinearAlgebra

# Second most efficient (t = ~3.5 units)
function isPairwiseOrthogonal1(X::Matrix{Int64})
    n = size(X, 2)
    for col1 in 1:(n - 1)
        for col2 in (col1 + 1):n
            dotproduct = X[:, col1]' * X[:, col2]
            if isapprox(dotproduct, 0) == false
                return false
            end
        end
    end
    return true
end

# Most efficient (t = ~1 unit)
function isPairwiseOrthogonal2(X::Matrix{Int64})
    for (idx, col1) in enumerate(eachcol(X))
        for col2 in eachcol(X)[(idx + 1):end]
            dotproduct = col1' * col2
            if isapprox(dotproduct, 0) == false
                return false
            end
        end
    end
    return true
end

# Least efficient (t = ~ 7.2 units)
function isPairwiseOrthogonal3(X::Matrix{Int64})
    G = X' * X
    if all(isapprox.(G - diagm(diag(G)), 0))
        return true
    else
        return false
    end
end