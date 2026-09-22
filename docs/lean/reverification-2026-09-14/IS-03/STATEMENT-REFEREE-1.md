# IS-03 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below.** No blocking fidelity or scope issue found.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not an implementer of this upstream proof. Date: 2026-09-14. Phase: new independent boundary review before this campaign's proof inspection, under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not an official Tau Ceti assessment or human peer review. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

I read the complete canonical page and full informal source identified below, the complete numerical boundary, Definitions and all 7 Challenge signatures. I independently compared the current three mathematical boundary files byte-for-byte with the immutable upstream commit: unchanged. Imported definitions/APIs were inspected where their semantics matter. I have not inspected the existing implementation modules for this campaign. This reviews an existing authored proof boundary; it does not pretend that the upstream proof has not yet been written. Historical statement-stage prose remains preserved as historical evidence.

## Fidelity, scope and proof obligations

The complete canonical conjecture is quantified over all n >= 5 and all real entrywise-nonnegative n-by-n matrices, requiring a nonnegative realization at exactly n-1. `RealMatrix`, `Matrix.charpoly`, polynomial derivative, reciprocal real scalar multiplication, powers and trace are actual operations. The explicit entrywise predicate cannot be confused with PSD order. Natural subtraction and reciprocal totalization are harmless under n >= 5. The unchanged 7-by-7 block-cycle matrix and all rational polynomial/moment constants match the complete source proof.

Seven contracts include actual characteristic-polynomial/derivative identities and monic degree six, nonnegative entries and trace for every natural power, and all seven power traces for EVERY real 6-by-6 matrix with the stated characteristic polynomial. No simple-spectrum, diagonalizability, root-ordering or companion-matrix-only premise is introduced. The numerical sign is only a conclusion; the universal trace bridge remains a proof obligation. `counterexample` uses the actual witness derivative, and the final export negates the entire conjecture. The seven trace values match the source, culminating in -8593/823543. A later spectral proof may derive separability/diagonalizability but must not assume it.

The generic zero-order and zero-power nonnegativity assertion is consistent (empty trace and identity). No hidden admissibility conclusion is bundled as an input. The plan wisely reduces the witness determinant by its 1+2+4 structure and reserves LeanCert for one consumed singleton negative sign. Actual trace/characteristic-polynomial semantics, not that sign alone, must close the proof. The source's stronger zero-padding exclusion, separate Monov consequence and minimality/priority questions are explicitly excluded without narrowing the exact-order original target. Colbrook retains mathematical credit and Stepaniants formalization credit.

## Mechanical evidence and limitations

I inspected the coordinator's fresh `challenge-local.log` and `challenge-local.json`, independently verified their digest correspondence, and observed successful exit 0 with exactly 7 intentional Challenge placeholder warnings. Log SHA-256: `b8aa1711082d76915054b2a237c7a555d2b52febbe317c045b96fbb6c188713f`. This was Lean 4.33.1 on macOS aarch64 with the shared pinned dependency cache, not Linux Comparator execution; I did not rerun it. Typechecking establishes well-formed statement types, not these mathematical conclusions. The Comparator configuration names all 7 contracts, no definition holes, and only propext, Classical.choice and Quot.sound. No fresh proof acceptance or Linux run is claimed by this report. Existing upstream reviews and runs are preserved, not treated as substitutes for this campaign's separate proof and operational checks.

Only this new report was written. No existing mathematical source, historical report, manifest, canonical target, ID or path was changed. A second independent boundary approval remains a coordinator gate before proof inspection.

## Exact reviewed source hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `eigenvalues-and-inverse-problems/IS-03/README.md`: `b993f8a77090f811ff68b06e1cad5da4b5fc979d9c482b1c82e25df7d84c65fe`
- `eigenvalues-and-inverse-problems/IS-03/solution.tex`: `564029a75736faf7a06d8f718e9f68773e97f250428435742aa15f2aeac208bb`
- `eigenvalues-and-inverse-problems/IS-03/lean/NUMERICAL_TARGETS.md`: `b1fe777e2d4853b4d60d75e4d0628939f19434434ca82ac4ffe2a3e5bdbf1787`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Definitions.lean`: `8b4b581e9831b0438d0635b013a60df0cf0139fa9087850b842d8e58975ea1a9`
- `eigenvalues-and-inverse-problems/IS-03/lean/Challenge.lean`: `4a8817f7c983819fac0a9206092831e72709fcfdb73b0687350914162ef23440`
- `eigenvalues-and-inverse-problems/IS-03/lean/comparator.json`: `f1e84761b1175d1d638b6cc26c2c2797c7da64ca7dd73919594437388484bf0a`
