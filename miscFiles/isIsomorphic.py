import numpy as np
from sage.all import Graph, graphs

def isIsomorphic(adj_matrix1: np.matrix, adj_matrix2: np.matrix):
    n = adj_matrix1.shape[0]
    adj_SageMat1 = next(graphs.nauty_geng(str(n))).adjacency_matrix()
    adj_SageMat2 = next(graphs.nauty_geng(str(n))).adjacency_matrix()

    for i in range(n):
        for j in range(n):
            adj_SageMat1[i, j] = adj_matrix1[i, j]
            adj_SageMat2[i, j] = adj_matrix2[i, j]
    
    isIso = Graph(adj_SageMat1).is_isomorphic(Graph(adj_SageMat2))
    return isIso