function isQuasiwithRank(X::Matrix)
    n = size(X, 2)
    adj_list = [Vector{Int64}() for vertex in 1:n]
    orthoRank = n*(n - 1)/2

    # BEGIN: Construct the adjacency list of the orthogonality graph complement of X
    for col1 in 1:(n - 1)
        for col2 in (col1 + 1):n
            dotproduct = X[:, col1]' * X[:, col2]
            if isapprox(dotproduct, 0) == false
                if length(adj_list[col1]) == 2 || length(adj_list[col2]) == 2
                    isQuasi = false
                    orderQuasi = missing
                    orthoRank = missing
                    return isQuasi, orderQuasi, orthoRank
                end

                orthoRank -= 1
                push!(adj_list[col1], col2)
                push!(adj_list[col2], col1)
            end
        end
    end
    # END
    
    # BEGIN: Compute the vertex degrees of the orthogonality graph complement
    orderQuasi = zeros(Int64, n)
    idxOrder = 1
    vertex_degrees = [length(adj_list[vertex]) for vertex in 1:n]

    if sum(vertex_degrees .< 2) < 2
        isQuasi = false
        orderQuasi = missing
        orthoRank = missing
        return isQuasi, orderQuasi, orthoRank
    end

    for vertex in 1:n
        if vertex_degrees[vertex] == 0
            orderQuasi[idxOrder] = vertex
            #if vertex != n
            idxOrder += 1
            #end
        end
    end
    # END

    # BEGIN: Define 'travelPath' function
    function travelPath(vertex::Int64, visited::Vector{Bool}, adj_list::Vector{Vector{Int64}})
        visited[vertex] = true
        orderQuasi[idxOrder] = vertex
        idxOrder += 1
        vertex_ct = 1

        while vertex_ct <= n
            edge = 1
            while edge <= length(adj_list[vertex])
                neighbor = adj_list[vertex][edge]
                if visited[neighbor] == false
                    visited[neighbor] = true
                    vertex = neighbor
                    orderQuasi[idxOrder] = vertex
                    idxOrder += 1
                    break
                end
                edge += 1
            end
            vertex_ct += 1
        end
    end
    # END

    # BEGIN: Checks whether the orthogonality graph complement is a path subgraph
    visited = zeros(Bool, n)
    for vertex in 1:n
        if vertex_degrees[vertex] == 1 && visited[vertex] == false
            travelPath(vertex, visited, adj_list)
        end
    end

    if any(vertex_degrees[visited .== 0] .!= 0)
        isQuasi = false
        orderQuasi = missing
        orthoRank = missing
        return isQuasi, orderQuasi, orthoRank
    end
    # END

    # Returns output
    isQuasi = true
    return isQuasi, orderQuasi, orthoRank
end