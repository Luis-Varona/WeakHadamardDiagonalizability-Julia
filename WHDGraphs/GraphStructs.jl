module GraphStructs
    using LinearAlgebra
    using ExportAll
    
    struct WHDGraph
        laplacian_matrix::Matrix{Int64}
        band_ZeroOneNeg::Int64
        # band_OneNeg::Int64 # do later
        spectral_decomp::Eigen
    end
    
    function Base.getproperty(g::WHDGraph, prop::Symbol)
        attributes = (:laplacian_matrix, :band_ZeroOneNeg, :band_OneNeg, :spectral_decomp)
        if prop in attributes
            return getfield(g, prop)
        elseif prop == :adjacency_matrix
            L = g.laplacian_matrix
            return Diagonal(L) - L
        elseif prop == :order
            return size(g.laplacian_matrix, 1)
        elseif prop == :size
            return convert(Int64, sum(g.adjacency_matrix)/2)
        elseif prop == :density
            n = g.order
            return 2*g.size/(n*(n - 1))
        elseif prop == :average_degree
            l = diag(g.laplacian_matrix)
            return sum(l)/length(l)
        # elseif prop == :graph6_string
            # return adjacency_to_graph6(g.adjacency_matrix)
        end
    end
    
    ###
    # Porting from Python (not yet done):
        # https://stackoverflow.com/questions/44532492/how-does-graph6-format-work

    # function adjacency_to_graph6(A::Matrix{Int64})
    #     elements_from_row = 0
    #     bin_list = ""

    #     for row in eachrow(A)
    #         elements_from_row += 1
    #         if elements_from_row == 1
    #             continue
    #         end
    #         row_elements = pusheen
    # end
    
    @exportAll()
end