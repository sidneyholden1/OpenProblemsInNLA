# IV-06 independent statement referee 1

- Phase: pre-proof statement, numerical-certificate and original-target fidelity.
- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent.
- Date: 2026-09-14.
- Protocol: `docs/lean/REVIEW.md`; adapted Tau Ceti scope/correctness review, not an official Tau Ceti review or human review.
- Final verdict: **APPROVE** the corrected statements on the final hashes recorded below. Initial verdict was **REQUEST CHANGES** to one numerical-plan sentence; the finding and its resolution are retained.

## Exact bytes inspected (SHA-256)

Paths beginning `lean/` are relative to the canonical IV-06 directory.

| File | SHA-256 |
|---|---|
| Repository `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| Canonical `README.md` | `05927abe987e01c08a3462b74223281106ddef0b8fb3f903c373510a06ba9ef9` |
| Repository `references/colbrook-intervals-2026-09-11/manuscripts/IV-06.tex` | `659f073ef696d78c7a2f2a4c06dd8ac0523ed991007b5917d49ae5daca236174` |
| `lean/NUMERICAL_TARGETS.md` | `e0634282e1d8a354a46f6f1afdab8ac3757a9b3927fb8bfa8eb3ce85615b562f` |
| `lean/NLA/IV06/Definitions.lean` | `ecfdcaab122a34f7f447485cbe816e8548803917ad0e9763b07e50bfa5cb3bad` |
| `lean/Challenge.lean` | `b81665e31d3b971929e00d1096788accc9943ffd2c3bc947c0481460e9497ff1` |
| Pinned Mathlib `Mathlib/Topology/Connected/Basic.lean` | `7954c5a7e0b570ecdbeb53e17d7ba15f79028cc6530deb8875531612bd94eff8` |
| Pinned Mathlib `Mathlib/Data/Set/Card.lean` | `66ccca9b43ba4c1f2905dcc5f775675711451d5e4055be95b0ff8ba950dbc39c` |

## Required correction

`NUMERICAL_TARGETS.md`, paragraph on eliminating the eigenvector equations, says that at `t = 12` the first equation contradicts `a ≤ -16, b ≤ 159`. Those upper bounds alone do not exclude this eigenvalue: `a = -169, b = 0` satisfies them and makes the coefficient zero. The actual interval family does exclude this choice through its lower bounds. Replace the named bounds by **`a ≥ -166, b ≥ 9`**. Substitution of `v0 = 13 v1 = 11 v2` into the first equation, multiplied by 143, gives

`(1859 + 11*a + 13*b) * v0 = 0`.

The lower bounds give `1859 + 11*a + 13*b ≥ 150 > 0`; hence all three coordinates vanish. This correction changes neither the intended target nor the valid source certificate.

## Fidelity and nonvacuity findings

I read the entire canonical problem and manuscript, including their scope and provenance notes. `ComponentBoundConjecture` quantifies over all natural dimensions at least one and all real square endpoint matrices in entrywise order. `intervalFamily` uses a separate pair of weak inequalities for every entry, preserving independence and singleton entries. `realEigenvalueSet` requires an actual real vector unequal to zero and the full matrix-vector eigenvalue equation. No symmetry, diagonalizability, invertibility, or all-real-spectrum hypothesis was added.

I inspected the pinned Mathlib definitions, not merely their names. `connectedComponentIn S x` is the image of the connected component in the subtype `S` when `x ∈ S`, and is empty otherwise. Taking its image only over `S` therefore counts precisely nonempty components without an extra empty component. Membership, containment and preconnectedness are supplied by `mem_connectedComponentIn`, `connectedComponentIn_subset`, and `isPreconnected_connectedComponentIn`. Equal point components are counted only once because the collection is a set. `Set.encard` is `ENat.card`; Mathlib explicitly proves that infinite sets have cardinality top and finite sets have their usual natural cardinality. Thus the bound does not accidentally count infinite collections as zero. Empty and singleton spectra behave as the canonical problem requires.

The concrete lower and upper matrices describe exactly the source's two independent intervals, with the remaining entries fixed. Each of the four integer eigenpairs was independently checked by direct integer arithmetic, including nonzero vectors and parameter bounds. The characteristic polynomial `(t-25)*(t*t-1) - a*(t-1) - b*(t+1)` yields exactly `[-332,-32]`, `[-318,-18]`, and `[-3750,-150]` at the three separators when evaluated at the four parameter corners. Since the expression is affine in the two independent parameters, these are the full ranges. At `t = -1`, the second row forces `v0 = 0`, then the third forces `v2 = 0` and nonzero `a` forces `v1 = 0`. At `t = 1`, the third row forces `v0 = 0`, then the second forces `v1 = 0` and positive `b` forces `v2 = 0`.

The four Challenge exports require actual inclusion, exclusion, at least four actual components together with valid endpoint ordering, and negation of the original universal assertion. None assumes the desired conclusion. The ordered separators genuinely imply four distinct components because a preconnected subset of the real line contains intermediate points. The boundary appropriately requires that bridge to be proved; it does not claim an exact component count or identify endpoints. Refuting the direct component-count formulation suffices for the original conjecture without separately formalizing its compact-interval restatement.

## Mechanical gates and limitations

No completed proof, axiom audit, LeanCert execution or Comparator execution was inspected in this phase. Challenge placeholders are deliberate and provide no mathematical verification. Type-checking is pending the author's runtime preparation; approval of statement meaning cannot replace that gate. After correcting the numerical-plan sentence, record the revised hash and resolution below before beginning proof bodies.

## Resolution and final statement approval

I reread the complete corrected numerical-target file and definitions. The numerical paragraph now correctly uses `a ≥ -166` and `b ≥ 9` and obtains `(1859 + 11a + 13b)v1 = 0`. This version follows by substituting `v0 = 13v1`, `11v2 = 13v1` and multiplying the first equation by 11; the coefficient is at least 150. It is equivalent to the `v0` version derived above. The substantive finding is resolved.

The only definitions change replaces `Mathlib.Data.Real.Basic` with `Mathlib.Topology.Instances.Real.Lemmas`, providing the required usual real topology. I inspected that module's imports and its real open-interval basis declaration; it supplies the intended topology and does not change the problem definition. The Challenge bytes are unchanged.

| Final reviewed file | SHA-256 |
|---|---|
| `lean/NUMERICAL_TARGETS.md` | `631d38fec203c0da5dc57be09320df336049362718c43903788fba8a9d13fc8d` |
| `lean/NLA/IV06/Definitions.lean` | `880ca2f1b14e420ccb613fa560668d9d560329f2901421772fbe68a765aab0f7` |
| `lean/Challenge.lean` | `b81665e31d3b971929e00d1096788accc9943ffd2c3bc947c0481460e9497ff1` |
| `lean/verification/statement-build.log` | `c9c3394f329e860c761e307414bc8efdcbfaa7870bebebac93a426653776361a` |

All other reviewed hashes above remain applicable. I inspected the complete statement-build log: Definitions and Challenge built successfully, with precisely the four deliberate Challenge `sorry` warnings, and the log ends `Build completed successfully (1620 jobs).` This clears the statement type-check gate; it proves no mathematical theorem. **Approve the final pre-proof boundary**. Proof review, transitive axiom audit, LeanCert verification, and Comparator remain separate required gates.
