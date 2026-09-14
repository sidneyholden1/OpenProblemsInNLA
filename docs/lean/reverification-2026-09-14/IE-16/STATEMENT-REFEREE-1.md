# IE-16 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below.** No blocking fidelity or scope issue found.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not an implementer of this upstream proof. Date: 2026-09-14. Phase: new independent boundary review before this campaign's proof inspection, under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not an official Tau Ceti assessment or human peer review. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

I read the complete canonical page and full informal source identified below, the complete numerical boundary, Definitions and all 15 Challenge signatures. I independently compared the current three mathematical boundary files byte-for-byte with the immutable upstream commit: unchanged. Imported definitions/APIs were inspected where their semantics matter. I have not inspected the existing implementation modules for this campaign. This reviews an existing authored proof boundary; it does not pretend that the upstream proof has not yet been written. Historical statement-stage prose remains preserved as historical evidence.

## Fidelity, scope and proof obligations

The canonical target is the complete all-finite-complex-set/all-admissible-degree inequality with the actual constant 4/Real.pi. Finset cardinality supplies distinctness; `admissible` explicitly excludes zero. All complex polynomials are quantified, with natDegree <= k and evaluation at zero equal to one. Because the latter excludes the zero polynomial, the natural-degree convention does not change the source degree restriction. The unused L parameter in `feasible` imposes no extra restriction.

`maxModulus` is a genuine finite supremum of complex norms; `M` is the real sInf of all feasible objective values; `subsetFamily` includes every subset of cardinality k+1; and `subsetMax` is their finite supremum. Empty branches do not occur in the admissible witness: cardinality nine, degree four and actual five-subset membership are explicit obligations. Constant one supplies feasible values and norms are bounded below by zero. Fifteen contracts explicitly establish attainment at the full witness and EVERY five-subset, so the proposed minimax values cannot be an empty/unbounded-infimum convention. The positive subset maximum prevents invalid ratio division. The general interpretation as a minimum is the standard finite-dimensional evaluation problem; for this full negative resolution, the attained quantities needed for the counterexample are explicitly required.

The exact root coordinates, source cubic polynomial, nine-point image and full minimum 3003003000/1001003001001 match the complete informal manuscript. The lower cut 299/100000, subset upper cut 23/10000 and strict 13/10 > 4/pi yield the required original violation. No fixed-polynomial check or subset enumeration replaces the all-polynomial lower bound or all-subset upper bound. Actual interpolation APIs were inspected in pinned `LinearAlgebra/Lagrange.lean` (evaluation at nodes, degree bounds, uniqueness); these support a faithful economical implementation, whose bodies are not audited here. Source positive-weight orthogonality or its symmetry proof may establish the lower bound. The stronger unbounded-ratio/amplification theorem and asymptotics are explicitly excluded; the finite counterexample still resolves the entire original yes/no assertion. Holden retains mathematical proof/certificate credit and Stepaniants formalization credit.

## Mechanical evidence and limitations

I inspected the coordinator's fresh `challenge-local.log` and `challenge-local.json`, independently verified their digest correspondence, and observed successful exit 0 with exactly 15 intentional Challenge placeholder warnings. Log SHA-256: `2f2cf6b13b333762cf45c6e00a9da509b6226176b17c36fb728492cd33ced1ff`. This was Lean 4.33.1 on macOS aarch64 with the shared pinned dependency cache, not Linux Comparator execution; I did not rerun it. Typechecking establishes well-formed statement types, not these mathematical conclusions. The Comparator configuration names all 15 contracts, no definition holes, and only propext, Classical.choice and Quot.sound. No fresh proof acceptance or Linux run is claimed by this report. Existing upstream reviews and runs are preserved, not treated as substitutes for this campaign's separate proof and operational checks.

Only this new report was written. No existing mathematical source, historical report, manifest, canonical target, ID or path was changed. A second independent boundary approval remains a coordinator gate before proof inspection.

## Exact reviewed source hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `linear-systems-and-elimination/IE-16/README.md`: `203371c8dcf675a94ab5bd5d59f0f566725e6a7611f2ba525651222bb5875c59`
- `linear-systems-and-elimination/IE-16/solution.tex`: `194dcd089f8f5460812bf36a8eb76bccf1694075cf1982256494942b6c332a43`
- `linear-systems-and-elimination/IE-16/lean/NUMERICAL_TARGETS.md`: `0bea606a903e7956cac9765048db9881f07f29819f405269545f1da12ec6d682`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/Definitions.lean`: `e4681f2083d71d8980adcd70e7cf26367e0e84dbc1773f4d2f082bf2417c9507`
- `linear-systems-and-elimination/IE-16/lean/Challenge.lean`: `85cbe24c7657d9ddc37728db5bb1740a80ddab60e3eb4676e329df40a7b1737c`
- `linear-systems-and-elimination/IE-16/lean/comparator.json`: `963e1d217de9369cd5b4a3c282e983cb01986512d5221e18e1ea44d087fe7f09`
