# IV-06 independent statement referee 2

- Phase: pre-proof statement and numerical-target review, 2026-09-14.
- Reviewer: `/root/iv06_statement_referee_2`, independent OpenAI Codex AI agent; not a human referee or an official Tau Ceti service.
- Base repository revision: `9777c86853b40206f70438c92a47a7dec9bc66ae` (new statement files reviewed from working tree).
- Mathlib revision inspected: `0df444a360eaa60ab8c11dca51a86af692955474`.
- Verdict: **APPROVE the mathematical statements at the hashes below**, with successful statement type-checking inspected separately. One substantive numerical-documentation error was reported and corrected before approval.

## Fidelity and topology

I read the complete canonical README and complete supplied manuscript. `intervalFamily` quantifies independently over every matrix entry, with both closed inequalities. `lower` and `upper` give exactly the two variable entries in the manuscript and seven singleton entries. In particular no symmetry condition or coupling has been substituted. `realEigenvalueSet` uses real matrices, an actual nonzero real column vector, and Mathlib's row-dot-vector `Matrix.mulVec`; real scalar multiplication gives exactly A v = t v.

`ComponentBoundConjecture` covers every natural dimension at least one and every pair of ordered real endpoint matrices. Its conclusion counts components rather than points or eigenvalues with multiplicity. In the actual imported source, `connectedComponentIn S x` is the subtype connected component imaged into the ambient space, and is empty only when x is outside S. Taking its image over S therefore counts precisely the nonempty connected components; repeated representative points do not create duplicate elements of this set of sets. Mathlib's `Set.encard` is `ENat.card` of the subtype, which is infinite rather than zero for an infinite set. Thus neither an empty-component artifact nor a finite-cardinality junk value can make the theorem misleading. The ambient type is the standard real topological space, with no replacement topology.

The four Challenge conclusions require actual membership, actual nonmembership, at least four components with ordered endpoints, and negation of the entire original universal conjecture. The dimension-three witness suffices to refute that conjecture. The target does not silently assume the separator-to-components argument, invertibility, spectral reality, determinant-zero equivalence, or a finite component set. It appropriately does not require proving the optional compact-interval reformulation or finding every endpoint.

## Independent numerical and elimination check

I independently multiplied the four integer matrices by their displayed vectors with an exact Python integer check. The products were respectively (12,-6,-3), (0,0,0), (12,3,6), and (7800,300,325), equal to t v; all vectors are nonzero and all parameter pairs satisfy both endpoint bounds. Independently evaluating the affine determinant formula `(t-25)(t²-1)-a(t-1)-b(t+1)` at the four parameter corners produced exactly [-332,-32], [-318,-18], and [-3750,-150] at -1, 1, and 12. These auxiliary computations are not Lean verification.

At t=-1 the second row forces v0=0, the third forces v2=0, and a≤-16 forces v1=0. At t=1 the third row forces v0=0, the second forces v1=0, and b≥9 forces v2=0. At t=12 the last two rows imply v0=13v1=11v2. Multiplying the first row relation by 11 gives `(1859+11a+13b)v1=0`. The lower bounds imply this coefficient is at least 150, excluding a nonzero vector.

**Resolved finding:** the initial numerical-target prose incorrectly named the upper bounds a≤-16 and b≤159 as sufficient for the t=12 contradiction. I requested correction; the final bytes now explicitly use a≥-166 and b≥9 and display the coefficient lower bound 150. Upper bounds alone would not suffice. The public Challenge signatures required no change. A subsequent elaboration correction replaced `Mathlib.Data.Real.Basic` with `Mathlib.Topology.Instances.Real.Lemmas` in Definitions to supply the standard real topology. I reread the corrected import and that imported module; this supplies the intended instance and changes no mathematical signature.

The exact ordering -3<-1<0<1<3<12<25 places an excluded number between every pair of distinct included witnesses. Mathlib's existing `IsPreconnected.Icc_subset`, `isPreconnected_connectedComponentIn`, and `connectedComponentIn_subset` supply the appropriate bridge: equal components would contain both witnesses and hence the excluded separator. Four distinct nonempty components then imply extended cardinality at least four.

## Reuse, attribution and limitations

I searched and read the pinned Mathlib APIs for connected components, real preconnected intervals, set extended cardinality, and matrix-vector products, and inspected the established MI-29 proof-independent definitions as a repository structure example. The proposed boundary sensibly wraps existing mathematical objects instead of introducing a custom connectivity or cardinality semantics. Exact algebra avoids any need for subdivision, determinant-range overestimation, or floating-point spectral computation. A small LeanCert auxiliary margin is compatible with this plan provided its use is on the actual proof path and kernel-audited.

The source attributes the mathematical counterexample to Matthew J. Colbrook, the conjecture to Hladík, Daney and Tsigaridas, and formalization to Sidney Holden with OpenAI Codex assistance. The new definitions carry the Apache 2.0 notice and a project LICENSE exists. The canonical page and source truthfully distinguish AI draft provenance and agent review from human review and formal certification. This report makes the same distinction. It does not verify legal ownership or independently authenticate authorship.

No Solution implementation was reviewed. I inspected `verification/statement-build.log`: Definitions and Challenge built successfully (1620 jobs), with exactly the four deliberate Challenge `sorry` warnings. I did not independently rerun that build, and ran no axiom audit, LeanCert certificate, or Comparator. Deliberate Challenge `sorry` placeholders establish no mathematics. Mathematical statement approval is not permission to claim Lean verification: the inspected challenge elaboration is only the statement gate; two statement approvals, final independent proof reviews, kernel/axiom audit, and sandboxed Comparator remain separate required gates.

## SHA-256 of reviewed files

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `intervals-and-absolute-value-equations/IV-06/README.md`: `05927abe987e01c08a3462b74223281106ddef0b8fb3f903c373510a06ba9ef9`
- `references/colbrook-intervals-2026-09-11/manuscripts/IV-06.tex`: `659f073ef696d78c7a2f2a4c06dd8ac0523ed991007b5917d49ae5daca236174`
- `intervals-and-absolute-value-equations/IV-06/lean/NUMERICAL_TARGETS.md`: `631d38fec203c0da5dc57be09320df336049362718c43903788fba8a9d13fc8d`
- `intervals-and-absolute-value-equations/IV-06/lean/NLA/IV06/Definitions.lean`: `880ca2f1b14e420ccb613fa560668d9d560329f2901421772fbe68a765aab0f7`
- `intervals-and-absolute-value-equations/IV-06/lean/Challenge.lean`: `b81665e31d3b971929e00d1096788accc9943ffd2c3bc947c0481460e9497ff1`
- `intervals-and-absolute-value-equations/IV-06/lean/.lake/packages/mathlib/Mathlib/Topology/Connected/Basic.lean`: `7954c5a7e0b570ecdbeb53e17d7ba15f79028cc6530deb8875531612bd94eff8`
- `intervals-and-absolute-value-equations/IV-06/lean/.lake/packages/mathlib/Mathlib/Data/Set/Card.lean`: `66ccca9b43ba4c1f2905dcc5f775675711451d5e4055be95b0ff8ba950dbc39c`
- `intervals-and-absolute-value-equations/IV-06/lean/.lake/packages/mathlib/Mathlib/SetTheory/Cardinal/Finite.lean`: `b113177c5ed00662c73a8f3b04002b399c19f0d008920e52c1a6b6c7f16713bf`
- `intervals-and-absolute-value-equations/IV-06/lean/.lake/packages/mathlib/Mathlib/Data/Matrix/Mul.lean`: `9ce6ecd0751e977f58fc47d6f271dff381e59868474a6955730ff07a99aa0e6b`
- `intervals-and-absolute-value-equations/IV-06/lean/.lake/packages/mathlib/Mathlib/Topology/Order/IntermediateValue.lean`: `6e22cbb5e8b9124378735958f0282285a127f3b1dc9eaafeb2c714f89222ba65`
- `intervals-and-absolute-value-equations/IV-06/lean/verification/statement-build.log`: `c9c3394f329e860c761e307414bc8efdcbfaa7870bebebac93a426653776361a`
- `intervals-and-absolute-value-equations/IV-06/lean/.lake/packages/mathlib/Mathlib/Topology/Instances/Real/Lemmas.lean`: `f36816a654a9a6c3c07d4197ca61b9b00bda9971984a02cbe176c96728e17027`
