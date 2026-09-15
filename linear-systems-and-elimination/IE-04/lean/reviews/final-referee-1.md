# IE-04 independent final formalization review

**Verdict: PASS — mathematical source review.** No blocking fidelity or proof defect found. This verdict does **not** certify completion of the separate mechanical gates.

**Reviewer:** OpenAI Codex, independent nonauthor AI referee, `/root` in this review session. I did not implement this project. This is automated-agent review, not external human peer review or official Tau Ceti endorsement.

**Scope:** All review angles in `docs/lean/REVIEW.md`: fidelity, correctness, quality, generality, reuse, API, documentation and attribution.

**Revision:** Checkout HEAD `1c6e774de0e6c303dc6ddb51d1e4a1add66374e2`, including uncommitted proof files. Approval attaches to the file hashes below, not HEAD alone. Evidence was inspected through approximately **2026-09-15 03:50 UTC**; build logs and metadata changed during review.

## 1. Target fidelity and all twelve exports

I read the complete canonical README, problem LaTeX, complete retained source manuscript, numerical plan, frozen definitions, Challenge, both statement reviews, and every project proof module transitively imported by Solution.

Read-only comparisons established:

- Canonical README and solution Markdown equal their retained source copies byte-for-byte.
- Definitions, Challenge, numerical plan and comparator configuration match their frozen hashes.
- All twelve Solution signatures match Challenge after whitespace normalization. This textual check is not a Comparator run.

| Export | Independent assessment |
|---|---|
| `gaussian_model` | Actual nested product of standard real Gaussian measures; probability normalization, joint independence of all \(n^2\) coordinates and correct marginals. |
| `growth_semantics` | Actual finite state-entry maximum, positive input denominator, legal-path existence, finite bounded growth set, attained supremum, growth at least one, unique first selector and strict-tail equivalence. |
| `gaussian_generic` | Nonsingularity and uniqueness of the complete legal schedule almost surely, for **every deterministic center and every positive noise level**. |
| `measurable_tail` | Actual measurable event, without a measurability assumption; includes arbitrary noise parameters and the auxiliary zero-dimensional case. |
| `exact_wilkinson` | Actual recursive states through stage \(n\), nonsingularity, unique no-swap legality, exact growth and both numerical identities/bounds. |
| `full_box_robustness` | Every real matrix in the entire closed \(n^2\)-entry box, for every \(n\ge2\); strict pivots, uniqueness, nonsingularity, state-error bounds and strict growth conclusion. |
| `gaussian_density_lower` | Actual Gaussian density on the entire interval \([-2,2]\). |
| `gaussian_box_lower` | Measurability and lower probability of the entire translated Gaussian box. |
| `gaussian_tail_lower` | Transfers that probability to the genuine strict GEPP tail event. |
| `asymptotic_escape` | Arbitrary positive real proposed constants; conclusion holds for every sufficiently large natural dimension. |
| `every_pair_violated` | Admissible identity center, noise one, unrestricted admissible threshold and strict violation. |
| `not_exponentialTailConjecture` | Negates the complete original quantified conjecture. |

`ExponentialTailConjecture` retains \(n\ge1\), arbitrary real centers with Euclidean operator norm at most one, \(0<\sigma\le1\), every real \(x\ge1\), and positive real \(c_1,c_2\). Identity-centered, unit-noise counterexamples suffice to negate this universal assertion. The manuscript’s additional zero-centered lower bound is not exported or advertised; this does not narrow the original conjecture negation.

## 2. Proof correctness and semantic risks

### Actual elimination, ties and denominators

`schurStep` correctly swaps the current and selected rows before forming the trailing Schur complement. Padding removes eliminated rows and columns. `pathGrowth` counts precisely states \(0,\ldots,n-1\), including input and final scalar.

`GEPPKernel.active_schur_iff` proves active-block injectivity in both directions using explicit lifted and supported vectors, with a nonzero pivot hypothesis. `GEPPPaths` derives legal paths from nonsingularity and derives nonsingularity from nonzero pivots. Neither direction assumes its conclusion.

Every largest-magnitude admissible pivot remains in `IsLegal`; the first-row convention is auxiliary. `Growth` proves the nonempty, attained supremum semantics rather than presupposing them.

I found no misuse of total division:

- Legal pivots are explicitly nonzero.
- The input maximum is proved positive before growth-ratio inequalities.
- The threshold cancellation proves the relevant real power nonzero.
- The perturbation multiplier estimate proves its denominator positive.

Dimension zero is explicitly handled in measurability and excluded from the original conjecture. Dimension one remains covered by the general semantic statements; the counterexample correctly begins at dimension two.

### Gaussian genericity

The substantial genericity bridge is present.

`RegularAt.rational_rep` preserves denominator guards through inversion by using numerator \(q^2\) and denominator \(pq\). It does not incorrectly discard the previous denominator condition.

`Realize` reverses Schur steps, including row swaps, with preceding pivots equal to one. `Generic` uses separate realizations for each pivot and squared-entry comparison. In particular, it avoids the invalid identity-matrix witness for off-diagonal comparisons that would both vanish.

Affine surjectivity transfers these witnesses to **any** deterministic center when \(\sigma\ne0\). Polynomial nullity is proved by finite-dimensional induction, finite univariate root sets and measurable Fubini arguments. Finite schedule/index quantification then supplies simultaneous null-tie conclusions. Finally, the flattening pushforward transfers the result to the frozen nested Gaussian law.

These witness conditions are discharged inside proofs; they are not hidden hypotheses imposed on random samples.

### Measurability and probability

`Measurability` proves measurability of total recursive entries, finite maxima, path growth and legality. On nonsingular inputs, the attained-maximum theorem identifies the tail with a finite union over legal schedules. Singularity exclusion is justified separately by Gaussian genericity.

`GaussianProduct.noiseBox_rectangle` identifies the exact full entrywise event. Two finite products supply \(n^2\) scalar factors. Scalar interval integration and the exact radius identity yield
\[
(\delta_n/16)^{n^2}=2^{-n^2(n^2+n+5)}.
\]
There is no sampled-box, vertex-only or lower-dimensional substitution.

Although `Measure.real` maps infinite measure to zero, the Gaussian probability instance establishes finiteness here. The measure-monotonicity bridge therefore has its required finite-measure justification.

### Robustness and asymptotics

The perturbation proof follows the manuscript’s scalar induction uniformly over all entries. Error propagation is needed through state \(n-1\); the final pivot’s positivity is established separately. The input bound \(9/8\) and final-entry lower bound give the required **strict** growth inequality.

The asymptotic argument uses Mathlib’s exponential-versus-arbitrary-real-power theorem. It establishes both threshold admissibility and strict exponent separation, then instantiates the complete conjecture at the identity center and noise one.

I found no circular argument, vacuous replacement predicate, hidden conjectural premise or narrower substitute.

## 3. Trust, numerical evidence and mechanical status

The active project sources contain no `sorry`, declared axiom, native decision proof, unsafe implementation or environment-modifying proof bypass. Challenge contains twelve intentional placeholders and is not imported by Solution.

The comparator lists exactly the twelve exports and permits only:

- `propext`
- `Classical.choice`
- `Quot.sound`

Its `definition_names` list is empty. My boundary-hash verification supplies independent source evidence; it does not replace the isolated Comparator gate.

I inspected the pinned LeanCert trust-classification implementation and checked-bound theorem. The retained numerical proof uses `verify_strict_lower_bound_dyadic_checked` for \(\exp(-2)>1/8\), with precision \(-53\), depth \(10\), and the constant expression evaluated on \([0,0]\). The printed Boolean proof is `of_decide_eq_true (id (Eq.refl true))`. Exact monotonicity extends this material point bound to the full density interval.

The retained dependency-path log connects that certificate to the internal final negation through density, interval probability, box probability and tail probability.

### Actual evidence inspected

- `local-solution-build.log` initially ended mid-build. On rereading, it contained **`Built Solution` and `Build completed successfully (8811 jobs)`**. Thus local full-build completion is now recorded.
- Solution contains twelve kernel-trust assertions, so this successful build is evidence that those assertions were accepted in that local run.
- `export-audit.log` still contained an earlier missing-`GaussianModel.olean` failure. I did **not** inspect a successful standalone twelve-export axiom-printout run.
- `solution-direct.log` records an earlier missing-`Measurability.olean` failure; `solution-direct2.log` is empty, which alone proves no exit status.
- Scalar, measurability and numerical-route logs report only the three foundational axioms for their audited declarations.
- I also inspected deterministic/generic, Gaussian-foundation, GEPP-kernel, path/growth, measurability and statement-build logs. The statement build explicitly contains twelve placeholder warnings.

**Receipt limitation:** The updated README references `verification/local-proof.json`; that file did not exist when checked. Retain the completed receipt and successful standalone export audit before relying on those documentation links. This is a mechanical-evidence/documentation follow-up, not a mathematical-source defect.

I ran only read-only inspection, hashing, equality and textual-signature checks. I did not run Lean, numerical tests, a clean rebuild, schema validation or Linux Comparator. No network action or source modification was performed.

## 4. Quality, reuse and attribution

The module decomposition exposes useful intermediate facts: active injectivity, legal-path existence, prefix congruence, finite-growth semantics, guarded rational expressions, reverse-Schur realization and polynomial nullity. The proofs generalize appropriately beyond the counterexample where useful.

I inspected relevant pinned Mathlib definitions and theorem implementations for Gaussian laws, Euclidean operator norm, product measures, independence, finite polynomial roots, Fubini, real-valued measure monotonicity and exponential asymptotics. Local searches did not identify a packaged multivariate polynomial-null theorem matching this development. This was a targeted reuse search, not an exhaustive library audit.

Broad `import Mathlib`, generic helper names and minor linter warnings are maintainability opportunities, not blockers. The scalar induction and single material numerical certificate are proportionate; no unnecessary finite sampling supports the universal claims.

Credits preserve George Stepaniants’s mathematical authorship, Spielman–Teng’s conjecture, Sidney Holden’s formalization credit and AI assistance. IE-05/KE-05 adaptation credits and Apache licensing are present. I did not independently authenticate the earlier projects’ claimed review histories.

The two statement reports contained no unresolved requested mathematical changes. Their substantial outstanding proof obligations are now addressed in the inspected implementation.

## 5. Exact SHA256 inventory

Paths below are relative to:

`/private/tmp/nla-lean-ie04/linear-systems-and-elimination/IE-04/lean`

### Every active project proof and frozen boundary

```text
NLA/IE04/Asymptotic.lean
c4e1856d4bdd07ab584f5aee0e19f5d740347fe6fb54d43251308f5859fab90f
NLA/IE04/Consequences.lean
10765d3ac57fb93f7c163ebf84886d20d5362208ca0cba0fb5f6d46d64178c27
NLA/IE04/Definitions.lean
c78a3813feb30befee926d4ad94aed7456567db670b4eede249516c06bbd4edf
NLA/IE04/GEPPKernel.lean
4e900c64677d5b9fd089d186a3b2f0b7435f2d6ec9077977b3087f18b541764b
NLA/IE04/GEPPPaths.lean
6e996581e2262fd2f5ce7b9efd876f3516cc8b4ab148a5583745d653fc1832b4
NLA/IE04/GaussianBounds.lean
b903ce44af7867a68a237179c01610882110900facde01e4a1864d90ad51b2d6
NLA/IE04/GaussianBox.lean
4bbcd4c7edd085fa70767e631856659050ac18b95e2175d14cc4d1eb1fc8c47a
NLA/IE04/GaussianModel.lean
d2016c8069cdf52c4c641bc3ad3b054d2da913dcfb2b40c534731fd995d3066c
NLA/IE04/GaussianProduct.lean
1cea4ddd8fafb69f16e2377697bab0a3abc1a4036d5f3e6a75b24f51537f87cd
NLA/IE04/Generic.lean
411c82b45cca66542eb267357d1b8ab543cd650a1a0eddf280002b73f1b300fa
NLA/IE04/GenericMeasure.lean
e471982c4b824e8c1250c06503b3db20e75bd032123db0569224ffec1ff57255
NLA/IE04/Growth.lean
5e76937f1e7a7d5e6d3c0fc17114fb47b83ce49fa65d284c43ac29ed99aed331
NLA/IE04/Measurability.lean
35ae0b00394840375e40e0b61524e15bc171fda1e3b46f044dc5636f291248a6
NLA/IE04/PolynomialNull.lean
8a71c18867fcb82d3c263f7ae1393c74e4aaf109232e0decc4215a0941bf33bd
NLA/IE04/Realize.lean
d5c2347429c0c1b8dcfd0abb1c39136ca4d05fc5e2800b01cdc729508356a199
NLA/IE04/Regular.lean
08881ad8784d496109a60c008405e38ce71a94881b7468e88e4c3642d6866b7e
NLA/IE04/Robustness.lean
df4eb6ce96cab595798554831bb910c6f611b9c84cd1a13c859bb326f9680495
NLA/IE04/Tail.lean
875411775832927c4077639deeb643a77c375745c0c9450febec34062185482f
NLA/IE04/Wilkinson.lean
c4f0bc17d8842a9a9f1c053010554d363ebd1b71149c53dda9e469cc43faef55
Solution.lean
93eec949348853dd7593512bd371c2586f4ba196c11f8413188b59d14c26c5ab
Challenge.lean
0e84dc20ac0311e4abb143735298439030a5b9573b90b084398dc67a5f3ed28f
NUMERICAL_TARGETS.md
9fc5e9071df313497a615f30f7946769e4160029e84c3005c7c892b1c9ab17b2
comparator.json
5f9886dda49574e09e13b5fa6f906ea20e55803b24233df0ae3892a52d6bf641
lakefile.toml
ae18ff82db90be3a41d1663bf5d50626cd1565a6c564847674e57dbbc19c1e48
lake-manifest.json
9492763774b7794de2b88d000461651ba152d0ac84d55996f33548f41ed40430
lean-toolchain
3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71
```

### Source, review and documentation boundaries

```text
../README.md = sources/README.md
f689c04a0dddf05075a7c1afa4861bb03513cdecbe8970ac64deaf5b893fe27c
../solution.md = sources/solution.md
5418bb8fa765313d2e4dcbd85a78558e244fc6207b165b511a2b03532f34199e
../problem.tex
06f4e51a63a43841cd41c80d99e75bfe71b7e47e540aada370a62fba2166f59a
README.md
31a2334068279fd34dab570346ba3ad0d7d3e246ee4958fc5a430eef92efa4f0
PROOF_NOTES.md
1e043f0e28d6362656c232aee04d19b1bcfd9d33c362a5880d014d4c4952464c
formalization.yaml
a9c38d16a9ca084bc8ae3663d12a12981ffb4762891b7b09cb089f9b81dd3313
SOURCE_PROVENANCE.json
a22bb1fec5a717a1bca13627ed967a677a1e584a7194db6d4c334910890750c3
LICENSE
cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30
reviews/statement-referee-1.md
35bd84399df52bf4518340f7ceed366173fbbc8d610f8a33ee44fe0eebadbc24
reviews/statement-referee-2.md
e485d42c095f93b75acc5b85b3accca9d6344ec280d5911762bab261a8f209af
verification/statement-freeze.json
3191be904fdac9e38e40eedda6f1327426e97d6fd7bc808246a9e8886bf8f66b
```

Repository-relative `docs/lean/REVIEW.md`:

```text
d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553
```

### Audit programs and principal retained evidence

```text
verification/ExportAudit.lean
55f9c4256f094b78d6f19b764e30aaf98b3358557b158cd7ee391a588c80c992
verification/MeasurabilityAudit.lean
5261e7978c142dfd1ca4fc61d3737618e12ed03fea92cf81bb879d303e20d10c
verification/ScalarProbabilityAudit.lean
9438f21df53e33982673646d6c347e3aa2dc9ff02a124046bbec363310ee2aa2
verification/numerical-route-audit.lean
77c8f12321295cdff27064cf61065926ba5c77fbb4a8a30421096f9a99d3a189
verification/numerical-boolean-audit.lean
fbad13e0ce45b966901d6b2e16b1cb5d6bbd441a01acd0cb56ed58f140297372
verification/local-solution-build.log
ad237311fd187455f38e8e3af1758777f6d2e55de34df7e51af78432a4e408d5
verification/export-audit.log
4e8b243b1fd4c0b699f064f2ffceeeb544a73c445eadbeda5beb11af1030d068
verification/solution-direct.log
752ed26621412fcbaf3a3eb9bcfd465cbcbfac8fbd4148f98da560e0c545fec2
verification/solution-direct2.log
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
verification/numerical-route-audit.log
dbabe3350444c71c9207af46490d6fe0e60c45768ddabcb1f1336147cbe6e680
verification/numerical-boolean-audit.log
2c8fbd2bb0fd3a88e09c6ef28901c9f210b24e80d2b7ea79f6e76fa9c1ba3045
verification/scalar-probability-axioms.log
e9f1098c2000074b1edef471ebc3e9072ab696243d34b69f826c251c0e3b9641
verification/measurability-audit.log
472f4a03ccd94d2564e1f371ed54e564de1f4380ae1b0bbfa85c34181244d85c
```

### Pinned library files inspected

Local Git HEADs matched the manifest pins; tracked-file status was clean:

- Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474`
- LeanCert: `621a43d7cf21f87872392a01e874f2f1dbddc926`

The following files were inspected at relevant definitions and proofs, not exhaustively reviewed in full. Paths are relative to `.lake/packages/`.

```text
mathlib/Mathlib/Probability/Distributions/Gaussian/Real.lean
f86827f9c60d435c5dfeffee1ac6d95f5a953c98703bdc1c653a368c23a2365b
mathlib/Mathlib/Analysis/CStarAlgebra/Matrix.lean
79518c9e51c4d0cf4083ab69a9ac7a2817305b48db1fe6f25ae1d678e12ce223
mathlib/Mathlib/MeasureTheory/Constructions/Pi.lean
8751b21ac855f1a7b7c63258e8325f75b6fc236d360758b822ddf54597b118bf
mathlib/Mathlib/Probability/Independence/Basic.lean
85c6c98a306c1b10952181fcb9cc777c0ed06e91246428690a88d7821d24f9d2
mathlib/Mathlib/Analysis/SpecialFunctions/Pow/Asymptotics.lean
004e4d6013b20f95feedfcb23b257c07eb1ee4c7645b9d81fd6e4cb684a116d6
mathlib/Mathlib/Algebra/Polynomial/Roots.lean
162d86710afc10cc3ed158236994ed020e589f7fa15d5b39a30bd3e1f153080c
mathlib/Mathlib/MeasureTheory/Measure/Real.lean
7d06d0c77149faa765d606313411b90123606131e436acdaa4eeed1cdc9ebb59
mathlib/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean
d12213c6a6b65c3c7f8086d2cde7e1d287696a0992954b02dc00650c25c5fff1
mathlib/Mathlib/MeasureTheory/Measure/Prod.lean
739ba1838b5b67c1ff5d3b43ed263c2ad34f91e01e7a8946a6f529922d463e79
leancert/LeanCert/Tactic/Verification.lean
2c576708b528acdde17796b0b715b83079f9cad377182dbd87c248323ff0a58c
leancert/LeanCert/Validity/DyadicBounds.lean
6f1cdbc11f32e425ef5e9f4a22966d64ff0d11614ec9453ed7dde498e31a7c47
```

## Final disposition

**PASS for the inspected formalization sources and complete original target.** No mathematical revision is requested. Successful standalone export-audit receipts, the isolated Linux Comparator and the required additional independent final review remain separate completion requirements.