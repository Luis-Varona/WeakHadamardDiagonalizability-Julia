using PythonCall
np = pyimport("numpy")

# Assumes you are working in the root directory of the entire Git repository
LapIntGraphs = pyconvert(
    Vector{Array{Matrix}},
    np.load(
        "OneNeg-Order12/LapIntGraphs.npy", allow_pickle = true
    )
)

for k in eachindex(LapIntGraphs)
    LapIntGraphs[k] = [pyconvert.(Int64, LaplacianBundle)
    for LaplacianBundle in LapIntGraphs[k]]
end

###
include("isOneNegDiagonalizable.jl")

counterexample = missing
for LaplacianBundle in LapIntGraphs
    cont = true

    for L in LaplacianBundle
        OND, Eigbases, d = isOneNegDiagonalizable(L)
        if OND
            global counterexample = [OND, Eigbases, d, L]
            cont = false
            break
        end
    end

    if cont == false
        break
    end
end

###
LapIntGraphs_2 = pyconvert(
    Vector{Array{Matrix}},
    np.load(
        "OneNeg-Order12/LapIntGraphs_2.npy", allow_pickle = true
    )
)

for k in eachindex(LapIntGraphs_2)
    LapIntGraphs_2[k] = [pyconvert.(Int64, LaplacianBundle)
    for LaplacianBundle in LapIntGraphs_2[k]]
end

###
counterexample_2 = missing
for LaplacianBundle in LapIntGraphs_2
    cont = true

    for L in LaplacianBundle
        OND, Eigbases, d = isOneNegDiagonalizable(L)
        if OND
            global counterexample_2 = [OND, Eigbases, d, L]
            cont = false
            break
        end
    end

    if cont == false
        break
    end
end