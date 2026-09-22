# MI-08 mathematical boundary (pending statement reviews)

Source: complete canonical solution.tex, Theorem 1.1 and proof; original README
Problem statement. Fixed lists quantify over EVERY real square matrix X,
including nonsymmetric matrices. Orthogonality means actual UᵀU=I. The same list
is outside the universal X quantifier. Pinching is actual diagonal extraction.

1. For every positive d and q, fixed length-q pinching feasibility is equivalent
   to an integer q-by-d sign matrix with actual Gram matrix q I. Integer ±1
   represents precisely the source real signs; no restriction on U is assumed.
2. Every such design with q>0 has d≤q; if d≥3, then 4 divides q.
3. The explicit source order-twelve Paley matrix has sign entries and Gram 12 I;
   0<12 is the retained LeanCert kernel numerical obligation.
4. For EVERY 9≤d≤12, the actual feasible-length set is nonempty, has least
   element 12, and its natural infimum phi(d) equals 12. Empty-infimum conventions
   cannot discharge this statement.

Computation plan: apply the averaging identity to matrix units to force every
factor's off-diagonal entries to zero by sums of squares. Extract diagonal signs.
Reverse entry by entry. Use actual matrix rank for d≤q. Adapt Mathlib's integer
Hadamard divisibility proof to three columns: the sum of (1+ab)(1+ac) is q,
while every summand is divisible by four. Kernel-check one explicit 12-by-12
integer matrix and restrict columns. No candidate search or interval subdivision.
Use LeanCert with trust:=kernel and all-export trust audits. Study Mathlib's
LinearAlgebra/Matrix/HadamardMatrix.lean and MI-29/IS-02 project examples,
preserving source credit and licenses.

Scope: fixed feasibility in every positive dimension and row count, plus the
four exact dimensions only. The source adaptive comparison and optimum in other
dimensions are not claimed. No canonical target or problem ID changes. No proof
implementation before both independent Tau Ceti statement referees approve.
