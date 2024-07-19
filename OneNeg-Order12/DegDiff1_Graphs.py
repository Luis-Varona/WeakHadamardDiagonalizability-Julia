import numpy as np
from sage.all import graphs

def isLaplacianIntegral(graph):
    L = graph.kirchhoff_matrix().numpy()
    eigvals = np.linalg.eigvals(L)
    if np.allclose(eigvals, np.round(eigvals)):
        return True, L
    else:
        return False, None

def main():
    LapIntGraphs = np.empty((3,), object)
    isIrregular = lambda g: not g.is_regular()
    
    for i in range(3):
        gen = graphs.nauty_geng(f"12 -c -l -d{10 - i} -D{11 - i}")
        LaplacianBundle = []
        
        for g in gen:
            if isIrregular(g):
                isInt, L = isLaplacianIntegral(g)
                if isInt:
                    LaplacianBundle.append(L)
        
        LapIntGraphs[i] = np.array(LaplacianBundle)
    
    np.save("OneNeg-Order12/LapIntGraphs.npy", LapIntGraphs)

main()