# MI-03: frozen mathematical and numerical targets

Mathematical argument: Matthew J. Colbrook, University of Cambridge. Original
question and previously known upper bound: Jean-Christophe Bourin and Eun-Young
Lee. Formalization: Sidney Holden, Center for Computational Biology, Flatiron
Institute, Simons Foundation, with OpenAI Codex assistance.

## Source and complete scope

The canonical README and complete `solution.tex` at repository base
`9777c86853b40206f70438c92a47a7dec9bc66ae` are the source of truth. The source
argument also appears in
`references/colbrook-matrix-2026-09-11/original-proofs/MI-03.tex`.
Original problem: for every odd integer k≥3, the least nonnegative universal
additive constant for k complex matrix contractions is k/4. We prove the
stronger source value for every integer k≥2. The source's optional Hermitian
3×3 extremizers are not needed or advertised.

## Exact statement boundary

- Every dimension n≥1, all complex n×n matrices, including singular,
  non-Hermitian and zero summands.
- Norm: Euclidean operator norm through Mathlib's scoped
  `Matrix.Norms.L2Operator` instance. Never the default entry norm.
- Modulus: `CFC.abs A = CFC.sqrt (Aᴴ * A)`, the positive square root.
- Order: `MatrixOrder`; X≤Y means `(Y-X).PosSemidef`.
- Real c is admissible iff c≥0 and the order inequality holds for every such
  dimension and every k-tuple with each norm≤1. No hidden commuting assumption.
- `bestConstant k` is the real sInf of that actual set; prove its nonemptiness
  and lower boundedness alongside equality to k/4, avoiding empty-set defaults.
- Export upper_bound, sharpness, sharp_constant and odd_sharp_constant in
  independent Challenge/Solution environments. No replaceable definition holes.

## Computation minimized before proof

Set R=|ΣA_j| and T=Σ|A_j|. The upper bound follows from the exact positive
identity (or equivalent vector Cauchy–Schwarz argument)

k(T+kI/4-R) = kΣ(|A_j|-|A_j|²)
             + Σ_{i<j}(A_i-A_j)ᴴ(A_i-A_j) + (R-kI/2)².

Every term is positive semidefinite for contractions. No approximate spectrum,
interval arithmetic, variable subdivision or finite dimension test replaces
the universal inequality.

For lower bound, let ω=exp(2πi/k), v_j=(1/2,√3 ω^j/2), A_j=e₁v_jᴴ for j<k.
The exact constants and identities to establish are:

1. |ω|=1 and Σ_{j<k}ω^j=0 for k≥2.
2. ‖v_j‖₂=1; A_j is a contraction; |A_j|=v_jv_jᴴ.
3. Σ A_j=diag(k/2,0) and Σ|A_j|=diag(k/4,3k/4).
4. |ΣA_j|-Σ|A_j|=diag(k/4,-3k/4), exactly `sharpGap k`.
5. The (0,0) quadratic form forces every admissible c≥k/4.
6. The actual nonempty bounded-below infimum is k/4; specialize to odd k≥3.

Equivalent exact phase families with the same norm and zero sum, and algebraic
positive decompositions are permissible implementation choices. Any change to
the formal boundary or advertised scope reopens independent statement review.
LeanCert kernel-trust audits are mandatory; this purely algebraic proof needs
no artificial interval calculation. All exports must have axiom closure within
propext, Classical.choice, Quot.sound and pass actual isolated Linux Comparator
and default-kernel replay before promotion.

## Examples studied and review sequence

MI-29 supplies actual matrix modulus/order/CFC examples, exact dependency pins,
metadata and separate statement/proof layout. IE-23 supplies genuine-supremum scope
review patterns. The shared harness derives from the pinned
Forsythe project credited in tools/lean/NOTICE.md. No mathematical result from
those projects is assumed. Two independent Tau Ceti-style statement approvals
are required on these bytes before proof implementation, then two independent
final code/fidelity/attribution reviews and operational evidence audit.
