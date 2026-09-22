# SP-06 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below.** No blocking fidelity or scope issue found.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not an implementer of this upstream proof. Date: 2026-09-14. Phase: new independent boundary review before this campaign's proof inspection, under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not an official Tau Ceti assessment or human peer review. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

I read the complete canonical page and full informal source identified below, the complete numerical boundary, Definitions and all 20 Challenge signatures. I independently compared the current three mathematical boundary files byte-for-byte with the immutable upstream commit: unchanged. Imported definitions/APIs were inspected where their semantics matter. I have not inspected the existing implementation modules for this campaign. This reviews an existing authored proof boundary; it does not pretend that the upstream proof has not yet been written. Historical statement-stage prose remains preserved as historical evidence.

## Fidelity, scope and proof obligations

The complete original implication quantifies over all finitely supported complex Laurent coefficients, admissible positive lower/upper bandwidths with nonzero extreme coefficients, and every positive finite section size. Finsupp plus the explicit outside-band zero property is equivalent to the finite Laurent sum; integer powers give genuine negative exponents away from zero. Toeplitz entries use integer i-j; zero-based indices preserve the source convention. Real spectrum is expressed by imaginary part zero for every member of the actual complex matrix spectrum.

`Circle` was checked in pinned Mathlib: it is the unit sphere in C with its inherited topology. `hasRealJordanCurve` requires an actual continuous injective map from this entire circle, nonzero at every point and real symbol at every image point. It does not merely assert samples, a possibly empty set, or assumed existence/continuity of a radius. The twenty contracts expose unique root existence for every c in [-1,1], endpoint signs on the whole interval, uniform slope, Lipschitz dependence, and existence of a continuous radius before constructing the real Jordan curve.

The witness coefficients (-64,8,-128,-8,-63,-16,-1) on exponents -2 through 4, auxiliary 8/z+8z+z^2 and exact composition a-a^2 agree with the complete source. The endpoint -23/32 and positive upper endpoint, root interval (1/2,2), slope 1/4 and Lipschitz bound 8 are appropriately uniform. Positive radial scaling supports injectivity and excludes zero. The imaginary-part identity is an all-circle assertion. The true 2-by-2 section is [[-128,8],[-8,-128]], and actual spectral membership of -128+8i with imaginary part 8 suffices to disprove the all-section conclusion. Exact spectrum equality is unnecessary and not advertised. The final export unconditionally negates the original implication.

The canonical target only requires avoidance of zero, so the source's additional enclosure/star-shaped-region assertion may be excluded; the limiting-spectrum question is separately excluded. Replacing the trigonometric parameterization and implicit-function argument by actual Circle coordinates, IVT and a Lipschitz estimate is a faithful computation reduction. Later proof review must verify these bridges and any material LeanCert certificate. Colbrook retains mathematical credit, Stepaniants formalization credit, and the original source/conjecture attribution remains intact.

## Mechanical evidence and limitations

I inspected the coordinator's fresh `challenge-local.log` and `challenge-local.json`, independently verified their digest correspondence, and observed successful exit 0 with exactly 20 intentional Challenge placeholder warnings. Log SHA-256: `7d44fa04512805619e4b6b7d76f3f3cc3a05039764e1892e498be36969ab626c`. This was Lean 4.33.1 on macOS aarch64 with the shared pinned dependency cache, not Linux Comparator execution; I did not rerun it. Typechecking establishes well-formed statement types, not these mathematical conclusions. The Comparator configuration names all 20 contracts, no definition holes, and only propext, Classical.choice and Quot.sound. No fresh proof acceptance or Linux run is claimed by this report. Existing upstream reviews and runs are preserved, not treated as substitutes for this campaign's separate proof and operational checks.

Only this new report was written. No existing mathematical source, historical report, manifest, canonical target, ID or path was changed. A second independent boundary approval remains a coordinator gate before proof inspection.

## Exact reviewed source hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `eigenvalues-and-inverse-problems/SP-06/README.md`: `192cf2a4e40cc05b579248a5e9693d48f6727fedb054d98eafc8af97274b5077`
- `eigenvalues-and-inverse-problems/SP-06/solution.md`: `c7adb8f97238049b20e82044d8527b70301779ba041169f74fe603a88ea1ae7a`
- `eigenvalues-and-inverse-problems/SP-06/lean/NUMERICAL_TARGETS.md`: `bfd2a0bcc5c5328ac9f3fd85d56ac7d3b8a5d551236cee68e227cb9acbea1959`
- `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Definitions.lean`: `5f3e071b9aabbbda27a794f9396022e54585f5d2d254827e50ea90baf80e72b1`
- `eigenvalues-and-inverse-problems/SP-06/lean/Challenge.lean`: `cd75a8f37a174d7dfb68927f7e6aeb23cf0982eb3161d7d9e5a63a7583d73bef`
- `eigenvalues-and-inverse-problems/SP-06/lean/comparator.json`: `5d19e5fe9d3ac4a69d07a1b14d40e31784a295e7fe8c6925964bfffe97203bb9`
