include("../miscFiles/isQuasiOrthogonal.jl")
include("../WeakHadamardDiagonalizability/isQuasiOrthogonalizable.jl")

###
V = cat(
    ones(11),
    [0,1,-1,0,0,0,0,0,0,0,0],
    [1,-1,1,-1,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,1,-1],
    [0,0,0,0,0,0,0,0,1,-1,0],
    [0,0,0,0,0,0,0,1,-1,-1,1],
    [0,0,0,0,0,0,1,-1,0,0,0],
    [0,0,0,0,0,1,-1,-1,-1,1,1],
    [0,0,0,0,1,-1,0,0,0,0,0],
    [1,-1,-1,1,0,0,0,0,0,0,0],
    [1,1,1,1,0,0,0,-1,-1,-1,-1],
    dims = 2
);

###
V_quasi, V_order = isQuasiOrthogonalizable(V)
println(V_quasi)
println(V_order, "\n")

###
Q = V[:, V_order]
Q_quasi = isQuasiOrthogonal(Q)
println(Q_quasi, "\n")