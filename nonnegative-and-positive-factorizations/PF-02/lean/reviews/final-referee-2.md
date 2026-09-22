# PF-02 independent final code review — referee 2

- Reviewer: `/root/new_target_screen`, OpenAI Codex AI agent.
- Phase: complete local proof, before isolated Linux Comparator and publication.
- Independence: I authored none of PF-02's definitions, statements or proof modules. My earlier independent statement report is retained. Separate SP-04/KE-05 drafting is unrelated to this proof.
- Verdict: **APPROVE** the exact local proof bytes below. No substantive correction is required.
- Scope: fidelity, mathematical correctness, transitive trust, proof quality, reuse, documentation and attribution under the already-read repository `docs/lean/REVIEW.md` protocol. This is independent AI-agent review, not human peer review or official Tau Ceti endorsement.

## Statement fidelity and frozen boundary

I previously read the full canonical PF-02 target and complete Colbrook manuscript, including its optional extensions; those source digests remain the ones recorded in my independent statement review and the frozen boundary. I inspected the frozen record again and independently matched current Definitions, Challenge, numerical plan, comparator, manifest, lakefile and toolchain hashes against it. These bytes are unchanged. I independently compared all nine exported Solution signatures with their Challenge counterparts after whitespace normalization; every signature matches. This text comparison supplements, and does not replace, the still-pending isolated Lean Comparator.

The final `not_connectedOrbitConjecture` refutes the complete universally quantified canonical question by k=3,p=q=6. Real PSD factors, full ordinary rank six, true minimal PSD rank three, all invertible real congruences, and the genuine Euclidean-subspace/quotient topology are retained. No orientation restriction, positive-determinant restriction, path-connectedness substitution, empty-quotient trick or assumed key inequality appears. The source's stronger every-size extension is not needed to negate the original question and is not claimed. No claim of exactly two connected components is made.

## Full code inspection

I read every line of `Numeric.lean`, `StructuralBase.lean`, `Structural.lean` and `Solution.lean`, together with the unchanged Definitions and Challenge.

`Numeric.lean` proves the integer witness determinant 8192 and orientation determinants ±32 by ordinary kernel-reduced `decide` over integer matrices and transports the equalities through the real ring homomorphism. It uses neither native_decide nor an external numeric oracle. Strict positive definiteness is established from actual Hermitian symmetry and positive quadratic forms: the sum-of-squares argument treats every nonzero vector, and the reflected off-diagonal factor uses the corresponding difference square. Both full trace Gram matrices are verified entrywise. These conclusions are materially used to construct the two factorization subtype elements.

The arbitrary-factor trace bridge includes the correct factor-two metric for symmetric off-diagonal entries. The congruence action identity retains every real entry of the change-of-basis matrix. Its determinant identity is an exact polynomial equality for all 3-by-3 real S, proved by finite determinant expansion and ring normalization. This replaces the source's broader polynomial-density proof without restricting the required group. It is a sensible computation reduction and does not infer a universal identity from the single rational witness.

`StructuralBase.lean` constructs actual diagonal PSD factors for every nonnegative rectangular matrix. The generic minimum theorem supplies nonempty feasible positive sizes and uses the natural-number least-infimum API, so default empty-infimum semantics are irrelevant. Congruence reflexivity, symmetry and transitivity are proved with matrix-ring units and the exact inverse-transpose formula. The quotient theorem connects generated equality back to actual congruence and uses Mathlib's coinduced quotient map. The rank bound flattens all k² entries with the trace pairing's reversed index and uses the real matrix-product rank bound. It does not smuggle in a smaller factor space or use PSD/symmetry to claim an unjustified rank bound.

`Structural.lean` obtains full rank from the nonzero witness determinant and proves minimality by ruling out every positive k≤2 using rank≤k². The weaker general bound suffices for rank six and avoids unnecessary all-dimensional symmetric-space infrastructure. For an arbitrary actual size-three factorization, the trace-coordinate identity and det(M)=8192 force its row-coordinate determinant to be nonzero. Thus no admissible factorization has been deleted to make orientation continuous.

Continuity is proved on the entire factorization subtype through det/abs(det), with the denominator nonzero already established. Every unit S has nonzero determinant, and its fourth power is positive even for orientation-reversing S; the genuine congruence action therefore preserves the sign. `Quot.lift` and Mathlib's quotient continuity theorem produce an actual continuous quotient function. Both explicit factors prove that its range is exactly {−1,+1}. A preconnected quotient would have a preconnected real image and hence contain zero between those values, contradiction. Finally the full conjecture is instantiated with all required positive dimensions, ordinary rank and minimal PSD rank. This proves actual disconnectedness of a nonempty quotient, not merely two inequivalent factors.

`Solution.lean` is a transparent export layer. Each of its nine frozen statements is discharged by the relevant proved helper; it imports Structural and never Challenge.

## Independent local checks actually performed

I inspected the author's successful `verification/solution-local.log`: 3592 jobs, nine axiom outputs, no proof placeholder warnings. I independently ran current `lake build Solution`; it completed successfully with incremental replay. That output is retained as `verification/final-referee-2-build.log` and is not described as a clean build.

I then independently ran `lake env lean Solution.lean`, causing a fresh elaboration of the export module and re-execution of all nine `#assert_trust kernel` commands and all nine `#print axioms` commands. It exited zero. The independent output is `verification/final-referee-2-export-audit.log`. Every export's transitive axiom list is exactly `[propext, Classical.choice, Quot.sound]`. No sorryAx or custom axiom appears. This audit uses existing dependency objects; isolated Linux/default-kernel checking remains a separate gate.

I searched the entire local proof closure (Definitions, Numeric, StructuralBase, Structural and Solution) for proof escapes: no sorry/admit declaration, custom axiom, unsafe/native_decide implementation, extern/implemented_by substitution or Challenge import was found. The only trust settings select LeanCert's kernel level. The nine expected Challenge placeholders remain outside the proof import closure. LeanCert is concretely used by all nine export trust assertions; this pure exact algebra/topology proof needs no artificial interval certificate.

## Reuse, clarity, attribution and nonblocking observations

The code uses pinned Mathlib APIs for PSD quadratic forms, diagonals, determinant transport, matrix rank, natural infima, equivalence closure, quotient topology, determinant continuity and preconnected real intervals. Helpers clearly separate exact witness algebra from generic rank/quotient foundations and the topology argument. The fixed degree polynomial calculation avoids importing an unproved general congruence theorem. I found no source fact replaced by an axiom.

The current `formalization.yaml` accurately lists all nine completed local exports and the three standard axioms, records original mathematical credit for Matthew J. Colbrook and formalization credit for Sidney Holden, discloses AI assistance, and explicitly leaves final reviews and Linux verification pending. I inspected its content; I did not independently rerun its schema validator. The reviewed local-proof receipt matches the proof file hashes and clearly distinguishes macOS from isolated Linux.

The local log has cosmetic Numeric linter warnings for an unreachable final rfl and unused simp arguments. They do not weaken a proof or mask a failed obligation and are not an approval blocker. If these lines are subsequently changed, the affected proof hashes and mechanical checks must be refreshed. `maxHeartbeats 0` and the raised recursion bound only control elaboration resources; they introduce no axiom or unchecked computation.

## Exact reviewed hashes

| File relative to lean project | SHA-256 |
| --- | --- |
| `NLA/PF02/Definitions.lean` | `8ec6b4b58a99eb5e4554ebe7807619665c52deb83405083ba40b224a935b1f1d` |
| `NLA/PF02/Numeric.lean` | `647842caf04abde095886828e36b049806559c903ce1b704c0bf46063707b4fb` |
| `NLA/PF02/StructuralBase.lean` | `4d462aa86dbbfca6e59f2ff71ab20fd29840400b9fe164c8829d4e9b5dd8c3d7` |
| `NLA/PF02/Structural.lean` | `8f5c29c475cdc30317ceacab53204a117432ee4584bf9a642715cbd00f97b006` |
| `Solution.lean` | `6748db358bded3e18e451c3760dc4bea619a21ab4a9a623239e759500d3998a5` |
| `Challenge.lean` | `1984dbc1415c91951df296f00011049c5ccc0a5baabe937cb8e107a411c51532` |
| `NUMERICAL_TARGETS.md` | `7ce9ec1ed32cf81c213cbba661c367f5528e536361fb6a2a715c5c36c72c5758` |
| `comparator.json` | `8b17ff697fb75d3d8ba82a8ce169ca895d2402148a353301ba683ffd7193ceb4` |
| `formalization.yaml` | `a5d20c9f4fed3965f8f395a7ba3ea6cc0cd5f6643d3e57021214d2d39e488bd2` |
| `lakefile.toml` | `e9d31a3273307f6e5c4e1031f339b2de1d1980b3412ea2fa2982efdeb4270cb1` |
| `lake-manifest.json` | `19b43bd134b48c326c0977c6134db0c9a7da9fc89961d20cd303390ac7154eda` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `verification/statement-freeze.json` | `18078dcd60f2ecae20103eaaf92194f4f7e0627466d737145c0fafac0271ed26` |
| `verification/source-provenance.json` | `3be2f3b7162fa2126f1363df34a6c0f4ec3ebe0fa0636218062cc69e7bdddd97` |
| `verification/solution-local.log` | `6f7b95747ab71392468ec5a774d2f02a3cc1e7bf488f392c284eb6856f2b4d24` |
| `verification/local-proof.json` | `6c3846f8d0e2ea38b36e2c4cafb03e2259df94aed683ab1387f847fd18f6836a` |
| `verification/final-referee-2-build.log` | `ac02fe7d9671967a008b7a3539c4f8977f9106f1cbfc91ee90db10c55ba994ea` |
| `verification/final-referee-2-export-audit.log` | `3f9d14efc13a51b625bfbbb72f4bf24570fc2af2ddf84166651dcc2e1d340bc3` |

## Remaining gates

This report approves the local proof code only. Actual isolated Linux Comparator, default-kernel replay, rejection/sandbox controls, final metadata/publication updates and their evidence are outside this review and were not claimed successful. The other independent final referee remains a separate required gate. Any material changes to the mathematical boundary or proof require rereview; later status-only metadata changes should preserve the mathematical scope and record new hashes. No source-author endorsement, human peer review, or official Tau Ceti verification is asserted.
