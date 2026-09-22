# SP-05 mathematical contracts before proofs

Full source: canonical README and complete Matthew J. Colbrook solution.md,
Theorem SP-05 and Sections 1–3, at this project's preserved base83a1a140.
No finite-dimensional sample or numerical inequality replaces the all-dimensional
result. All matrices are real; every n≥2 and every positive-definite pair A,B
are included. Mathlib PosDef includes Hermitian symmetry (ordinary real
symmetry). No commutativity, eigenvalue simplicity or rank restriction is added.

1. Actual column vectorization has index pair (column,row), and actual
   commutation matrix entries swap that pair. Prove the transpose action and
   the full Kronecker/Jordan multiplication identity.
2. Derive a nonzero real PSD eigenmatrix for the global smallest eigenvalue
   of A⊗B+B⊗A. Positivity of that eigenvalue, exact eigenvector equality,
   its Rayleigh value and a lower bound against EVERY nonzero vector are
   explicit conclusions. PSD-preserving invertibility and a minimizing
   eigenmatrix are not assumed in the input or a custom predicate.
3. Prove the actual symmetric and skew-symmetric sector Rayleigh sets are
   nonempty and bounded below, and that both real infima are attained by
   nonzero vectors satisfying the actual commutation eigenspace equations.
   n≥2 ensures the skew sector is nontrivial. The denominator is the genuine
   Euclidean squared norm ∑v_i²; nonzero vectors exclude division by zero.
4. Prove the full original inequality between those two attained infima.
   The original n² vector space is indexed by Fin n×Fin n, ordered as
   column then row, rather than relabelled Fin(n*n). This is only finite-index
   bookkeeping, not a smaller vector subspace or a changed Kronecker product.

Proof plan, still obligations: reuse pinned Mathlib PosDef/Kronecker spectral
and Rayleigh APIs. Derive that the inverse Jordan operator preserves the PSD
cone; do not posit this. The source's integral representation may be replaced
by an exact spectral argument: C>0, Z Hermitian, CZ+ZC≥0 imply Z≥0 by evaluating
on any negative-eigenvalue eigenvector. Prove the congruence and inverse bridges,
then the positive-cone variational argument and real PSD minimizing eigenmatrix.
Finally prove the factor-two Rayleigh identity on BOTH commutation sectors and
connect global minimization to the genuine attained sector minima.

LeanCert will audit actual transitive kernel trust. No artificial interval
computation is necessary for this exact arbitrary-dimensional theorem.
Study Mathlib Analysis/Matrix/PosDef, Order, Spectrum, InnerProductSpace/Rayleigh,
and the existing MI-03 CFC/PSD examples; retain all reuse and mathematical credit.
Two independent statement approvals and a successful Challenge build precede
proof implementation. Two nonauthor final reviews and actual isolated Linux
Comparator/default-kernel checks are required before any canonical promotion.
