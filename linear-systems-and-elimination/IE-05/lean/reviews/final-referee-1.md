# IE-05 independent final proof referee 1

**Verdict: PASS for mathematical fidelity and the completed local Lean proof.** No blocking mathematical or trust findings. Actual isolated Linux Comparator/default-kernel replay and its rejection controls remain pending; this report does not authorize canonical status promotion or claim those gates passed.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not an implementer. Phase: final proof review. Date: 2026-09-14. Scope: correctness, complete original target, denominator and supremum nondegeneracy, all-tie GEPP, QR, source/API and computation review under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is automated-agent review, not external human review or an official Tau Ceti assessment.

## Reviewed boundary and source

I read all four implementation modules in full, Definitions, Challenge and Solution, and reread the entire canonical README and complete Stepaniants `solution.md`. I verified that Definitions, Challenge and numerical targets are byte-identical to the pre-proof freeze `3fd6665e`, approved previously by both statement referees. Both canonical source files are byte-identical to `9777c86853b40206f70438c92a47a7dec9bc66ae`; no permanent ID/path or original target has changed. Canonical README SHA-256: `b5e980fa1f171ac540465212341dfc589d4f34d33c0b59d54a520dd3b0a4f1f5`; solution SHA-256: `1b94eda6df18066f2f09b66b8b28a18ca071c0c2fb070b536dc8c798992ae434`.

All 17 entries in `reviews/proof-source-hashes.json` were independently recomputed and matched, including at report creation:

| File | SHA-256 |
| --- | --- |
| `NLA/IE05/Definitions.lean` | `39e5c319afb8d8b18b4c60518a3be0f79381416b2e5340b18cf3485a7b0528e6` |
| `Challenge.lean` | `d9ee825a21016cd86c1d507e32f117bfd3039e6bb94e84597d35ec74f8911a0a` |
| `NUMERICAL_TARGETS.md` | `349088fa17814d5122d1bcd9769adb9dfbd67b7424f59ab869a73100658c4241` |
| `NLA/IE05/Bounds.lean` | `5372fb039987ccb138b944e02789f0ac8904f34ad8f4b8419edd953eb20a6e60` |
| `NLA/IE05/IntegerCertificates.lean` | `73b7db5e17bd3cf3851b02d74b22742d78a6bcc0d2a7a8177d75c397fbd9c39f` |
| `NLA/IE05/RealCertificates.lean` | `324d36d1ae11af5c611970b85ee4e50a064d835a73f1623f8adbc3c21a13c4f3` |
| `NLA/IE05/Proof.lean` | `e7b19bce4ab022283190239bf489d6346a7f018a23fbe8876fd7fdfcd06f20bb` |
| `Solution.lean` | `24c59beb585cf9ac0b8d4614773b4a9b0ed6dbb0f20c24bf9105c9ad750d07ed` |
| `comparator.json` | `26518dfeeefdf7a8a293eaf5ad06b2cec04789e8cd6f82a2c9f9e104915109f8` |
| `lakefile.toml` | `eddadc9ee1b75205a57c70e03e8a1a9ddcaab15a0ff50335445446f9c7add352` |
| `lake-manifest.json` | `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `formalization.yaml` | `9ce0fd1b574b07266dce5ef5cd34445bbdc42875812792ffbd28087077fa222b` |
| `README.md` | `51b81f694395f036b3b58f94409cd8f42547edf5317da70a9c4b7aa1ba17a568` |
| `verification/final-build.log` | `f8aba8e4bb64f11855d9150fda8cf8152cd1037495d4bc8f562bb801ed0779a0` |
| `verification/AxiomAudit.lean` | `f21c603a53f2836a14b7e5eb05e8d5666cbfbdd80877d6bb84f2d0ed9289150c` |
| `verification/axioms.log` | `f6d37b8de9f73484a5b3601552aebb013de1ab2bbae98bef8f9ac3140c8a7739` |

## Correctness and full original scope

**Actual norms, divisions and general paths.** `entryMax` remains the finite supremum of nonnegative absolute individual entries, and `growth` takes every entry of every active stage before dividing by the actual input maximum. I checked the finite-supremum order lemmas used in Bounds against Mathlib's join-fold definition. The proof does not substitute final-pivot growth or a different matrix norm. `path_input_pos` obtains a nonzero stage-zero pivot from an arbitrary valid path and bounds its positive absolute value by the input maximum. Every division used to compare growth is therefore justified by strict positivity, with no real division-by-zero fallback.

`schur_entry_bound` covers arbitrary eligible pivot rows, including swaps. Its case analysis proves that the swapped retained row remains eligible, so partial pivot maximality bounds the elimination multiplier by one. The triangle inequality then bounds each actual next Schur entry by twice the previous entry maximum. `path_stage_bound` proves the bound at every relevant stage by induction, using the recurrence only for k+1<n. `path_growth_bound` yields the deliberately loose but sufficient uniform 2^n growth bound for every nonempty-dimension admissible path, without requiring orthogonality. Thus it applies to every element of the all-orthogonal/all-tie growth set. Zero-padded entries and sequence values beyond n cannot increase the defined stage maximum.

**Integer certificates and actual positive QR.** Both frozen H, T, D arrays and the one-entry modification of L8 are used directly. Kernel-decidable integer certificates prove positive D and T diagonals, Gram identities, triangularity/positive diagonal of HᵀL, initial state equality, pivot-column identities and every required recurrence. These are proved facts, not assumptions imported from the diagnostic JSON. `realStates_cast` proves equality between the source LU state formula and its normalized integer form; it does not redefine the path relation.

`real_orthogonal` lifts HᵀH=diag(D) through strictly positive column square roots to QᵀQ=I. `real_qr` uses the genuine R=QᵀL, proves QR=L using the square-matrix one-sided-inverse commutation fact, and proves all below-diagonal entries vanish and every diagonal entry is positive. I inspected the actual `mul_eq_one_comm` API; it exchanges AB=1 and BA=1 in the relevant Dedekind-finite matrix monoid, without assuming the conclusion. Both source positive-QR conventions are established, not merely orthogonality or a no-exchange LU factorization.

**Real GEPP recurrence and first tie rule.** `real_recurrence` maps k with k+1<8 into Fin 7 and lifts the exact integer recurrence. All T pivots and all square-root denominators are proved nonzero before cancellation. It concludes equality with the original `schurStep` for the displayed no-swap pivot, including inactive zero padding. The pivot-column identity expresses each eligible entry as the diagonal pivot times an entry of L of absolute value at most one. The diagonal pivot is strictly positive. The resulting `real_first_path` proves every pivot is admissible and k itself is the smallest eligible row, hence the first maximizing row. The last pivot is included even though it has no successor state. These are true GEPP paths. The unrestricted `isPath` remains in the supremum set, so no tie choices are dropped from the original left-hand side.

**Minimal one-sided separation and real supremum.** The candidate all-stage squared bound gives |entry|≤sqrt(5462); the actual candidate input entry at zero-based (2,2) supplies 51/sqrt(3286)≤entryMax. Nonnegative square-root algebra then gives growth≤sqrt(17948132/2601). For the witness, every input squared entry is bounded by 3969/5272, while the final active pivot is 5272/sqrt(5272); positive-denominator comparison gives growth≥5272/63. Inequality directions are correct for both denominators. The two exact rational point cuts through 167/2 establish strict separation; squaring is used with the necessary nonnegative roots and positive rational bounds.

The witness is explicitly a member of `orthogonalGrowths 8` by its proved orthogonality and admissible path. The generic path bound proves this entire set is bounded above by 2^8, and witness membership proves nonemptiness. I checked real sSup's conditional definition and the `le_csSup` bridge: the proof uses the genuine nonempty bounded supremum, not the fallback zero for an empty/unbounded set. Strict growth separation therefore yields candidate growth < sSup. `counterexample` specializes the original all-n universal conjecture at n=8 with the proved candidate positive QR and first-tie path, obtaining the contradictory equality. This proves the complete original negative answer. It intentionally does not assert the full exact source stage tables, the true orthogonal supremum, or the separate asymptotic conjecture.

## Kernel computation and independent replay

I independently re-elaborated Bounds, IntegerCertificates, RealCertificates, Proof, Solution and the exported AxiomAudit with pinned Lean 4.33.1 on local macOS and the shared pinned dependency cache. All six commands exited 0. Approximate durations were 6.59, 11.01, 10.20, 9.75, 7.05 and 7.04 seconds respectively. Only the existing harmless sequencing/deprecated-notation linter warnings appeared in Proof. The solution modules contain no `sorry`, `admit`, added `axiom`, `native_decide`, `unsafe` or `implemented_by`. Challenge's four intentional placeholders are confined to its separate statement environment and are not imported by Solution.

My separate audit printed transitive axioms for all four exports and, additionally, `scalar_separation`, `int_state_recurrence` and `path_growth_bound`. Every audited declaration has exactly `[propext, Classical.choice, Quot.sound]`; no native computation axiom or `sorryAx` occurs. Solution's four `#assert_trust kernel` commands also replayed successfully.

I printed the actual `scalar_separation` proof term. Both cuts invoke `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked` at the singleton interval [0,0], precision -53 and depth 10, with the exact rational expressions and bounds. I inspected that theorem's implementation: it derives domain validity and the real evaluation bound from the checked dyadic certificate. I also inspected LeanCert's kernel certificate closure: it constructs a decision proof, eagerly validates an auxiliary lemma with `mkAuxLemma`, and the explicit kernel branch has no native fallback. The checked proof term, source trust settings and transitive axiom audit agree. The word `Unchecked` inside the internal dyadic evaluator is not an unchecked theorem premise: the exported soundness theorem supplies the required checked-domain and interval-evaluation proofs.

The computation is appropriately reduced: exact small finite integer certificates, shared Boolean-parametrized lifting for both matrices, positive roots factored once by column, and only two scalar point inequalities. No interval partition search, repeated irrational elimination, or unnecessary exact global stage-maximum theorem is used. The nearby finite NNReal supremum pattern and Mathlib's matrix, real-square-root and conditional-supremum APIs are reused rather than replaced by oracle definitions. Attribution preserves Stepaniants's counterexample, Peca-Medlin's conjecture, Holden's formalization credit and disclosed Codex assistance.

Own evidence, independent of the author's build/audit logs:

- `verification/referee-1-final-replay.log` — SHA-256 `3fc552dbf4e7e689976b22bff50cb1e23d727b0a74ccf7e7d676d492fe7f09e7`
- `verification/Referee1FinalAudit.lean` — SHA-256 `aad66f3214c8e7381b2592b2b57f0551abfc843c485631fa850aa7a67d4bce47`
- `verification/referee-1-final-axioms-and-terms.log` — SHA-256 `0c5dbb5de0c97b0e11fa6e0d9dbf018f03bb0e964f31742cfbf34deeb72bcac0`

## Remaining limitations

The local replay shares the existing pinned dependency build cache; it is not a clean Linux rebuild, sandbox rejection test or a Comparator execution. `comparator.json` names all four correct exports with no definition holes and only the three standard permitted axioms, but configuration inspection does not establish a successful run. README/formalization metadata truthfully described final review and Linux gates as pending at the reviewed hashes; wrapper updates after these reviews need not alter the mathematical boundary. The canonical page must not be newly promoted based only on this local approval. No proof or metadata was edited by this referee. Latest account usage check during this review: 29% remaining, above the user's 25% checkpoint threshold.
