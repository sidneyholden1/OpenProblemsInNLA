# IE-23 independent proof referee 1

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent, not the proof implementer.
- Date: 2026-09-14.
- Phase: final mathematical correctness, full original-target fidelity, supremum and inverse semantics, transitive axioms.
- Protocol: `docs/lean/REVIEW.md` and its Tau Ceti adaptation; not official Tau Ceti review or external human peer review.
- Verdict: **APPROVE the exact bytes below**. No correction requested. Sandbox Comparator and completed remote CI remain separate gates.

## Reviewed identity

Paths are relative to this Lean project. Complete canonical-source review and its hashes are in `statement-referee-1.md`. The mathematical boundary is unchanged from that approval.

| File | SHA-256 |
|---|---|
| `NLA/IE23/Proof.lean` | `4fbbefca10f57a04bd3523c5a5354703e31a698dc889d0123d0db425abf9c690` |
| `Solution.lean` | `c4e4c6fe4d34afe2ca368e38fb8705e6b08980bcd282cf06c813b10c9d3c43db` |
| `NLA/IE23/Definitions.lean` | `2ee00cdcdd36e75c481798c1522f899520790dfbbaa9e1ad831acbea14a89e81` |
| `Challenge.lean` | `145a96587f1d3026ef61af600254fd68f2a56a31d757905593a77829a80fb5e3` |
| `NUMERICAL_TARGETS.md` | `448fc539461059b80ce656251ccd8bd2a96e492e9c1f4ad3e564a62211c478a5` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lakefile.toml` | `456a1e544f2a108bb73bffaf0aacfd3a5f76d00ba171e0d5ac1504887302c6f2` |
| `lake-manifest.json` | `52b144f9ffbaa26d0d21dd3b279e16eb102b720774ebe2d5a9e41170bab0d73f` |
| `verification/referee-1-local-checks.log` | `b58c7d134c74ce6f3e81f41974cf1b897bd530e42e0360d8d20ab6359aea50c4` |

After my independent elaboration, the Proof header was qualified from “The matrix witness originates in …” to “The source attributes the matrix witness to …”. I read the revised header and verified by reversing precisely that byte replacement that the original elaborated file's SHA-256 is `a40c1497dac8da89fe408e49869bf9bac297ee45c17e47a119aa96f4c1a0959d`. No mathematical code or other byte changed. The approved final hash above includes this attribution-only correction; the local elaboration transcript refers to its mathematically identical predecessor.

## Correctness and scope

I read every declaration in Proof and Solution. Both right-inverse identities are verified by exact complex matrix arithmetic. `pseudoInverse_eq` constructs the explicit inverse `[[2/3,-1/3],[-1/3,2/3]]` of the actual conjugate Gram matrix and verifies its product with that Gram matrix is the identity. I inspected Mathlib's `Matrix.inv_eq_right_inv`, which converts this identity into equality with the actual nonsingular inverse. Thus the proof does not use a totalized singular-inverse default or substitute a surrogate pseudoinverse. The surjectivity witness sends every complex right-hand side `v` to `Xv`, and the verified right-inverse identity proves that its image is `v`. The `(0,0)` entry proves `X ≠ B`. There is no contradictory full-rank hypothesis.

The complex contraction identity expands squared complex magnitudes through `Complex.sq_norm` and `Complex.normSq_apply` to real and imaginary coordinates before exact ring normalization. Consequently it covers arbitrary complex phases, not only the real witnesses. The term `|v0+v1|²/3` is nonnegative, giving the Euclidean contraction by monotonicity of the real square root. `X`'s Euclidean isometry is established by exact coordinates.

For every nonzero complex vector, `quartic_sum_pos` obtains a nonzero coordinate, hence strictly positive fourth-power sum. `pNorm_four_pos` uses positivity of real powers to establish a nonzero denominator. The pointwise upper bound therefore uses the legitimate positive-denominator division equivalence. Both sides are nonnegative before the fourth-power comparison. The fourth-root identity uses Mathlib's `Real.rpow_inv_natCast_pow` with its nonnegative-base and nonzero-natural-exponent hypotheses satisfied. The remaining inequality follows from `(‖v0‖²-‖v1‖²)² ≥ 0` and `sqrt(s)² = s`. No rounding, sampled vector bound, or omitted complex direction occurs.

The flat vector `(1,-1)` is proved nonzero. Its outputs are explicitly computed, and `Real.rpow_add` with positive base two proves `sqrt(2)/2^(1/4) = 2^(1/4)`. Thus the same exact number belongs to both ratio sets. The proof then derives each set's nonemptiness from this membership and boundedness from the pointwise upper bound over every nonzero vector. I inspected Mathlib's `csSup_le` and `le_csSup`: their nonempty/bounded hypotheses are explicitly supplied in the correct directions. Both induced-norm equalities are actual supremum identities; empty or unbounded default values play no role.

Finally, the full universally quantified complex conjecture is specialized to the allowed dimensions `2 < 3` and interior exponent four. The concrete right-inverse and distinctness properties satisfy all its hypotheses. Rewriting the two verified supremum values yields the contradiction `2^(1/4) < 2^(1/4)`. Solution exports exactly the three reviewed Challenge signatures and imports Proof without importing Challenge. This refutes the original strict-uniqueness implication. It does not claim formalization of the manuscript's stronger all-exponent result, all-minimizer classification, minimal-dimension assertion, or higher-dimensional family.

## Independent local checks and trust

I independently re-elaborated `NLA/IE23/Proof.lean` and `Solution.lean` using the pinned Lean 4.33.1 runtime; both returned exit 0 without diagnostics. A separate audit imported Solution and printed the transitive axiom closures of all three public exports. Each was exactly `[propext, Classical.choice, Quot.sound]`. The command transcript and audit source are preserved in `verification/referee-1-local-checks.log`. This confirms there is no `sorryAx`, native compiler trust, custom axiom, or mathematical dependence on the Challenge placeholders.

LeanCert is used here for its `#assert_trust kernel` audit on all internal and public exports. Its audit implementation was inspected during this review sequence: it calls Lean's transitive `collectAxioms`, permits the three foundational axioms, and rejects sorry/custom/native dependencies in kernel mode. This proof does **not** run an interval numerical certificate, and the review makes no claim that it does. Exact matrix and real algebra suffice, in accordance with the frozen computation policy. Authorship, source-example attribution and AI assistance are disclosed.

## Remaining limits

No sandboxed Comparator run or completed remote CI result was inspected in this review. Source-level signature comparison and independent local kernel elaboration do not replace that environment-comparison gate. Final publication metadata and numbering/index validation are outside this mathematical report. Standard classical foundational axioms remain part of the trusted base. This approval is independent AI review, not external human certification.
