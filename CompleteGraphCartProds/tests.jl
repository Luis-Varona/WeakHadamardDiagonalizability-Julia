using JLD, JLD2, FileIO
using FreqTables

include("main.jl")
include("../GeneralFunctions/EigvecsZeroOneNeg.jl")

Cart_K2 = KroneckerSum(CompleteGraph(2)[2], CompleteGraph(2)[2])
Cart_K3 = KroneckerSum(CompleteGraph(3)[2], CompleteGraph(3)[2])
Cart_K4 = KroneckerSum(CompleteGraph(4)[2], CompleteGraph(4)[2])

### Load K_2 and K_3 info
decomp_info2 = FileIO.load("../WHD-Julia-LargeFiles/results.jld2", "decomp_info2")
decomp_info3 = FileIO.load("../WHD-Julia-LargeFiles/results.jld2", "decomp_info3")

### Load K_4 info
vecs_0 = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_0")
vecs_n = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_n")
vecs_2n = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_2n")

bases_0 = load("../WHD-Julia-LargeFiles/K4-tests/K4-bases_0.jld", "bases_0")
bases_n = load("../WHD-Julia-LargeFiles/K4-tests/K4-bases_n.jld", "bases_n")

### Tests for K_2
# orthoRanks_K2 = freqtable( # Order 4: min = 3, max = 6
#     [data.OrthoRank for data in decomp_info2.get_decomps()]
# )
eigvecs_K2 = [data.Eigvecs for data in decomp_info2.get_decomps]

### Tests for K_3
# orthoRanks_K3 = freqtable( # Order 9: min = 28, max = 36
#     [data.OrthoRank for data in decomp_info3.get_decomps()]
# )
idxs3 = rand(1:189, 6)
eigvecs_K3 = [data.Eigvecs for data in decomp_info3.get_decomps[idxs3]]

### Tests for K_4
idxs4 = rand(1:306196, 6)
somevecs_K4 = bases_n[2][idxs4]

###
testvecs_K3 = EigvecsZeroOneNeg(Cart_K3, 3)