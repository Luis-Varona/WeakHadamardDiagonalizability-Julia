include("../WeakHadamardDiagonalizability/isWHDiagonalizable.jl")

using LinearAlgebra
L25 = vcat(
    hcat([9 -1 -1 0; -1 9 0 -1; -1 0 9 -1; 0 -1 -1 9], -ones(Int64, 4, 7)),
    hcat(-ones(Int64, 7, 4), 11*I(7) - ones(Int64, 7, 7))
)

WHD_25, V_25, D_25 = isWHDiagonalizable(L25)