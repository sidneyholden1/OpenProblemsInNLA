# IE-17 independent final proof referee 1

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent; not a proof implementer.
- Date: 2026-09-14.
- Phase: full mathematical correctness, original-target fidelity, actual norms/infima/projector, computation and trust review.
- Protocol: `docs/lean/REVIEW.md` and its Tau Ceti adaptation; not official Tau Ceti service review or human peer review.
- Verdict: **APPROVE the identified proof bytes**. No substantive correction requested. Linux Comparator and operational promotion remain pending.

## Exact reviewed identity

I read all 495 lines across Certificates, Proof, Approximation and Solution. I independently compared Definitions, Challenge and NUMERICAL_TARGETS against frozen Git revision `0986a847`; all are unchanged. The full original-source hashes and pre-proof fidelity review remain in `statement-referee-1.md`.

| Project file | SHA-256 |
|---|---|
| `NLA/IE17/Definitions.lean` | `eda180881ac84c75c75735bc4e8525bdf326862bed550890efe6381a14f4c90b` |
| `Challenge.lean` | `8c5aa2240fa18627857e190591374dd50066f2962aed5fab0c6591b3eec1537a` |
| `NUMERICAL_TARGETS.md` | `767f706cbf630848334c82a5de73798ad0a6f5a11d16af4e3ac95e8c07dca516` |
| `NLA/IE17/Certificates.lean` | `a5788f6a4bcdba325f3f35e7ef379f66aeef05f85b72a77d5a42532d2a0cc49d` |
| `NLA/IE17/Proof.lean` | `324546012fd97f17309ef200ef9507a7f8f05567f692ff0f23f86cb7d3ffbc48` |
| `NLA/IE17/Approximation.lean` | `fc00a9edd478153d9369f1546572a12f830a8621fce2ca421bf2b3fb89ed4b82` |
| `Solution.lean` | `84551059f5a2eb78a918de92c6be4eef0a261e7f6854c4423210646ff3ed4d0a` |
| `comparator.json` | `4be90034e97c30a2f3de0fb10e7cf2dc78eff13a3f9b2724e6419890b90ed72a` |

These match the supplied proof-source manifest; approval comes from reading the code and independent checks, not from trusting the manifest alone. README and formalization.yaml were also read for truthful scope, source attribution and pending-gate disclosure; later status-wrapper changes do not alter this mathematical approval.

## Exact iterates and attained true minima

The norm helpers use the actual `WithLp 2` Euclidean norm and the explicitly scoped rectangular L2 operator norm. In particular, `vnorm_mulVec` calls Mathlib's actual matrix operator-norm bound. No default function norm or Frobenius norm enters the proof.

`krylov_one` and `krylov_two` characterize the complete real spans through Mathlib's finite spanning-family API. The two residual-gap identities hold for every vector in their respective Krylov spaces and express the objective's squared difference as three nonnegative coordinate squares. They prove global residual minimality. Equality forces all three coordinates equal to the displayed iterate, so the minimum-length tie convention follows from actual uniqueness, not merely a chosen representative. Full column rank, both nonzero iterates, both nonzero normal residuals, and the precise residual vectors are explicitly proved. Consequently the two comparisons precede termination and have the exact canonical initial-guess/Krylov interpretation.

`backward_attained` proves existence for arbitrary finite real matrix dimensions. The feasible set contains `-A` and is closed because the normal-equation map is continuous. I inspected Mathlib's `IsClosed.exists_infDist_eq_dist`: it requires a proper metric space, constructs a compact closed-ball intersection, and attains the distance there. The finite-dimensional real normed-matrix space supplies this properness through the standard finite-dimensional instance. I also inspected `Metric.isGLB_infDist`, which explicitly uses nonempty/bounded-below distance values. The proof identifies the distance-from-zero image with the exact set of feasible spectral norms and transports its greatest lower bound to the original real `sInf`. Thus both displayed backward errors are genuine attained minima. No optimizer, unproved existence assertion, or empty-infimum default is used.

## Spectral upper certificate and every-perturbation lower bound

The upper perturbation's entries agree with the rational data reviewed independently before implementation. `upper_feasible` verifies the actual perturbed normal equation with fixed right-hand side. `upper_ldl` proves the full matrix identity `κI-EᵀE = L diag(D)Lᵀ`, and each diagonal factor is proved nonnegative. Congruence gives positive semidefiniteness. Crucially, `upper_norm_sq` then applies the PSD quadratic form to every Euclidean vector and uses `ContinuousLinearMap.opNorm_le_bound` through `Matrix.l2_opNorm_def`; it proves the actual rectangular operator norm bound. I inspected that operator-norm API and its nonnegative-bound/all-vector hypotheses. The LDL identity is not merely advertised as a spectral certificate.

For the lower certificate, `lower_quadratic_nonneg` proves an exact weighted sum-of-squares identity for the source integer matrix, with all positive rational coefficients. `lower_form` connects it, for every real four-vector, to the actual `A`, `x2`, residual and threshold `99/100`; its denominator is the exact positive source constant. The shorter weighted identity replaces the source's large principal-minor computations without weakening the required uniform inequality.

`lower_feasible_sq` quantifies over every real feasible perturbation `E`. Its `v` is exactly the new residual `b-(A+E)x2`; feasibility implies `(A+E)ᵀv=0`. If `v=0`, it uses `Ex2=r2` and the true operator bound with the exact residual-to-iterate ratio. If `v≠0`, it proves positivity of `||v||²`, derives `vᵀb=||v||²`, and obtains the required D-form identity before division. The two operator bounds control `Aᵀv=-Eᵀv` and `Ex2`; transpose norm equality is the actual Euclidean operator result. The weighted C/D lower form and positivity of both `||x2||²` and `||v||²` yield `99/100 ≤ ||E||²`. No possible new residual is omitted, and no normalization by zero occurs.

The final backward-error theorem uses the attained minimizer at `x2` to transfer this all-feasible-E bound to the actual error. At `x1`, the genuine infimum is bounded by the feasible upper certificate. Nonnegative square-root arguments then establish the advertised weak endpoints and a strict increase from the strict rational gap `1979/2000 < 99/100`. It does not silently upgrade a pointwise strict bound to a strict infimum bound.

## Actual projector and second independent negative answer

`scaledStack` is the real seven-row block matrix `[A;tI]`. `stack_gram` proves its exact diagonal Gram matrix, with entries `1+t²`, `36+t²`, `25+t²`, which are nonzero for every real `t`. `stack_pseudo` identifies the actual inverse in the reviewed Moore–Penrose formula using a verified right inverse. All four Moore–Penrose identities are proved in `stack_penrose`, including symmetry of both products. They are specialized to the actual stacked matrices at both iterates.

`projector_norm_sq` computes the norm of the actual product `K K† [r;0]`, expanding all sum-indexed coordinates, not just the top residual block. The rational formula follows from the diagonal Gram inverse and exact nonzero denominators. `approximate_formula` substitutes the actual norm ratio for `t`, explicitly excludes a zero iterate and termination, and only then derives the three rational terms. The two published large fractions are proved from that formula and the exact residuals. No rational scalar expression is defined to stand in for the original approximation.

The two `interval_decide (trust := kernel)` calls prove the exact rational cuts at `503/500` and `1007/1000`. Nonnegativity of both actual approximation errors justifies passing from their ordered squares to the strict error increase. Finally, Solution specializes each universal monotonicity assertion separately to the same two exact iterates and derives a contradiction from its corresponding strict increase. It proves a conjunction of two separate negative answers, not merely failure of their combined assertion.

## Independent elaboration, trust and proof quality

I independently re-elaborated Certificates, Proof, Approximation and Solution with the pinned Lean 4.33.1 runtime. All returned exit zero. Approximation emitted two deprecation warnings from the LeanCert point tactic at lines 104 and 107 concerning `Set.mem_setOf`; the other files emitted no diagnostics. These warnings do not indicate unresolved goals or altered trust. The transcript is preserved in `verification/referee-1-local-checks.log`.

A separate audit importing Solution printed the transitive axiom closures of all four public exports and `backward_attained`. Each was exactly `[propext, Classical.choice, Quot.sound]`; the independently obtained output is in `verification/referee-1-axioms.log`. There was no sorry, custom axiom or native-compiler dependency, and no dependence on the isolated Challenge placeholders. LeanCert's kernel audits agree with these independent closures. The point-tactic invocations were independently re-elaborated; the final rational inequalities remain kernel-trusted rather than relying on a floating computation.

The implementation reuses Mathlib's proper-space attainment, Krylov-span representation, norm/order, Moore–Penrose inverse identification and operator-norm APIs. Exact LDL and weighted sums of squares replace expensive determinant/eigenvalue computations. The seven-row projector reduces algebraically to three scalar terms; no interval subdivision, sampled optimizer or rounded recurrence is used. Definitions and public claims remain the approved original ones, while useful general attainment/norm lemmas are appropriately explicit. Source and project metadata credit Colbrook, Fong and Saunders, Sidney Holden, OpenAI Codex assistance, Mathlib and LeanCert; the README preserves the source's AI/priority qualifications and makes the operational pending state explicit. No external human review or new priority claim is implied.

## Remaining limits

This is final mathematical/local-kernel approval on the listed bytes. Actual isolated Linux Comparator, kernel replay/rejection controls and a corresponding operational evidence audit have not been completed or inspected for this project at review time. Source-level signature fidelity and local compilation do not replace those gates. Canonical publication/status changes are outside this report. The theorem is confined to the retained real, undamped, fixed-right-hand-side, spectral-norm model; no Frobenius-error or perturbed-right-hand-side conclusion is inferred. Standard classical foundational axioms remain in the trusted base, and this review is independent AI review rather than external human certification.
