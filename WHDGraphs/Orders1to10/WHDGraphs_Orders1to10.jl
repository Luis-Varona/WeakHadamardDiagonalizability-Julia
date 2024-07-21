### Load and process integral Laplacian graphs (later change to OneNeg only)
using PythonCall
np = pyimport("numpy")

# Assumes you are working in the root directory of the entire Git repository
LapIntGraphs_1to10 = pyconvert(
    Vector{Array{Matrix}},
    np.load(
        "WHDGraphs/Orders1to10/LapIntGraphs_1to10.npy", allow_pickle = true
    )
)

for k in eachindex(LapIntGraphs_1to10)
    LapIntGraphs_1to10[k] = [pyconvert.(Int64, LaplacianBundle)
    for LaplacianBundle in LapIntGraphs_1to10[k]]
end

### Test integral graphs for WHD and WD
include("../GraphStructs.jl")
using .GraphStructs
include("../../WeakHadamardDiagonalizability/isWHDiagonalizable.jl")
include("../../WeighingDiagonalizability/isWeighingDiagonalizable.jl")

function Laplacian2Adjacency(L::Matrix{Int64})
    A = Diagonal(L) - L
    return A
end

###
WHDGraphs_1to10 = [Vector{WHDGraph}() for order in 1:10]

function push_WHD(
    order::Int64,
    L::Matrix{Int64}, band_ZeroOneNeg::Int64,
    eigvals::Vector{Int64}, eigvecs::Matrix{Int64}
)
    graph = WHDGraph(L, band_ZeroOneNeg, Eigen(eigvals, eigvecs))
    push!(WHDGraphs_1to10[order], graph)
end

for (order, LaplacianBundle) in enumerate(LapIntGraphs_1to10)
    for L in LaplacianBundle
        WHD, V, d = isWHDiagonalizable(L)
        if WHD
            if order in (1, 2, 4, 8) # Orders with WD graphs (Johnston & Plosker 2023)
                WD, V2, d2 = isWeighingDiagonalizable(L)
                if WD
                    push_WHD(order, L, 1, d2, V2)
                    continue
                end
            end
            push_WHD(order, L, 2, d, V)
        end
    end
    
    println(order)
end

###
using JLD2
save(
    "WHDGraphs/Orders1to10/WHDGraphs_1to10.jld2",
    "GraphStructs", GraphStructs,
    "WHDGraphs_1to10", WHDGraphs_1to10
)

# ###
# using JLD

# WHDGraphs_1to10 = load("WHDGraphs/Orders1to10/WHDGraphs_1to10.jld", "WHDGraphs_1to10")
# save("WHDGraphs/Orders1to10/WHDGraphs_1to10.jld", "WHDGraphs_1to10", WHDGraphs_1to10)

# ###
# using NPZ

# WHDAdjacencies_1to10 = [
#     [[graph.adjacency, graph.BW_ZeroOneNeg] for graph in WHDGraphs_1to10[n]]
#     for n in 1:10
# ]
# py_WHDAdjacencies_1to10 = np.array(WHDAdjacencies_1to10)
# np.save("WHDGraphs/Orders1to10/WHDAdjacencies_1to10.npy", py_WHDAdjacencies_1to10)