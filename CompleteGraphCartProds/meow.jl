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
V2 = EigvecsZeroOneNeg(Cart_K2, 2)[1]
V3 = EigvecsZeroOneNeg(Cart_K3, 3)[1]
V4 = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_n")[1]

###
function numIntinCol(vec, int::Int64)
    return sum(vec .== int)
end