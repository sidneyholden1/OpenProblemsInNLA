# IE-04 independent final formalization review

**Verdict: PASS — mathematical fidelity and proof-source review.** Mechanical acceptance remains a separate gate.

**Reviewer:** OpenAI Codex, independent AI reviewer `/root` in this review session. I did not implement this project. This is automated-agent review, not external human peer review or official Tau Ceti endorsement.

**Reviewed checkout:** `/private/tmp/nla-lean-ie04`  
**Observed HEAD:** `1c6e774de0e6c303dc6ddb51d1e4a1add66374e2`

The implementation was untracked at inspection, so this approval attaches to the file hashes below, not HEAD alone. I performed read-only local inspection, source-signature comparisons and hashing. I did not run Lean builds, tests, Comparator, network actions, or modify source.

## Scope and conclusion

I read the complete canonical target, complete retained manuscript, frozen definitions and Challenge, numerical plan, both statement reviews, proof notes, **all 19 project modules transitively imported by Solution**, Solution itself, comparator configuration, dependency pins, and the retained evidence identified below.

I found no mathematical scope reduction, circularity, hidden premise, invalid use of total division, zero-dimensional defect, or proof bypass in the inspected project sources. All twelve exports preserve their Challenge signatures: an independent whitespace-normalized source comparison found twelve matching declarations. Definitions, Challenge and numerical-plan hashes match the statement freeze. The retained canonical README and manuscript copies are byte-identical to their current canonical counterparts.

### Full original target

`ExponentialTailConjecture` retains:

- One universally applicable pair of positive **real** constants.
- Every dimension \(n\ge1\).
- Every deterministic real center with Euclidean operator norm at most one.
- Every \(0<\sigma\le1\).
- Every real \(x\ge1\), without an upper restriction.
- The original strict growth event and real-power threshold and upper bound.

The final proof specializes this complete assertion to center \(I_n\), noise level \(1\), and an eventually admissible threshold. That specialization correctly disproves the entire universal assertion. It does not need counterexamples at every center or noise level. The semantic genericity bridge does cover **every center and every positive noise level**.

The manuscript’s additional zero-centered lower bound is not exported; this omission is explicitly disclosed and does not narrow the original conjecture negation.

## Findings on all twelve exports

| Export | Independent source assessment |
|---|---|
| `gaussian_model` | The measure is the full nested finite product of `gaussianReal 0 1`. Coordinate pushforwards and the flattening identity establish all standard-normal marginals and joint independence across all \(n^2\) entries. |
| `growth_semantics` | Legal schedules exist by active-block injectivity and finite pivot maximization. Growth values are finite, nonempty, bounded and attain their supremum. The positive input denominator and strict-tail equivalence are proved. |
| `gaussian_generic` | Reverse-Schur witnesses establish nontrivial pivot and squared-entry comparison expressions. Polynomial null sets, finite intersections and affine surjectivity give nonsingularity and unique legal schedules for arbitrary centers and \(\sigma>0\). |
| `measurable_tail` | Actual recursive entries, finite maxima, total division and legality predicates are measurable. The attained-growth theorem converts the nonsingular tail into a finite union over schedules. Dimension zero is handled explicitly. |
| `exact_wilkinson` | Actual recursive states equal the reference states through stage \(n\). The proof establishes nonsingularity, unique no-swap legality, input maximum one, exact growth, radius identity and cost bound. |
| `full_box_robustness` | The induction applies to every real matrix in the entire closed entrywise box. It proves recursive error bounds, positive pivots, strict dominance, uniqueness, nonsingularity and strict growth above half the reference value. |
| `gaussian_density_lower` | A retained point certificate proves \(\exp(-2)>1/8\). Exact monotonicity and \(\sqrt{2\pi}<3\) extend this to the whole closed interval \([-2,2]\). |
| `gaussian_box_lower` | The noise event is exactly the translated nested rectangle. Density integration supplies each interval probability; two finite products give the full \(n^2\)-coordinate bound and the exact exponent. |
| `gaussian_tail_lower` | Full-box robustness supplies event inclusion, including nonsingularity and strict exceedance. Finite-measure monotonicity transfers the lower bound to the actual tail probability. |
| `asymptotic_escape` | Pinned Mathlib’s exponential-versus-real-power asymptotic theorem gives eventual escape for arbitrary positive real constants, with explicit admissibility and strict cost domination. |
| `every_pair_violated` | Identity-center norm one and threshold cancellation use positive-dimensional hypotheses. The probability violation is strict at the original threshold. |
| `not_exponentialTailConjecture` | Directly contradicts the fully quantified assertion using the preceding admissible instance. No narrower auxiliary conjecture replaces the target. |

## Correctness and edge-case inspection

### Actual elimination and ties

`schurStep` swaps the current row with the selected active row and computes the trailing Schur complement. Its update uses the swapped surviving row and the selected pivot row consistently. Zero padding removes eliminated entries; the growth numerator includes states \(0,\ldots,n-1\), including the input and final scalar.

`IsLegal` retains every largest-magnitude active-column choice. The auxiliary first-row selector does not constrain `growthValues`. Prefix-state equality supports both first-selector uniqueness and strict-path uniqueness.

`active_schur_iff` explicitly requires a nonzero pivot. Supported-vector lifting and elimination prove the active-injectivity equivalence; descending induction from the empty active block establishes nonsingularity from nonzero pivots. This avoids assuming invertibility as part of the desired box conclusion.

### Total inverses and null sets

`RegularAt.rational_rep` handles inversion with numerator \(q^2\) and denominator \(pq\). Crucially, the new denominator retains the old denominator guard. It therefore does not incorrectly identify totalized rational expressions at excluded poles.

The pivot and tie witnesses are constructed separately. In particular, the tie argument does not use an identity witness where both compared entries could vanish. Previous pivots are realized as one; the current comparison has a nonzero squared difference. Affine surjectivity then supplies witnesses for every center and nonzero noise scale.

Polynomial nullity is proved by finite-dimensional induction, univariate finite root sets and Fubini. No probabilistic genericity hypothesis is assumed.

### Dimensions, denominators and measure

Positive-dimensional nonsingular matrices have a positive input entry maximum. Identity norm and threshold cancellation also carry the necessary dimension hypotheses.

For dimension zero, the auxiliary measurable-tail theorem explicitly proves growth zero; the empty determinant convention is consistent. The original conjecture starts at dimension one, and the adverse construction starts at dimension two.

The Gaussian law is normalized and finite. `Measure.real` therefore represents actual probability without an infinity-to-zero defect. The singular-input exclusion is justified by the separately proved almost-sure theorem. Measurability is established, rather than supplied as an assumption.

## Proof quality, reuse, API and attribution

The proof decomposition is coherent: elimination semantics, finite growth, reference states, perturbation induction, genericity, measure, and asymptotics have distinct responsibilities. The scalar robustness argument avoids finite sampling or vertex enumeration. The numerical certificate is small and materially used.

I inspected relevant local pinned Mathlib declarations for Gaussian density and normalization, atomlessness, finite product measures, joint independence, Euclidean matrix operators, finite-supremum measurability and real-power asymptotics. Their use matches their actual signatures and semantics.

The custom supported-vector and reverse-Schur infrastructure serves genuine missing bridges. The polynomial-null theorem is appropriately more general than the Gaussian application. A focused search under Mathlib’s measure-theory sources found no `MvPolynomial` occurrence; this is a limited reuse search, not an exhaustive claim that no alternative library proof exists.

Minor, nonblocking observations:

- Several modules use broad `import Mathlib`; narrower imports could improve dependency clarity.
- Some helper lemmas are more general than their exported contracts, leaving unused hypotheses. This strengthens the result and is harmless.
- The local finite-supremum measurability helper overlaps conceptually with Mathlib’s `Finset.measurable_sup'`, but handles the empty case directly.
- Existing style warnings concern simplification and local-instance syntax, not mathematical failures.

Credits preserve George Stepaniants’s mathematical authorship, Spielman–Teng’s conjecture, Sidney Holden’s formalization credit and AI assistance. IE-05 and KE-05 adaptations are disclosed. I did not independently compare those external worktrees’ implementations or verify author endorsement.

## Trust and retained mechanical evidence

The project proof sources contain no `sorry`, declared custom axioms, `native_decide`, unsafe implementation replacement, or custom proof-producing elaborator. Challenge contains its twelve deliberate placeholders and is not imported by Solution’s project dependency graph.

The comparator configuration names all twelve exports and permits only:

```text
propext
Classical.choice
Quot.sound
```

I inspected LeanCert’s actual trust classifier and kernel certificate closure. Kernel classification rejects sorry, custom axioms and native-compiler trust. The retained numerical proof uses the checked dyadic lower-bound theorem, with Boolean evidence printed as:

```lean
of_decide_eq_true (id (Eq.refl true))
```

The numerical dependency audit records the material chain from the final negation through the actual box probability to `exp_neg_two_lower`; the project source independently exhibits that chain.

### Actual logs inspected

- `local-solution-build.log` ends with **“Build completed successfully (8811 jobs)”**, including `Built Solution`.
- `export-audit.log` records an earlier failure because `GaussianModel.olean` was missing.
- `export-audit2.log` subsequently prints all twelve exported types and lists only the three permitted axioms for each.
- `measurability-audit.log` records the permitted axioms for actual tail measurability.
- `scalar-probability-axioms.log` records polynomial-nullity, density and asymptotic axiom results and prints the numerical proof.
- `numerical-route-audit.log` records the retained dependency path and final-negation axioms.
- `numerical-boolean-audit.log` prints the certificate’s Boolean proof.
- I also inspected `solution-direct2.log`, the statement-freeze and actual-project statement-build records, and the retained helper-status JSON records.

**The retained local full build is complete according to its inspected log.** I did not execute it or independently establish a clean rebuild from these source bytes. Some earlier helper records still say that full Solution is pending; the later full-build log supersedes that historical status.

The updated README references `verification/local-proof.json`, which was **absent at my final inspection**. Correct that evidence link or retain the promised receipt. This is a documentation/evidence-packaging issue, not a mathematical blocker.

No isolated Linux Comparator success was inspected or is claimed. The coordinator must independently rerun the mechanical gates and bind their receipts to the final source hashes. This report supplies one independent final review, not the two required by repository policy.

## Exact SHA256 manifest

Paths below are relative to `linear-systems-and-elimination/IE-04/lean/`, except where stated. Library files were inspected in relevant excerpts, not exhaustively.

### Every active project proof and boundary file

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
comparator.json
5f9886dda49574e09e13b5fa6f906ea20e55803b24233df0ae3892a52d6bf641
lakefile.toml
ae18ff82db90be3a41d1663bf5d50626cd1565a6c564847674e57dbbc19c1e48
lake-manifest.json
9492763774b7794de2b88d000461651ba152d0ac84d55996f33548f41ed40430
lean-toolchain
3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71
NUMERICAL_TARGETS.md
9fc5e9071df313497a615f30f7946769e4160029e84c3005c7c892b1c9ab17b2
PROOF_NOTES.md
1e043f0e28d6362656c232aee04d19b1bcfd9d33c362a5880d014d4c4952464c
README.md
31a2334068279fd34dab570346ba3ad0d7d3e246ee4958fc5a430eef92efa4f0
formalization.yaml
a9c38d16a9ca084bc8ae3663d12a12981ffb4762891b7b09cb089f9b81dd3313
SOURCE_PROVENANCE.json
a22bb1fec5a717a1bca13627ed967a677a1e584a7194db6d4c334910890750c3
LICENSE
cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30
```

README and metadata were updated during the review; I reread their final bytes identified above.

### Canonical sources and review boundary

```text
Repository-relative docs/lean/REVIEW.md
d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553
../README.md and sources/README.md
f689c04a0dddf05075a7c1afa4861bb03513cdecbe8970ac64deaf5b893fe27c
../problem.tex
06f4e51a63a43841cd41c80d99e75bfe71b7e47e540aada370a62fba2166f59a
../solution.md and sources/solution.md
5418bb8fa765313d2e4dcbd85a78558e244fc6207b165b511a2b03532f34199e
reviews/statement-referee-1.md
35bd84399df52bf4518340f7ceed366173fbbc8d610f8a33ee44fe0eebadbc24
reviews/statement-referee-2.md
e485d42c095f93b75acc5b85b3accca9d6344ec280d5911762bab261a8f209af
verification/statement-freeze.json
3191be904fdac9e38e40eedda6f1327426e97d6fd7bc808246a9e8886bf8f66b
```

### Audit source files and principal logs

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
verification/export-audit2.log
b9ef4f51ea56d84965f9c846d2ecd0a91c18d932fda8f5306ed6ba44d49db38f
verification/measurability-audit.log
472f4a03ccd94d2564e1f371ed54e564de1f4380ae1b0bbfa85c34181244d85c
verification/scalar-probability-axioms.log
e9f1098c2000074b1edef471ebc3e9072ab696243d34b69f826c251c0e3b9641
verification/numerical-route-audit.log
dbabe3350444c71c9207af46490d6fe0e60c45768ddabcb1f1336147cbe6e680
verification/numerical-boolean-audit.log
2c8fbd2bb0fd3a88e09c6ef28901c9f210b24e80d2b7ea79f6e76fa9c1ba3045
```

### Inspected pinned library files

Paths relative to `.lake/packages/`. Local dependency HEAD files match Mathlib `0df444a360eaa60ab8c11dca51a86af692955474` and LeanCert `621a43d7cf21f87872392a01e874f2f1dbddc926`.

```text
mathlib/Mathlib/Probability/Distributions/Gaussian/Real.lean
f86827f9c60d435c5dfeffee1ac6d95f5a953c98703bdc1c653a368c23a2365b
mathlib/Mathlib/Analysis/CStarAlgebra/Matrix.lean
79518c9e51c4d0cf4083ab69a9ac7a2817305b48db1fe6f25ae1d678e12ce223
mathlib/Mathlib/Probability/Independence/Basic.lean
85c6c98a306c1b10952181fcb9cc777c0ed06e91246428690a88d7821d24f9d2
mathlib/Mathlib/MeasureTheory/Constructions/Pi.lean
8751b21ac855f1a7b7c63258e8325f75b6fc236d360758b822ddf54597b118bf
mathlib/Mathlib/Analysis/SpecialFunctions/Pow/Asymptotics.lean
004e4d6013b20f95feedfcb23b257c07eb1ee4c7645b9d81fd6e4cb684a116d6
mathlib/Mathlib/MeasureTheory/Order/Lattice.lean
e658ea7c1345a2af12ffa84a22b26a032f89e492b280a3009bbc0b038ad2a102
leancert/LeanCert/Tactic/Verification.lean
2c576708b528acdde17796b0b715b83079f9cad377182dbd87c248323ff0a58c
leancert/LeanCert/Validity/DyadicBounds.lean
6f1cdbc11f32e425ef5e9f4a22966d64ff0d11614ec9453ed7dde498e31a7c47
```

**Final assessment:** PASS for the full original IE-04 negation and all twelve proof-source contracts. No mathematical revision is requested. Complete the separate mechanical gates and repair the missing receipt reference before presenting the evidence package as final.