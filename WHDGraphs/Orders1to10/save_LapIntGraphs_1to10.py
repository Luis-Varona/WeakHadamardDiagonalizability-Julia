###
import numpy as np
from sage.all import graphs

###
# If not in the root directory of the Git repo, change relative paths accordingly
import sys
sys.path.append("WHDGraphs")
from GraphGenerators import generateGraphs_Con

###
def main():
    LapIntGraphs_1to10 = np.empty((10,), object)

    for order in range(1, 11):
        GraphGenerator = generateGraphs_Con(order)
        LaplacianBundle = []
        for g in GraphGenerator:
            L = g.kirchhoff_matrix().numpy()
            eigvals = np.linalg.eigvals(L)
            if np.allclose(eigvals, np.round(eigvals)):
                LaplacianBundle.append(L)
        
        LapIntGraphs_1to10[order - 1] = np.array(LaplacianBundle, object)
    
    # If not in the root directory of the Git repo, change relative paths accordingly
    np.save("WHDGraphs/Orders1to10/LapIntGraphs_1to10.npy", LapIntGraphs_1to10)

main()