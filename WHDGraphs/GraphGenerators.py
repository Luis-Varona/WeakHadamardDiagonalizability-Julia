import numpy as np
from itertools import chain
from sage.all import graphs

def generateGraphs_Con(order: int):
    GraphGenerator = graphs.nauty_geng(str(order) + " -c -l")
    return GraphGenerator

def generateGraphs_Con_Reg(order: int):
    def generateGraphs_Con_kReg(order: int, k: int):
        GraphGenerator = graphs.nauty_geng(
            str(order) + " -c -l -d" + str(k) + ' -D' + str(k)
        )
        return GraphGenerator
    
    # An odd-order graph is k-regular only if k is even
    k_values = range(2, order, (order % 2) + 1)
    GraphGenerator = chain.from_iterable(
        [generateGraphs_Con_Reg(order, k) for k in k_values]
    )
    return GraphGenerator

def Generate_Con_Bipart_Graphs(order: int):
    GraphGenerator = graphs.nauty_geng(str(order) + " -b -c -l")
    return GraphGenerator