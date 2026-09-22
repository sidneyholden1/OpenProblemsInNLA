# RA-08 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below.** No blocking fidelity or scope issue found.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not an implementer of this upstream proof. Date: 2026-09-14. Phase: new independent boundary review before this campaign's proof inspection, under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not an official Tau Ceti assessment or human peer review. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

I read the complete canonical page and full informal source identified below, the complete numerical boundary, Definitions and all 14 Challenge signatures. I independently compared the current three mathematical boundary files byte-for-byte with the immutable upstream commit: unchanged. Imported definitions/APIs were inspected where their semantics matter. I have not inspected the existing implementation modules for this campaign. This reviews an existing authored proof boundary; it does not pretend that the upstream proof has not yet been written. Historical statement-stage prose remains preserved as historical evidence.

## Fidelity, scope and proof obligations

The complete original implication retains all real symmetric PSD pairs A >= Ahat >= 0, every n >= 2 and 1 <= k < n, every epsilon >= 0, every continuous concave nondecreasing nonnegative half-line function, and every permitted ordered eigendecomposition of each matrix. `spectralNorm` explicitly uses the Euclidean continuous linear-map operator norm. The scoped matrix order is PSD, not entrywise. `AdmissibleFunction` has no f(0)=0, operator-monotonicity, smoothness or strict monotonicity assumption; arbitrary real extensions encode all half-line functions.

`OrderedSpectralData` carries a real orthogonal matrix, an antitone nonnegative family and actual matrix reconstruction. Existence for every PSD matrix and eigenvector/orthonormality semantics are separate contracts, avoiding a vacuous custom type. Both truncations use the SAME selected basis; discarded terms are zero even when f(0)>0, so function truncation is not f(X_k) or a separately rotated plateau. Repeated eigenspaces remain unrestricted. Zero-based i<k and tail index k correspond exactly to source indices. `functionalCalculus` is actual real CFC. I inspected its possible zero fallback and the pinned matrix Hermitian CFC API: matrix spectra are finite, making arbitrary f continuous on the spectrum; thus the general spectral contract without a global continuity premise is meaningful, not a loophole. Extension independence away from the nonnegative half-line is explicitly required.

The fourteen contracts establish the unchanged six-dimensional source witness, PSD order, actual fourth eigenvalue t=1/65536, exact input residual and both tails for EVERY permitted decomposition. The common-denominator F agrees with the source block projector, and the unnormalized vector (4,3,1,0,0,0) preserves the Rayleigh argument while avoiding a square root. The spectral-gap location is a theorem conclusion, not a premise. The degree-six polynomial minorant and named matrix polynomial are distinct from CFC; scalar domination on the proved spectrum and genuine CFC order must establish the bridge. No operator monotonicity of min(x,1) is assumed.

The rational positive gap and exact matrix-vector values are conclusions consumed by the Rayleigh comparison; the final counterexample at epsilon=0 and unconditional negation cover the original universal claim. The weaker positive gap suffices. The stronger contour ratio, Nyström sketch identity, nuclear-norm extensions, strictly increasing perturbations and probabilistic claims are outside the fourteen exports. None is required by the canonical target. This exact algebraic alternative is appropriately economical, with only a material scalar LeanCert sign intended. Colbrook retains source mathematical authorship and Stepaniants the existing formalization credit; any inherited coordinator contribution is historical, not attributed to this reviewer.

## Mechanical evidence and limitations

I inspected the coordinator's fresh `challenge-local.log` and `challenge-local.json`, independently verified their digest correspondence, and observed successful exit 0 with exactly 14 intentional Challenge placeholder warnings. Log SHA-256: `ff93cd00708928bea981bbee38ae8d4e474cbe3d524861f1c530061e368b593e`. This was Lean 4.33.1 on macOS aarch64 with the shared pinned dependency cache, not Linux Comparator execution; I did not rerun it. Typechecking establishes well-formed statement types, not these mathematical conclusions. The Comparator configuration names all 14 contracts, no definition holes, and only propext, Classical.choice and Quot.sound. No fresh proof acceptance or Linux run is claimed by this report. Existing upstream reviews and runs are preserved, not treated as substitutes for this campaign's separate proof and operational checks.

Only this new report was written. No existing mathematical source, historical report, manifest, canonical target, ID or path was changed. A second independent boundary approval remains a coordinator gate before proof inspection.

## Exact reviewed source hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `randomized-and-low-rank-approximation/RA-08/README.md`: `2f3af42c63b5726e4360b496ed13a077ff418d47e62962df4ede44b929a067d6`
- `references/colbrook-transfer-2026-09-11/manuscripts/03_concave_transfer_counterexamples.tex`: `6f52104ffcbc29ab7fa2de47537bfe2be7a2a3f56bf2e2c65d090036680cb0ed`
- `randomized-and-low-rank-approximation/RA-08/lean/NUMERICAL_TARGETS.md`: `a1fa22ee4cf7b3481795e68f9b04217b4da9761e3adb60c9cb3551ad2e4a1148`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Definitions.lean`: `8c2f3a76e44730b1f9d5bc8e896070c10868bae817d0c3d11ace22b3c7d94c41`
- `randomized-and-low-rank-approximation/RA-08/lean/Challenge.lean`: `6dfe1fe49431bd3f5dc4c91360911d02c6aaf73d902a40fcabec79155fb11c18`
- `randomized-and-low-rank-approximation/RA-08/lean/comparator.json`: `833d78dcda61a6d240fb1c50dd419ba7f95c3a8ddda768b7e1de6a0047359951`
