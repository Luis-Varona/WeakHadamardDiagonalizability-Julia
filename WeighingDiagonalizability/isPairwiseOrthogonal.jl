"""
    isPairwiseOrthogonal(X::Matrix{Int64})

Check whether the columns of a matrix form a pairwise orthogonal set.

Returns: a boolean indicating whether the matrix is pairwise orthogonal.
"""
function isPairwiseOrthogonal(X::Matrix{Int64})
    for (idx, col1) in enumerate(eachcol(X)) # Iteratively fix a base column in the matrix
        for col2 in eachcol(X)[(idx + 1):end] # Check it against each successive column
            dotproduct = col1' * col2 # Compute the dot product of the two columns
            if isapprox(dotproduct, 0) == false # Test for orthogonality (with tolerance)
                return false # If any pair is not orthogonal, return false
            end
        end
    end
    
    return true # If all pairs of columns are orthogonal, return true
end