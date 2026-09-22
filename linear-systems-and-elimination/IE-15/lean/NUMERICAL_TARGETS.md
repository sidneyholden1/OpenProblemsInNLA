# IE-15 numerical and mathematical targets — statement preparation

Source: complete canonical solution.md, George Stepaniants, Theorem 1 and
Sections 1–5. The full original target concerns real nonsingular matrices of
orders 3 AND 4. Every admissible rook choice and tie is included. A rook pivot
need only be maximal in its own active row and column, not globally maximal.
The definitions perform actual row AND column swaps and Schur updates, then
measure every intermediate active entry relative to the original maximum.

1. Check the exact source rational witnesses A3 and A4, determinants 3 and
   70/9, both genuine diagonal rook paths, initial entry maxima 1, and actual
   growth factors 3 and 14/3. Candidate states are recursively actual Schur
   steps, so admissibility still requires independent row/column inequalities.
2. Every real nonsingular A3 and every admissible path has growth at most 3.
3. Every real nonsingular A4 and every admissible path has growth at most 14/3.
4. The actual sets over all nonsingular matrices and all paths are nonempty
   and bounded above, with suprema exactly 3 and 14/3. No empty or unbounded
   real-supremum convention may discharge the final theorem.

Planned proof reductions: reuse IE-05 actual entry maximum and padded-path
structure, extended to column swaps and rook inequalities. Prove normalization
and eventual row/column permutation invariance; no normalized-LDR hypothesis
may replace the arbitrary input/path boundary. Derive positive pivot signs and
nonnegative last-row multipliers by actual sign changes. Include the possibly
singular order-three submatrix extension with two nonzero admissible pivots.
The scalar two-pivot inequality h(c,d)=3cd+1+|c-d| has the full source domain
0<p≤1, q>0, |a|,|b|≤1, 0≤c1,c2≤1, |d1|,|d2|≤1, and three actual entry bounds.
Use its exact sign case split and separate convexity endpoint reduction;
prove every reduction from real input entries. All earlier Schur entries must
also be bounded (1,2,4), and strict 4<14/3 can use kernel LeanCert.

No interval search or floating-point evidence replaces the analytic upper
bounds. LeanCert trust:=kernel and all-export axiom audits are required; use
exact rational certificates for witnesses. Study existing IE-05 proof structure
and Mathlib inequalities before implementing new helpers. Only the standard
three axioms are permitted; Comparator selects all four results with no
replaceable definitions. Two independent statement referees must approve the
boundary before proof implementation; two final reviews and actual isolated
Linux Comparator/default-kernel/rejection controls remain required.
