# IE-17: mathematical and numerical boundary before proof

Mathematical counterexample: Matthew J. Colbrook, University of Cambridge.
Original questions: David Chin-Lung Fong and Michael A. Saunders. Formalization:
Sidney Holden, Center for Computational Biology, Flatiron Institute, Simons
Foundation, with OpenAI Codex assistance.

## Exact source and scope

Canonical `linear-systems-and-elimination/IE-17/README.md` and complete source
`references/colbrook-recovered-2026-09-11/manuscripts/IE-17.tex` at base
`9777c86853b40206f70438c92a47a7dec9bc66ae`. Both counted-together monotonicity
questions must be refuted separately. A statement only about normal residual
monotonicity, or only one of the two errors, is not the advertised target.
All matrices/vectors are real, arithmetic is exact, damping absent, and x0=0.
Perturb only A, keep b fixed, and use actual Euclidean operator norms of E.
Do not infer a Frobenius-perturbation result from this counterexample.

## Definitions requiring independent approval

The formal Krylov subspace is the real span of (AᵀA)^j Aᵀb for 0≤j<k.
`isLSMRIterate` encodes normal-residual minimization and the minimum Euclidean
length choice among ties, exactly the canonical equivalent characterization.
The universal claims compare successive nonzero iterates and require that the
first has nonzero normal residual, so it precedes exact termination.

`backwardError` is the real infimum of spectral norms of all E satisfying
(A+E)ᵀ((A+E)x-b)=0. The witness theorem explicitly proves attainment for x1
and x2, not an empty-set convention or an approximate optimization substitute.
Feasible sets are nonempty (E=-A) and norm values nonnegative.

The approximation uses the actual stacked K=[A;ηI], η=||r||₂/||x||₂ and
v=[r;0], and norm(K K†v)/||x||₂. A full-column-rank formula for K† is used;
the exported certificate verifies all four Moore–Penrose identities at both
witnesses. At exact normal-residual termination approxError is explicitly zero.
All tested x and r are nonzero. Vector norms use WithLp 2; rectangular matrix
norms use Matrix.Norms.L2Operator; these must not fall back to function norms.

## Exact iterate and residual targets

A has rows (1,0,0), (0,6,0), (0,0,5), (0,0,0); b=(11,1,1,1).
H=AᵀA=diag(1,36,25), g=Aᵀb=(11,6,5).

x1=(11231,6126,5105)/31201=(1021/31201)g.
x2=(87659,7599,16865)/55219=(16321g-383Hg)/110438.

Prove both exact variational iterates including minimum-length convention,
full column rank of A, x1,x2≠0, and both normal residuals nonzero. The residuals
are r1=(331980,-5555,5676,31201)/31201 and
r2=(519750,9625,-29106,55219)/55219. Exact Gram/orthogonality certificates avoid
simulating rounded Golub–Kahan recurrences.

## Optimal spectral backward error

The full exported targets are

μ(x1) ≤ sqrt(1979/2000) < sqrt(99/100) ≤ μ(x2),

and attainment of both infima. Nonstrict lower endpoint is sufficient; unlike
the source's stronger strict lower certificate, no attainment argument may be
silently used to turn pointwise strict inequalities into a strict infimum bound.

For x1 use the source's fully rational feasible perturbation. Its 12 exact
entries and positive diagonal LDL certificate of (1979/2000)I-EᵀE are retained
in `verification/numerical-precheck.json`. The full formula, with s=x1ᵀx1,
z=Ax1, r=b-z, w=(250,-1,1,27), ω=wᵀw and h=wᵀz, is

c0=r-w(wᵀr)/ω, a0=-Aᵀw+(h/s)x1,
E=-wwᵀA/ω+c0 x1ᵀ/s+h c0 a0ᵀ/(ω s (1979/2000)-h²).

Directly prove feasibility and the actual spectral-norm bound; no external
spectral-completion theorem is assumed.

For x2 put C=AAᵀ and D=(||r2||₂² I-r2r2ᵀ+(Ax2)(Ax2)ᵀ)/(x2ᵀx2).
The source exact identity is (5/6)C+(1/6)D-(99/100)I=K/2407881992100,
where K has rows

(206417059721,-50293465200,1125984433750,-1435003762500),
(-50293465200,83658415217471,206242965000,-26574143750),
(1125984433750,206242965000,61800032332121,80360210700),
(-1435003762500,-26574143750,80360210700,11170189945871).

Before proof implementation, exact rational investigation found the small
positive weights (2000,2,37,258). Weighted strict diagonal-dominance slacks
Kii wi-Σj≠i|Kij|wj are respectively
841137737850, 52242781242442, 13486908497877, 8875004951318.
This permits a short exact sum-of-squares proof of positivity, avoiding four
large principal-minor determinant computations.

For every feasible E, handle both zero and nonzero new residual v=b-(A+E)x2.
If v≠0, normal equations give Aᵀv=-Eᵀv and vᵀb=||v||₂². Operator bounds then
give vᵀCv≤||E||₂²||v||₂² and vᵀDv≤||E||₂²||v||₂². The PSD identity gives the
uniform lower bound on ||E||₂. If v=0, Ex2=r2 and the ordinary operator bound
and exact ||r2||₂²/||x2||₂² comparison give the same conclusion. No case is
omitted through normalization by zero. Then pass to the actual infimum.

## Original projected approximation

Prove all four Moore–Penrose identities for K at each iterate, and exact values

μtilde(x1)²=69694107852573439503892031925/69323394392991282508138323472,
μtilde(x2)²=5430772101137459612205263871781350/5387955615790281743396033884265233.

Their strict ordering can use the exact cuts 503/500 and 1007/1000. Reduce
square roots and the stacked projector to exact rational diagonal Gram solves;
never substitute a Frobenius norm or merely name the rational formula as the
projected approximation. Nonnegativity permits passage from squares to errors.

## Trust and review gates

LeanCert kernel trust only. Use exact algebra and point inequalities; avoid
numerical search, approximate eigenvalues or interval subdivisions. The
precheck script uses Fractions and is not a proof. Study existing MI-29/MI-03
CFC/norm/order and IE-23 exact vector/supremum examples; reuse their pinned
Mathlib/LeanCert toolchain, not their mathematical claims. Shared Comparator
workflow retains Forsythe provenance in tools/lean/NOTICE.md.

Two independent Tau Ceti-style statement approvals must precede proof bodies.
Then independently review all four exports and actual axiom closures. Empty
Comparator definition-hole list and only propext/Classical.choice/Quot.sound
are allowed. Actual isolated Linux Comparator and default-kernel replay plus
rejection controls are required before any canonical status promotion.
