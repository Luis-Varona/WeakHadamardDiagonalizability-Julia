using FileIO, JLD2
include("BFS_WHDiagonalizability/struct-WHDecomp_Set.jl")

# ### Load structs
# BasicInfo = FileIO.load("CompleteGraphCartProds/results.jld2", "BasicInfo")
# WHDecomp_Set = FileIO.load("CompleteGraphCartProds/results.jld2", "WHDecomp_Set")

### Load K_2 and K_3 info
decomp_info2 = FileIO.load("CompleteGraphCartProds/results.jld2", "decomp_info2")
decomp_info3 = FileIO.load("CompleteGraphCartProds/results.jld2", "decomp_info3")

### Load K_4 info
vecs_0 = load("CompleteGraphCartProds/K4-tests/K4_vecs.jld", "vecs_0")
vecs_n = load("CompleteGraphCartProds/K4-tests/K4_vecs.jld", "vecs_n")
vecs_2n = load("CompleteGraphCartProds/K4-tests/K4_vecs.jld", "vecs_2n")

bases_0 = load("CompleteGraphCartProds/K4-tests/K4-bases_0.jld", "bases_0")
bases_n = load("CompleteGraphCartProds/K4-tests/K4-bases_n.jld", "bases_n")

### Tests
idxs = rand(1:189, 4)