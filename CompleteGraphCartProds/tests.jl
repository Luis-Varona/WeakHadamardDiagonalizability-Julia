using FileIO, JLD2
#include("BFS_WHDiagonalizability/struct-WHDecomp_Set.jl")
include("BFS_WHDiagonalizability/getall_WHDecomps.jl")

### Load K_2 and K_3 info
decomp_info2 = FileIO.load("../WHD-Julia-LargeFiles/results.jld2", "decomp_info2")
decomp_info3 = FileIO.load("../WHD-Julia-LargeFiles/results.jld2", "decomp_info3")

### Load K_4 info
vecs_0 = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_0")
vecs_n = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_n")
vecs_2n = load("../WHD-Julia-LargeFiles/K4-tests/K4_vecs.jld", "vecs_2n")

bases_0 = load("../WHD-Julia-LargeFiles/K4-tests/K4-bases_0.jld", "bases_0")
bases_n = load("../WHD-Julia-LargeFiles/K4-tests/K4-bases_n.jld", "bases_n")

### Tests
using FreqTables
idxs = rand(1:189, 4)

tests = [data.Eigvecs for data in decomp_info3.get_decomps()[idxs]]
tests2 = [data.OrthoRank for data in decomp_info3.get_decomps()]
tests2_freq = freqtable(tests2)