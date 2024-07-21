# WeaklyHadamardDiagonalizable-Julia
An algorithm to test simple, connected graphs for weak Hadamard diagonalizability.
Can test any graph of order <= 13 in minutes (and many higher-order graphs as well).

NOTE: Many functions require integer Laplacians with integral spectra as input, since this is a precondition for both {-1,0,1}- and {-1,1}-diagonalizability.