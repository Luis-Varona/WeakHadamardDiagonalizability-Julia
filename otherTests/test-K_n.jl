include("../WeakHadamardDiagonalizability/isWHDiagonalizable.jl")
using Kronecker

###
function kGraph(n::Int64)
    A = ones(Int64, n, n) - I(n)
    L = n*I(n) - ones(Int64, n, n)
    return A, L
end

function KroneckerSum(A::Array, B::Array)
    return kronecker(A, I(size(B, 1))) + kronecker(I(size(A, 1)), B)
end

###
L2 = KroneckerSum(kGraph(2)[2], kGraph(2)[2])
L3 = KroneckerSum(kGraph(3)[2], kGraph(3)[2])
L4 = KroneckerSum(kGraph(4)[2], kGraph(4)[2])
L5 = KroneckerSum(kGraph(5)[2], kGraph(5)[2])

WHD_2, V_2, D_2 = isWHDiagonalizable(L2)
WHD_3, V_3, D_3 = isWHDiagonalizable(L3)
#WHD_4, V_4, D_4 = isWHDiagonalizable(L4)
#WHD_5, V_5, D_5 = isWHDiagonalizable(L5)
