# IE-23 numerical targets and original-statement boundary

Source revision: 9777c86853b40206f70438c92a47a7dec9bc66ae.
Read the complete canonical ../README.md and the complete mathematical proof
../../../references/colbrook-recovered-2026-09-11/manuscripts/IE-23.tex.
Mathematical proof: Matthew J. Colbrook, University of Cambridge. The source
credits the smallest matrices to Dokmanić and Gribonval's spectral-norm example;
its extension to the direct-inverse objective is Colbrook's submitted argument.
Formalization: Sidney Holden with OpenAI Codex assistance.

## Exact full target

For every 1≤m<n, full-row-rank complex m×n matrix A, finite real p>2, and
complex n×m matrix X, the original implication is:
A X=I and X≠A† imply ||A†||_(p→2) < ||X||_(p→2).
A† is literally Aᴴ (A Aᴴ)⁻¹. Full row rank is expressed as surjectivity of the
actual linear map y↦Ay, equivalent in these finite dimensions to rank m.
The numerator in each norm ratio is sqrt(sum |(Xy)i|²); the denominator is
(sum |yi|^p)^(1/p). The supremum is over every nonzero complex y. We must prove
nonempty bounded ratio sets for both concrete matrices; no default value of
an ill-defined real supremum may supply a norm identity.

A single allowed exponent p=4 refutes this universally quantified implication.
The source's stronger all-p norm equalities and complete minimizer classification
are outside this formalization; the full original conjecture is still negated.
Neither endpoint p=2 or infinity is used. This is the direct-inverse norm,
not the different product objective ||XA||_(p→2).

## Rational matrices and norm certificate

A = [[1,1,0],[1,0,1]],
B = [[1/3,1/3],[2/3,-1/3],[-1/3,2/3]],
X = [[0,0],[1,0],[0,1]], all regarded as complex matrices.
Prove A B=A X=I, A†=B, and X≠B. The right inverse proves full row rank.

For arbitrary complex y=(u,v), X preserves the Euclidean norm, and
||By||₂² = ||y||₂² - |u+v|²/3 ≤ ||y||₂².
The elementary inequality (|u|²+|v|²)² ≤ 2(|u|⁴+|v|⁴) gives both ratio upper
bounds 2^(1/4) at p=4. At y=(1,-1) both bounds are attained, proving both
actual supremum values, not merely sampled lower bounds. All square roots and
real powers use Mathlib's actual operations on nonnegative real arguments.

## Computation minimization and declarations

Use exact finite matrix multiplication and real/imaginary-coordinate polynomial
identities. No interval subdivisions or searches are required. LeanCert is pinned;
use its kernel-only trust assertions on every exported proof and, if helpful,
a single exact rational point certificate. Algebraic proofs need no artificial
interval work. Freeze definitions and Challenge signatures with two independent
statement approvals and successful type-checking before writing proof bodies.

Exports: witness_algebra, norm_certificates, not_uniquenessConjecture.
Axiom allowance: propext, Classical.choice, Quot.sound only. Comparator compares
separate Challenge and Solution environments with no definition holes.
