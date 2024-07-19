###
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

###
include("../GraphStructs.jl")
include("../../WeakHadamardDiagonalizability/isWHDiagonalizable.jl")
include("../../WeighingDiagonalizability/isWeighingDiagonalizable.jl")

function Laplacian2Adjacency(L::Matrix{Int64})
    A = Diagonal(L) - L
    return A
end

###
# WHDGraphs_1to10 = [Vector{WHDGraph}() for order in 1:10]

# for (order, LaplacianBundle) in enumerate(
#     vcat(LapIntGraphs_1to10[1:9], [LapIntGraphs_1to10[10][1:end - 1]]) # Excluding L(K_10)
# )
#     for (k, L) in enumerate(LaplacianBundle)
#         WHD, V, D = isWHDiagonalizable(L)
#         if WHD
#             A = Laplacian2Adjacency(L)
#             WD, V2, D2 = isWeighingDiagonalizable(L)
#             if WD
#                 decomp = Eigendecomp(V2, diag(D2))
#                 graph = WHDGraph(order, A, L, 1, decomp)
#             else
#                 decomp = Eigendecomp(V, diag(D))
#                 graph = WHDGraph(order, A, L, 2, decomp)
#             end
#             push!(WHDGraphs_1to10[order], graph)
#         end
#     end
# end

# # Johnston & Plosker 2024 proved K_10 is not weighing diagonalizable (test takes too long)
# L = LapIntGraphs_1to10[10][end]
# WHD, V, D = isWHDiagonalizable(L)
# A = Laplacian2Adjacency(L)
# decomp = Eigendecomp(V, diag(D))
# graph = WHDGraph(10, A, L, 2, decomp)
# push!(WHDGraphs_1to10[10], graph)

###
using JLD

WHDGraphs_1to10 = load("WHDGraphs/Orders1to10/WHDGraphs_1to10.jld", "WHDGraphs_1to10")
# save("WHDGraphs/Orders1to10/WHDGraphs_1to10.jld", "WHDGraphs_1to10", WHDGraphs_1to10)

###
using NPZ

WHDAdjacencies_1to10 = [
    [[graph.adjacency, graph.BW_ZeroOneNeg] for graph in WHDGraphs_1to10[n]]
    for n in 1:10
]
py_WHDAdjacencies_1to10 = np.array(WHDAdjacencies_1to10)
#np.save("WHDGraphs/Orders1to10/WHDAdjacencies_1to10.npy", py_WHDAdjacencies_1to10)