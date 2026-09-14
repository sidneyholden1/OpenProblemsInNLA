# IV-06 independent proof referee 2

- Phase/date: completed proof source review, 2026-09-14.
- Reviewer: `/root/iv06_statement_referee_2`, independent OpenAI Codex AI agent, not an implementer, human referee, or official Tau Ceti service.
- Base revision: `9145e017c546b2982d9da1f56b427a30c442500c`; proof and metadata reviewed from the working tree at the hashes below.
- Verdict: **APPROVE** the proof implementation and fidelity at these bytes. No substantive defect found. Comparator is a separate gate and was not run or inspected by this reviewer.

## Full-target fidelity and proof correctness

I rechecked the implementation against the complete canonical IV-06 target, full supplied Colbrook manuscript, frozen definitions, Challenge signatures, and numerical targets reviewed in `statement-referee-2.md`. The earlier t=12 lower-bound finding remains resolved: the actual proof uses ha.1 and hb.1, not the upper bounds. The boundary retains all natural dimensions n≥1, independent closed real entry intervals, nonzero real eigenvectors, standard real topology, and actual nonempty connected components with extended-natural cardinality. No custom definition hides the desired conclusion, a finiteness assumption, or a symmetry restriction.

`witness_admissible` proves all nine entry inequalities. `admissible_representation` proves the converse representation of an arbitrary admissible matrix by its two variable entries; seven singleton entries are forced by both inequalities. This prevents the separator proof from accidentally excluding eigenvalues only for a proper subfamily. `eigenpair_in` supplies genuine interval-family membership and nonzero real eigenvectors. The four included points use exactly the source parameter/vector table and kernel-checked integer matrix-vector multiplication.

`eigen_equations` derives the three row equations from an arbitrary eigenpair after proving the matrix representation. It carries both bounds on each independent variable. At -1 and 1 the two fixed rows force the first coordinate and one other coordinate to vanish; a≤-16 and b≥9 respectively make the remaining coefficient nonzero. At 12 the proof substitutes v0=13v1 and v2=(13/11)v1, obtains `(1859+11a+13b)v1=0`, and uses a≥-166, b≥9 to make the coefficient strictly positive. `vector_zero` covers all Fin 3 coordinates before contradicting the actual nonzero-vector hypothesis. No division by an unproved nonzero vector entry occurs.

`separated_components` uses imported connected-component membership, preconnectedness, `IsPreconnected.Icc_subset`, and component inclusion in S. Its weak endpoint inequalities are sound: if a missing separator equaled a member endpoint the hypotheses would already be inconsistent. The concrete applications use strictly intermediate numbers. All six unordered pairs of the four witness components are shown distinct, using the appropriate excluded separator. `counterexample_proved` counts those four components via `Set.encard_insert_of_notMem`, proves inclusion into `components witnessSpectrum`, and applies `Set.encard_le_encard`. I inspected both imported cardinality lemmas and the real-interval lemma; no finite-set junk cardinality is used. The final proof instantiates the full conjecture at dimension 3 and derives 4≤3 in extended naturals. This refutes the complete original target without having to identify all component endpoints or establish an exact count.

## LeanCert and independent mechanical checks

The actual proof path uses `separator_margin`, certified by `interval_decide (trust := kernel)`, to prove positivity at the lower parameter corner. The expression is exactly 150; linear arithmetic lifts that margin to the entire parameter rectangle, so no interval subdivision is needed. I inspected the pinned point-inequality tactic, kernel certificate dispatch, trust assertion implementation, and the strict dyadic soundness theorem. The kernel mode does not fall back to native trust, and `#assert_trust kernel` collects transitive axioms, rejecting sorry, custom axioms and compiler trust.

I independently ran `lake env lean NLA/IV06/Proof.lean` with Lean 4.33.1 from the specified local runtime. It exited 0 with no output; `verification/referee-2-proof-elaboration.log` records the empty successful output. This independently elaborates the implementation and its four transitive trust assertions. I also inspected the author's successful `verification/proof-build.log`, which builds both Proof and Solution.

A separate independent temporary file importing Solution printed axioms for all four public exports and printed the compiled `separator_margin` proof; the run exited 0 and its output is retained in `verification/referee-2-axioms-and-margin.log`. Every public export has exactly `[propext, Classical.choice, Quot.sound]`. The margin proof actually invokes `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked` for constant zero below rational 150 on the point interval [0,0]. Thus LeanCert is used in the proof term, rather than merely imported or bypassed by a successful arithmetic fallback. No sorry or native-compiler axiom appears in these exported proof dependencies. The temporary audit consisted solely of `import Solution`, four `#print axioms NLA.IV06.<export>` commands, and `#print NLA.IV06.separator_margin`.

## Reuse, structure, attribution and metadata

I inspected the existing MI-29 `scalar_gap_positive` pattern and final trust assertions as concrete Lean examples. The new proof appropriately reuses Mathlib's real connectedness, matrix notation, finite coordinate calculations, and extended-cardinality APIs. Small local lemmas have clear purposes; `separated_components` is reusable for arbitrary real sets. More abstract determinant or eigenvalue machinery would increase work without strengthening this counterexample. The numerical computation has already been reduced to exact arithmetic and one point certificate, so no costly spectral or interval search is justified.

The four Solution signatures match Challenge textually and reference proved exports. Solution imports Proof, which imports Definitions; Challenge is absent from that dependency path. Actual isolated Comparator remains necessary to enforce trusted-environment identity mechanically.

The headers and manifest distinguish mathematical source author Matthew J. Colbrook from formalizer Sidney Holden with OpenAI Codex assistance. They preserve Mathlib, LeanCert, Comparator and example-workflow credit and do not claim human peer review or source-author endorsement. `formalization.yaml` records the complete negative target and its alignment, all four results, allowed foundational axioms, exact-algebra divergence, and exclusion of deliberate Challenge placeholders from solution sorry counts. The README and manifest currently mark verification and Comparator as pending, which is a conservative truthful state at the reviewed bytes. Their final statuses should be updated only to reflect evidence actually obtained. I have not independently authenticated names, affiliation metadata, legal ownership, or author endorsement.

## Limitations

This is an independent AI source review plus local elaboration and exported-axiom inspection, not human peer review, a full audit of the Lean kernel or every transitive Mathlib/LeanCert implementation, or an official Tau Ceti review. I inspected the relevant imported definitions and used lemmas described above, rather than claiming to read the entire dependency graph. I did not run or inspect isolated Linux Comparator, validate the formalization.yaml schema, or rerun catalog safeguards. Those remain the root task's separate gates. Later source changes require review against the new bytes; metadata-only status changes require evidence review but do not invalidate unchanged mathematical source hashes.

## SHA-256

- `NLA/IV06/Definitions.lean`: `880ca2f1b14e420ccb613fa560668d9d560329f2901421772fbe68a765aab0f7`
- `NLA/IV06/Proof.lean`: `965874d9b3311ec29edc9d6f79e92df950c4e66a072b7d88351adc3648aa4e36`
- `Solution.lean`: `0ec0a35417c1ad929087daaabdf39b6a9f54235fcbc166cdf7d9b12e392dd421`
- `Challenge.lean`: `b81665e31d3b971929e00d1096788accc9943ffd2c3bc947c0481460e9497ff1`
- `NUMERICAL_TARGETS.md`: `631d38fec203c0da5dc57be09320df336049362718c43903788fba8a9d13fc8d`
- `formalization.yaml`: `aa931ee3cf61026fe2510b90a8c13bff94f83cfc235b3022b57ba1f5f7b2515e`
- `README.md`: `9f90e8d41b19e2c3d1381093b0b20c08020acf8a73d6a40beed3603728ab3295`
- `comparator.json`: `a4b755670a708d19c49160a3687d44620eb309d2c8c10528ad3f7ca805e86ff1`
- `lakefile.toml`: `dbf2f6562944c0730e262b80bea86abf6e5950684fe093af984cfbeab0a1029a`
- `lake-manifest.json`: `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08`
- `verification/proof-build.log`: `ba7e88022604b2a9400dec95732b7f5961e452a3a8e83caf5430e88733dfc2cb`
- `verification/referee-2-proof-elaboration.log`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`
- `verification/referee-2-axioms-and-margin.log`: `16ff646cd1d0dc83eb6e74ee52ebff1c9e4864e70765109fb169a713429f9fb3`
- `.lake/packages/LeanCert/LeanCert/Tactic/IntervalAuto/PointIneq.lean`: `b88723998a7f63e9673b9af36811a039057fed75e2a550f4fd7788472180876f`
- `.lake/packages/LeanCert/LeanCert/Tactic/Verification.lean`: `2c576708b528acdde17796b0b715b83079f9cad377182dbd87c248323ff0a58c`
- `.lake/packages/LeanCert/LeanCert/Validity/DyadicBounds.lean`: `6f1cdbc11f32e425ef5e9f4a22966d64ff0d11614ec9453ed7dde498e31a7c47`
- `.lake/packages/mathlib/Mathlib/Data/Set/Card.lean`: `66ccca9b43ba4c1f2905dcc5f775675711451d5e4055be95b0ff8ba950dbc39c`
- `.lake/packages/mathlib/Mathlib/Topology/Order/IntermediateValue.lean`: `6e22cbb5e8b9124378735958f0282285a127f3b1dc9eaafeb2c714f89222ba65`
- `.lake/packages/mathlib/Mathlib/Topology/Connected/Basic.lean`: `7954c5a7e0b570ecdbeb53e17d7ba15f79028cc6530deb8875531612bd94eff8`
