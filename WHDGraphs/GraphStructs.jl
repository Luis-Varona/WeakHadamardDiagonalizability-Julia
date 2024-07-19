struct Eigendecomp
    V::Matrix{Int64}
    d::Vector{Int64}
end

struct WHDGraph
    order::Int64
    #graph6::String
    adjacency::Matrix{Int64}
    laplacian::Matrix{Int64}
    BW_ZeroOneNeg::Int64
    #BW_OneNeg::Int64 # do later
    diagonalization::Eigendecomp
end