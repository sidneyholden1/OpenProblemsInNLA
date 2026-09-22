# IE-04 independent statement referee 1

**APPROVE / PASS, statements only, for the exact bytes recorded below.** Reviewer: `/root/iv06_statement_referee_1`, an independent AI agent who did not author this boundary. This applies the repository's Tau Ceti-inspired fidelity, correctness, scope, API/reuse, proof-quality and attribution checks. It is not a mathematical proof, external human peer review or Tau Ceti endorsement.

I read the full canonical README and complete informal solution, all definitions and twelve Challenge declarations, numerical plan, draft README/metadata/comparator, source provenance, precheck script/results and successful/initial statement-build records. I independently verified the source copies against Git blobs at preserved commit `deb549fa9ddd6b119e6c59016f268237e645dfa2`. No proof implementation exists or was inspected. Mathematical credit correctly belongs to George Stepaniants (Caltech), the original conjecture to Spielman–Teng, and formalization preparation to Sidney Holden with Codex assistance.

## Full target and semantics

1. `ExponentialTailConjecture` retains one existential positive real pair c₁,c₂ and all dimensions n≥1, arbitrary real deterministic centers with actual Euclidean operator norm at most one, all 0<σ≤1, and unrestricted real x≥1. Its threshold and upper bound use actual real powers. The identity-center/σ=1 counterexamples are admissible instances of that full assertion; the unused additional source result at center zero is explicitly excluded from advertised scope.
2. `entryMax` is the genuine finite maximum of absolute entries using nonnegative real norms. `pathGrowth` counts all n actual active states, from input through final scalar; it divides by the actual input maximum. The zero padding discards only eliminated rows/columns and preserves the maximum of each active matrix. This matches the canonical growth factor; stored elimination multipliers are not incorrectly counted as active entries.
3. `schurStep` performs the actual current-row swap followed by the trailing Schur complement. For a surviving row, it uses the swapped row in both numerator entries and the selected pivot row in denominator/update row. There are no column swaps. `states` recursively applies these operations for every finite schedule. The final state n is zero and the exact-W export correctly includes that boundary, while growth uses only 0,...,n−1.
4. `IsLegal` includes every largest-absolute active-column pivot, including ties, and requires nonzero pivots. `IsFirstLegal` selects the first current row only as an auxiliary convention. The main `growthValues`/`ppGrowth` retain all legal schedules. The `growth_semantics` export requires positive denominator, existence, finiteness, boundedness, attained actual sSup, growth≥1, unique first selector and strict-tail equivalence. These are conclusions, not assumptions that could conceal a surrogate recurrence.
5. `gaussianMatrix` is the nested finite Pi measure of standard real Gaussian laws on all n² entries. The explicit measurable-space instance is the usual coordinate Pi measurable space. The exported model requires total probability one, full joint independence and every N(0,1) marginal. The second Gaussian parameter is variance; multiplying entries by σ consequently gives variance σ². This is the source's real noise model.
6. `tailEvent` uses strict threshold exceedance and explicitly excludes singular perturbed matrices. `gaussian_generic` must prove almost-sure nonsingularity and a unique whole legal schedule for every center and every σ>0. Thus neither the singular extension convention nor all-tie supremum changes the original probability. `measurable_tail` is an unconditional Borel-event obligation, including arbitrary σ and threshold; no measurability hypothesis is assumed. `Measure.real` is the finite real measure value here, with finiteness supported by actual Gaussian probability normalization.
7. `exact_wilkinson` uses precisely the source's Wₙ and the actual recursive states, proving uniqueness/no-swap behavior and true growth (3/2)^(n−1). `full_box_robustness` quantifies over every entry of every real matrix in the entire closed n²-dimensional box for each n≥2. It concludes nonsingularity, all-path uniqueness, strict active pivots, actual state-error bounds and strict growth greater than half the reference growth. No normalized-coordinate or sampled-box replacement occurs.
8. Constants Bₙ=2^(n+2), δₙ=2^(−n²−n−1), Kₙ=n²(n²+n+5) exactly reproduce the source. The Gaussian density bound covers the whole closed interval [−2,2]; probability and tail lower bounds are on the genuine noise box/event. The finite-product box lower bound has exponent n², not n. The strict robustness conclusion aligns correctly with the strict tail event.
9. `asymptotic_escape` retains arbitrary positive real exponents/constants and eventual validity for every sufficiently large natural n. `every_pair_violated` supplies spectral norm one, n≥2, admissible x≥1 and a strict probability violation at the actual original threshold. The final negation follows without assuming any bound on x or replacing probability by finite samples.

The twelve exports cover the full original negative answer. Generic Gaussian uniqueness, nonempty/attained supremum semantics and probability measurability add explicit obligations that are mathematically appropriate; they do not weaken the claim. Degenerate n=0 is harmless in the unconditional model/measurability statements and is excluded from the conjecture; n=1 remains covered by the universal statement and general growth semantics. The adverse construction correctly starts at n≥2.

## Actual library, reuse and numerical checks

I inspected pinned Mathlib's actual `gaussianPDFReal` and `gaussianReal`: the former is exp(−(x−μ)²/(2v))/sqrt(2πv), the latter is volume with that density for v≠0, with an actual probability-measure instance. I read finite `Measure.pi` and its rectangle-product theorem, `iIndepFun`'s generated-measurable-space independence, `Measure.real`'s definition, and `Matrix.toEuclideanCLM` as the orthonormal-basis identification with continuous endomorphisms of Euclidean space. Thus the center norm is the requested ℓ² operator norm, not a default matrix norm. I compared the actual IE-05 row-swap/max definitions used as a design example; the attribution and absence of an imported NLA theorem are accurate.

I independently reran the author's exact precheck and obtained byte-equivalent JSON data. Separately, my rational script checks actual row-swap versus the encoded Schur formula at every active k,r for dense 3×3 and 4×4 examples, 28 exact structured perturbations in dimensions 2,...,8 with strict pivots/state error/growth checks, and the scalar radius/amplification/probability-exponent identities. It checks the induction endpoint ratios 5/7<1 and (3/2)/(7/8)<2. These are diagnostics only: neither finite perturbations nor vertices establish a nonlinear whole-box theorem, Gaussian probability or all-real-exponent asymptotics.

The author's local macOS-aarch64 Lean 4.33.1 Challenge build reports exit 0, 3106 jobs and exactly twelve intentional placeholders. I inspected the log and independently verified all recorded statement/source/build hashes; I did not execute that build myself or regard the placeholders as proofs. The initial missing explicit norm parameters/measurable-space instance failure is retained and the final definitions resolve it with the ordinary intended structures.

## Verdict, optimization and limits

No blocking quantifier, norm, probability, pivot, index, denominator, scope, vacuity or attribution mismatch was found. **Approve these exact statements for freeze and subsequent proof work.** Draft metadata is appropriately explicit that no formal verification is complete.

The scalar perturbation induction and material Gaussian point margin are sensible computation reductions; no vertex enumeration or wide interval subdivision should replace them. Significant formal infrastructure is still required: general legal-path existence, determinant propagation, all-path Borel measurability, Gaussian null ties/nonsingularity, full-box induction and arbitrary-real-exponent asymptotics. Approval does not assert these can be completed cheaply or on a particular time budget. No current proof, code-review, axiom audit or Linux Comparator success is claimed. Those remain separate gates.

## Exact hashes

- `NLA/IE04/Definitions.lean`: `c78a3813feb30befee926d4ad94aed7456567db670b4eede249516c06bbd4edf`
- `Challenge.lean`: `0e84dc20ac0311e4abb143735298439030a5b9573b90b084398dc67a5f3ed28f`
- `NUMERICAL_TARGETS.md`: `9fc5e9071df313497a615f30f7946769e4160029e84c3005c7c892b1c9ab17b2`
- `README.md`: `efb6024a676be9a08e1eb333110f0c6af03616558d40cab8e9788b82cecd0ad8`
- `formalization.yaml`: `c719e7dc1aa04d67d5c57f0d59392e70d7e6e0c53eabcb45f95d5fc99b486fcc`
- `comparator.json`: `5f9886dda49574e09e13b5fa6f906ea20e55803b24233df0ae3892a52d6bf641`
- `lakefile.toml`: `42c64a00a316fe47ed4ac3f60a87c141862e05058d4079df358b47d0134a0322`
- `lake-manifest.json`: `9492763774b7794de2b88d000461651ba152d0ac84d55996f33548f41ed40430`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `LICENSE`: `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`
- `SOURCE_PROVENANCE.json`: `a22bb1fec5a717a1bca13627ed967a677a1e584a7194db6d4c334910890750c3`
- `sources/README.md`: `f689c04a0dddf05075a7c1afa4861bb03513cdecbe8970ac64deaf5b893fe27c`
- `sources/solution.md`: `5418bb8fa765313d2e4dcbd85a78558e244fc6207b165b511a2b03532f34199e`
- `verification/exact-precheck.py`: `3d5a48ff88b1372e164d7be9e731c6a0aea452afff3c0c87e4d1370ad6486830`
- `verification/exact-precheck.json`: `512ae9d1651bac5d09bbb10f900c9c462b8e830848cfdc5ba75cbbe65563d6e4`
- `verification/statement-build.log`: `0c546573a6ceadbb1cd7b45b65e158807472d6dd7be478919a36f5bbae1d5b2e`
- `verification/statement-build-initial.log`: `334b8ca5efde80db4a5d5bbf73b4aaf2d64d9fc9349e1585cd8296369fbf3338`
- `verification/statement-build.json`: `1b97fa725b8748542974edd5ca86276d9e4570e3d412275ead2994702619eb31`
- `Mathlib/Probability/Distributions/Gaussian/Real.lean`: `f86827f9c60d435c5dfeffee1ac6d95f5a953c98703bdc1c653a368c23a2365b`
- `Mathlib/Probability/Independence/Basic.lean`: `85c6c98a306c1b10952181fcb9cc777c0ed06e91246428690a88d7821d24f9d2`
- `Mathlib/MeasureTheory/Constructions/Pi.lean`: `8751b21ac855f1a7b7c63258e8325f75b6fc236d360758b822ddf54597b118bf`
- `Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean`: `d12213c6a6b65c3c7f8086d2cde7e1d287696a0992954b02dc00650c25c5fff1`
- `Mathlib/Analysis/CStarAlgebra/Matrix.lean`: `79518c9e51c4d0cf4083ab69a9ac7a2817305b48db1fe6f25ae1d678e12ce223`
- `/private/tmp/nla-lean-ie05/linear-systems-and-elimination/IE-05/lean/NLA/IE05/Definitions.lean`: `39e5c319afb8d8b18b4c60518a3be0f79381416b2e5340b18cf3485a7b0528e6`
- `reviews/statement-referee-1-check.py`: `6712d14d509afd03ba383d5f91fe85039e84a66a94e6a2110011e1cfb8480df0`
- `reviews/statement-referee-1-check.log`: `e841ad64e3f3c4a816e73d8b45fb54a7bb4fcc5906b71864d6eddf194c10daa1`
- `reviews/statement-referee-1-evidence.json`: `b17ea6559c7ccdf2bb2e435079c859d61b07fdaf71d36fd8eb6ae2ad6198f2eb`
