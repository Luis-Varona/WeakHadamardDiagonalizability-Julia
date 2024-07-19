using LinearAlgebra, Kronecker
include("BFS_WHDiagonalizability/getall_WHDecomps.jl")

###
function CompleteGraph(n::Int64)
    A = ones(Int64, n, n) - I(n)
    L = n*I(n) - ones(Int64, n, n)
    return A, L
end

function KroneckerSum(A::Matrix{Int64}, B::Matrix{Int64})
    return kronecker(A, I(size(B, 1))) + kronecker(I(size(A, 1)), B)
end

###
Cart_K2 = KroneckerSum(CompleteGraph(2)[2], CompleteGraph(2)[2])
Cart_K3 = KroneckerSum(CompleteGraph(3)[2], CompleteGraph(3)[2])
Cart_K4 = KroneckerSum(CompleteGraph(4)[2], CompleteGraph(4)[2])

###
# decomp_info2 = getall_WHDecomps(Cart_K2)
# decomp_info3 = getall_WHDecomps(Cart_K3)
# decomp_info4 = getall_WHDecomps(Cart_K4)

###
using FileIO, JLD2
# FileIO.save(
#     "../WHD-Julia-LargeFiles/results.jld2",
#     "BasicInfo", BasicInfo, "WHDecomp_Set", WHDecomp_Set,
#     "decomp_info2", decomp_info2, "decomp_info3", decomp_info3
# )

decomp_info2 = FileIO.load("../WHD-Julia-LargeFiles/results.jld2", "decomp_info2")
decomp_info3 = FileIO.load("../WHD-Julia-LargeFiles/results.jld2", "decomp_info3")

###
using JLD
# vecs_0 = EigvecsZeroOneNeg(Cart_K4, 0)
# vecs_n = EigvecsZeroOneNeg(Cart_K4, 4)
# vecs_2n = EigvecsZeroOneNeg(Cart_K4, 8)

# save("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_0", vecs_0, "vecs_n", vecs_n, "vecs_2n", vecs_2n)

vecs_0 = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_0")
vecs_n = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_n")
vecs_2n = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_2n")

###
# bases_0 = getall_WHEigbases(Cart_K4, 0, 1)
# save("../WHD-Julia-LargeFiles/K4-tests/K4-bases_0.jld", "bases_0", bases_0)

# bases_n = getall_WHEigbases(Cart_K4, 4, 6)
# save("../WHD-Julia-LargeFiles/K4-tests/K4-bases_n.jld", "bases_n", bases_n)

bases_0 = load("../WHD-Julia-LargeFiles/K4-tests/K4-bases_0.jld", "bases_0")
bases_n = load("../WHD-Julia-LargeFiles/K4-tests/K4-bases_n.jld", "bases_n")

#bases_2n = getall_WHEigbases(Cart_K4, 8, 6)
#save("../WHD-Julia-LargeFiles/K4-tests/K4-bases_2n.jld", "bases_2n", bases_2n)