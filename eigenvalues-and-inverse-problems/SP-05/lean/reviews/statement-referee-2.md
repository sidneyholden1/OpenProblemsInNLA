# SP-05 independent statement referee 2

Phase: statements, before proof implementation. Reviewer: OpenAI Codex AI agent `/root/new_target_screen`; not the statement author. Verdict: **APPROVE** for the exact bytes below. This is independent agent review, not human peer review or an official Tau Ceti endorsement.

I read `docs/lean/REVIEW.md`, the complete canonical README, complete Colbrook solution (Theorem and Sections 1–3), NUMERICAL_TARGETS, all Definitions/Challenge declarations, project README, manifest, Comparator configuration, diagnostic source and evidence. I compared actual expressions independently; neither the author's PASS nor another referee's verdict was treated as evidence of fidelity.

## Fidelity and nonvacuity

All n≥2 and arbitrary real SPD A,B are retained. Mathlib PosDef supplies real symmetry and strict positive definiteness; there is no commutativity, simple-spectrum or rank premise. The definition `jordan` is the actual Mathlib Kronecker sum A⊗B+B⊗A. Column-vectorization indexes coordinates by (column,row), and the actual commutation matrix exchanges that pair. Fin n×Fin n indexes all n² coordinates, not a restricted space. For symmetric A,B this convention gives the stated Jordan operator AXB+BXA.

The Rayleigh numerator is the Euclidean quadratic form and its denominator is the sum of all coordinate squares. Every use in the principal target excludes zero vectors. Sector sets contain exactly all Rayleigh values on the ±1 commutation eigenspaces. The separately advertised attainment export requires BOTH sets nonempty and bounded below, and gives nonzero attaining vectors. Thus the final real sInf comparison cannot be certified by an empty-set or unbounded-set fallback convention. The n≥2 hypothesis matches the canonical statement and makes the skew sector genuinely nontrivial.

The stronger PSD-minimizer export gives a real nonzero PSD eigenmatrix, positive eigenvalue, exact eigenvector identity, its Rayleigh value, and a lower bound against every nonzero vector in the full ambient space. Positivity preservation of the inverse, existence of a minimizer, and the desired comparison are not assumptions or opaque custom predicates. Vectorization and the original inequality are separate explicit proof obligations.

## Proof plan, reuse and attribution

The plan preserves Colbrook's mathematical argument. Replacing the inverse integral with a spectral Sylvester-positivity argument is sound: evaluate CZ+ZC≥0 on a negative eigenvector of Hermitian Z with C>0. This remains an obligation, not an imported premise. The real PSD/eigenmatrix bridge, factor-two identity in both sectors and genuine attainment all remain required.

Pinned Mathlib PosDef/Kronecker, spectrum and Rayleigh APIs are appropriate. No numerical interval subdivision is needed for this arbitrary-dimensional algebraic/spectral theorem. LeanCert will audit kernel trust. Mathematical authorship and original conjecture attribution are distinguished from Holden's AI-assisted formalization; no source-author endorsement is implied.

## Mechanical evidence inspected and independently replayed

Inspected `verification/statement-build.log`: successful 2646-job build, exactly four deliberate Challenge placeholders and none in Definitions. Independently reran `lake env lean Challenge.lean`; exit0 with exactly the same four warnings, recorded in `verification/statement-referee-2-replay.log`. These establish elaboration only, not the mathematics. Inspected official-v0.4 draft schema PASS and exact coordinate diagnostics; the latter are correctly labelled finite diagnostics, not universal proofs.

Comparator selects all four advertised declarations, has empty definition replacement list, and permits only propext, Classical.choice and Quot.sound. Dependency/toolchain pins are retained. All source/evidence hashes below were independently recomputed and matched the frozen receipt.

## Exact reviewed bytes (SHA-256)

- `NLA/SP05/Definitions.lean`: `ba3577bf57c54ecd6b47ea8c54a079312ae9598d87a2874c17c886f490d53cd9`
- `Challenge.lean`: `37168ebea59512d117c0b894d68d0007f85a320a071187a706edb7e01592bbc7`
- `NUMERICAL_TARGETS.md`: `9dcc357dbe3dc4d4a7531a8da20f47ec756defa8fe82bf921f6ec995460b7801`
- `README.md`: `1ab90d589d540c1ec8d87deacd8248182d47bb86783c6c6aae9691433a38fc7f`
- `formalization.yaml`: `481b156f4e0e2b52e311a543beee73da469f48f7f80c1468797f7840610315cc`
- `comparator.json`: `68045d524541982896ced9e8d40afca1f72cf3a76d5faf7682df92745f18d5f8`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `lakefile.toml`: `de030a6e1fa58a916e48b4bc65bd7503c1c7ecf991ae54b446f27837c67632c1`
- `lake-manifest.json`: `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08`
- `../README.md`: `fa620c21fbfda744d3e4689168cc9519bfbd5df9a61b9e7662d53133e6fd5056`
- `../solution.md`: `8a92479b0631d48ef15c2a435adf6cd3ae0ca4697d4be6a3696f3a386e61bf8a`
- `verification/statement-build.log`: `1d9d5165a9424cb19b300805dde096d9324d74504dfe4cc46c614d250b947856`
- `verification/metadata-draft.log`: `accdc62ab3cb40a81c5b7b7ea6e2c70a77878041c453b2afee0a95cb78c18035`
- `verification/check_coordinates.py`: `276bd0069ef3849ead09d84369ab65046054426f1303a28b34d947754211f388`
- `verification/coordinate-precheck.log`: `dc83ac773350d0ed4c93c7bb2e163faae1e5dcb1bf60d112bd6b2507d418bb5a`

Independent replay log: `b816a296177c2a14b72239b38f999e949ba2f0aa06859705c8c539fc98fb84d4`.

No requested statement changes. Full proof, fresh nonauthor final reviews, all-export trust audits and actual isolated Linux Comparator/default-kernel/rejection checks remain pending. If I subsequently help implement proofs, I will not count as an independent final proof referee.
