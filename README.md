# isWHDiagonalizable-Julia
An algorithm to tests simple, connected graphs for weak Hadamard diagonalizability.
Can test any graph of order <= 13 in minutes (and many higher-order graphs as well).

NOTE: Many of these functions require entrywise integer matrices with integral spectra
as input, since this is a precondition for weak Hadamard diagonalizability.