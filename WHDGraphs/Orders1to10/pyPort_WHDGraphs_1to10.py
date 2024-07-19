###
import numpy as np
import numpy.typing as npt

class Eigendecomp:
    def __init__(self, eigvecs: npt.NDArray[np.int64], eigvals: npt.NDArray[np.int64]):
        self.V = eigvecs
        self.d = eigvals

class WHDGraph:
    def __init__(
            self, order: int, graph6_string: str,
            adjacency: npt.NDArray[np.int64], laplacian: npt.NDArray[np.int64],
            is_regular: bool, is_bipartite: bool,
            bandwidth_ZeroOneNeg: int#, bandwidth_OneNeg: int,
            #diagonalization: Eigendecomp
        ):
        self.order = order
        self.graph6 = graph6_string
        self.adjacency = adjacency
        self.laplacian = laplacian
        self.is_regular = is_regular
        self.is_bipartite = is_bipartite
        self.BW_ZeroOneNeg = bandwidth_ZeroOneNeg
        #self.BW_OneNeg = bandwidth_OneNeg
        #self.diagonalization = diagonalization

###
from sage.all import graphs, Graph
def npMat_to_SageGraph(npMat: npt.NDArray[np.int64]):
    n = npMat.shape[0]
    SageMat = next(graphs.nauty_geng(str(n))).adjacency_matrix()

    for i in range(n):
        for j in range(n):
            SageMat[i, j] = npMat[i, j]
    
    return Graph(SageMat)

# Load graphs from .jld (or .npy) files
# WHDAdjacencies_1to10 = np.load(
#     'WHDGraphs/Orders1to10/WHDAdjacencies_1to10.npy', allow_pickle = True
# )
WHDAdjacencies_1to10 = np.load(
    'WHDAdjacencies_1to10.npy', allow_pickle = True
)
numsWHD = (1, 1, 3, 4, 5, 6, 7, 26, 13, 40)
#WHDGraphs_1to10 = np.array(
#    [[np.zeros((n, n), int) for k in range(numsWHD[n])] for n in range(10)],
#    object
#)
WHDGraphs_1to10 = np.empty((10,), object)

for (order, jul_bundle) in enumerate(WHDAdjacencies_1to10): ###
    order += 1
    start_bundle = [[npMat_to_SageGraph(obj[0]), obj[1]] for obj in jul_bundle]

    py_bundle = np.array([
        WHDGraph(
            order,
            start_bundle[k][0].graph6_string(),
            start_bundle[k][0].adjacency_matrix().numpy(),
            start_bundle[k][0].laplacian_matrix().numpy(),
            start_bundle[k][0].is_regular(),
            start_bundle[k][0].is_bipartite(),
            start_bundle[k][1]
        )
        for k in range(len(start_bundle))
    ])

    WHDGraphs_1to10[order - 1] = py_bundle

WHDGraphs_1to10