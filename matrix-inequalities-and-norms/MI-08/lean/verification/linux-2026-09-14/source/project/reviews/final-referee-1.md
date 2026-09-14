# MI-08 independent final proof referee 1

**Verdict: PASS for the completed local proof within the explicitly partial scope.** No blocking mathematical, scope or trust findings. Adaptive comparison and the general optimum are not formalized. Actual isolated Linux Comparator/default-kernel replay with rejection controls remains pending; no push or canonical promotion is claimed.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the implementer. Date: 2026-09-14. Phase: final proof. Review covers correctness, limited-scope fidelity, quantifiers, integer/real bridges, rank/divisibility, leastness, computation and source/API attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not official Tau Ceti or external human review.

## Boundary and evidence

I read all of Correspondence, Designs, Proof and Solution, the current README/manifest, author build and axiom logs, and relevant imported Mathlib/LeanCert APIs. The complete canonical README, solution.md and solution.tex were read in the statement review; all three were independently verified unchanged from `9777c86853b40206f70438c92a47a7dec9bc66ae`. Their source hashes are retained in `statement-referee-1.md`. Definitions, Challenge and numerical targets match the pre-proof freeze `607a5e4a`. Preserved statement README and formalization.yaml match their original reviewed hashes.

All 17 final snapshot hashes were independently verified, and rechecked at report creation:

| File | SHA-256 |
| --- | --- |
| `NLA/MI08/Definitions.lean` | `3d239b1379ea53cead7b54a06ed8ae92e2d191420f45a39b5466dcd6380c3965` |
| `Challenge.lean` | `7ef811f91e89621f606400fb76756068f941c30f94ac4d9135bb6111d115413e` |
| `NUMERICAL_TARGETS.md` | `c8bf9ab6782e2bec826664fe69cd09a523e495cedadbee64ada5f4eca6d25832` |
| `NLA/MI08/Correspondence.lean` | `3bf9263dcc6726a08b4cfd31aa9386c872c38ba58cb607de184ee78a8e143741` |
| `NLA/MI08/Designs.lean` | `a3d875b90fee6e891d9a1af914ac1d2a60002a28aca3f8f6aa325e2ff5742a5f` |
| `NLA/MI08/Proof.lean` | `b78a5e6dc64f679329fa5fbb05ece206d161f503578d4b50b72a8ebd23f156e7` |
| `Solution.lean` | `bf8b01921469343f9a3acd5f2fe875e9530de4c69024af8b0fd2b409fd401950` |
| `comparator.json` | `18928dd61159e774c47a220a825f4666881e2a89fa825514bd800a91463bf465` |
| `lakefile.toml` | `0ba5280ec9dd388e19ebb4b09e1257f4f8851b72da6ed8a3432a647eed9720b4` |
| `lake-manifest.json` | `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `formalization.yaml` | `5772fa9a218b656e5a20483b6ff0172b6c4a5c7f742e2f39162823082d8fe7b3` |
| `README.md` | `6cf0b930926a7fab68bef677494a6764c8ca797f338e673fb3ff8167261af564` |
| `LICENSE` | `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30` |
| `verification/final-build.log` | `c17c819aedabeb1abaeecd3694c5c2b4e1cac5443879933eccefcff0a5154aa3` |
| `verification/AxiomAudit.lean` | `b1ab427ee49ed7941c6fcdcee8f872cc2f70bf7e281772d136cd1f9c8e198c32` |
| `verification/axioms.log` | `1dcbbca3ec0905bb7404494e4f06f9edec7bad84454ce396f0cd64c301be74a3` |

## Correctness and scope

`FixedPinching` is still the actual equal-weight identity for every real square matrix, with the SAME list fixed outside the input quantifier. All factors satisfy actual UᵀU=I and q is positive. No diagonal restriction or symmetric-input restriction has been inserted. The unused positive-dimension binder in the public equivalence is harmless: its helpers also handle dimension zero, while the advertised theorem preserves the original positive-dimension domain.

`conjugate_unit` proves the actual entry formula for U E_ab Uᵀ. `factors_diagonal` applies the fixed identity to E_jj at a different diagonal position i, obtaining (1/q) times a sum of real squares equal to zero. The positive natural q is correctly cast to a nonzero real, so the factor 1/q cannot vanish. Mathlib's `sum_mul_self_eq_zero_iff`, which I inspected, then forces every individual off-diagonal entry to zero. This uses the ordinary ordered-real theorem, not an unjustified cancellation of summands of mixed signs.

`factor_signs` evaluates UᵀU=I on the diagonal; all other column entries have already vanished, leaving the surviving diagonal entry squared equal to one. `fixed_to_design` selects the corresponding integer ±1 and proves that its real cast is exactly that diagonal entry. Applying the averaging identity to EVERY matrix unit E_ij, including nonsymmetric units, gives all cross-column Gram entries. Positive-q cancellation and `exact_mod_cast` establish the actual INTEGER equation HᵀH=qI. There is no approximation, integrality assumption on arbitrary U, or choice depending on X.

Conversely `design_to_fixed` constructs real diagonal factors from each sign row. Their orthogonality follows entrywise from ±1. It casts the complete integer Gram identity to the reals and proves the average equals diagonal extraction entrywise for arbitrary X. The q≠0 hypothesis is available before all division simplifications. Thus the two directions prove the full fixed-list feasibility equivalence for every positive d and q.

`design_obstructions` uses actual Matrix.rank over ℤ. Positive q is nonzero in ℤ and hence a non-zero-divisor; the inspected `rank_smul_of_mem_nonZeroDivisors` theorem applies directly over this integral domain, so no field-only rank fact is misused. Rank(qI)=d, rank(HᵀH)≤rank(Hᵀ), and Hᵀ's width q give d≤q. This also covers d=0 without an invalid nonempty-index assumption.

When d≥3, the proof chooses three genuinely distinct columns, obtains all three zero correlations from the Gram equation, and adapts Mathlib's Hadamard divisibility argument correctly. Each integer summand (1+ba)(1+ca) is divisible by four and expands to 1+ba+ca+bc because a is a sign. Summing gives q, and `Int.ofNat_dvd` returns the requested natural divisibility. There is no illicit application of the square Hadamard theorem to rectangular matrices; the source adaptation is explicitly credited to Dennj Osele.

`twelve_integer_certificate` unfolds the unchanged explicit 12-by-12 matrix and SignDesign and proves the full finite sign/column-Gram certificate by `decide +kernel`. It does not import the diagnostic precheck. The preceding statement review independently checked all entries, residue indexing and Gram orientation, and the exact bytes are unchanged. `restrict_design` proves the Gram identity after an injective column restriction; injectivity is essential and is actually required, so distinct target columns are not accidentally merged.

`finite_minimums` uses the injective `Fin.castLE` map for every d≤12, restricts the actual certificate, and applies the proved reverse correspondence to produce a REAL fixed pinching list of length 12. Its positive row-count premise is obtained by exact cast from the LeanCert-proved conjunct of `hadamard_twelve`. Thus that numerical proof is connected to feasibility. For every arbitrary feasible q, the proof extracts its genuine sign design, rank bound and divisibility; d≥9 then forces q≥12. This proves actual membership and `IsLeast`, not merely a lower bound on designs. Nonemptiness is explicitly returned, and `hleast.csInf_eq` yields the genuine natural infimum. The empty-set sInf=0 convention cannot discharge the theorem. All four endpoints d=9,10,11,12 are included.

Current README and formalization.yaml correctly limit claims to fixed feasibility for all positive dimensions/lengths and the four exact minima. They exclude the source adaptive comparison and do not claim a general value of the optimum or completion of the canonical open problem. Source credit, original Bourin–Lee question, Holden/Codex assistance, Mathlib attribution and Apache-2.0 licensing are retained.

## Independent replay and trust

I independently re-elaborated Correspondence, Designs, Proof and Solution using pinned Lean 4.33.1 on local macOS and the shared pinned dependency cache. All four exited 0 with no warnings. Their logged times are 11.80, 11.52, 14.60 and 13.30 seconds. My separately named audit also exited 0. Every public export, and additionally `factors_diagonal` and `twelve_integer_certificate`, has transitive axiom closure exactly `[propext, Classical.choice, Quot.sound]`. Solution's four `#assert_trust kernel` checks replayed successfully. No solution source contains `sorry`, `admit`, added axioms, `native_decide`, `unsafe` or `implemented_by`; Challenge placeholders remain in the separate unimported statement module.

I printed and inspected the actual `hadamard_twelve` term. Its strict positivity conjunct invokes `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked` with constant zero, exact bound twelve, singleton interval [0,0], precision −53 and depth 10. The term therefore proves the advertised real 0<12. I inspected the pinned kernel closure using `mkDecideProof` and eager `mkAuxLemma` validation; explicit kernel mode has no native fallback. The theorem's checked-domain/evaluation soundness API was inspected in the preceding IS-02 review of the same pinned dependency. Actual term and axiom audit agree with kernel trust. The matrix certificate itself is ordinary kernel finite integer computation, while all general claims use symbolic proof.

The implementation minimizes computation appropriately: matrix-unit arguments instead of source adaptive/Frobenius machinery, exact rank and three-column arithmetic, one explicit integer certificate, then column restriction and natural arithmetic. There is no candidate search, floating-point oracle or interval subdivision. Reuse of existing Mathlib sum-of-squares, rank, finite sum and Hadamard proof structure is correct for the advertised scope.

Own evidence:

- `verification/referee-1-final-hashes.log`: `cbe0ffc9f73b9b916ccdfd1b962363e5380ceac44b5236979e23def224d5dae5`
- `verification/referee-1-final-replay.log`: `d7a9cf8f661ee831af356cf65790eef552640de029c955cd20530ac56f8c7405`
- `verification/Referee1FinalAudit.lean`: `53aa9f3db5a7df8342cc8595e0db7e177ce38ee55c0e2c59b8b0904fd19c2a57`
- `verification/referee-1-final-axioms-and-terms.log`: `051853185483ab7b546457f9486ee864128eebb5d28119cdb62af2fe9969ef2e`

## Remaining limitations and usage checkpoint

This local replay shares cached dependencies and is not an isolated Linux rebuild or Comparator execution. The author's 3584-job build log was inspected, but the independent commands above are this review's mechanical evidence. Comparator configuration matches all four exports with no definition replacements and only the three standard axioms; its actual Linux theorem-comparison/default-kernel replay and rejection controls remain pending. No proof or metadata was edited by this referee and no push was attempted. The mathematical review is complete, but canonical status remains Partially resolved.

Account usage was checked at the start and during this bounded review: 26% remaining, above the user-required 25% stop threshold. If the parent subsequently observes 25%, it should checkpoint without starting further work.
