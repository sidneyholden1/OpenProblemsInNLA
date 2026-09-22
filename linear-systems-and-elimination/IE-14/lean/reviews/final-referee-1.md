# IE-14 final independent proof review — PASS

Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_1`, nonauthor of the IE-14 statement and proof. Date: 2026-09-22. This applies the repository's Tau Ceti adaptation to full-target fidelity, proof correctness, computation, reuse/API and attribution. It is not external human peer review or Tau Ceti endorsement.

**PASS for the complete local four-export formalization of canonical IE-14.** Fresh isolated Linux Comparator/default-kernel and operational controls remain separate pending gates; this review alone does not authorize a Lean-verified publication claim.

## Identity and independent execution

I read the complete original canonical target, Colbrook manuscript and supplied full informal review; I inspected the entire ten-file active local Solution closure, not merely the theorem wrappers. All 25 final candidate hashes match `proof-source-hashes.json` (SHA-256 `01160ab473019fa5939a9fdeba4bb9a1aac5c35da4ad478f1c1058dde5f9d40c`). All sixteen approved statement inputs remain byte-identical at their recorded paths, including the preserved original README/YAML under `reviews/statement-original`. Five previously reviewed upper-closure files are unchanged. Base.lean changed only its first-line attribution from IE-05 adapted bounds to IE-15 studied patterns; reversing that exact header substitution reproduces the old hash, and I reread the current full file. No mathematical bytes changed. The earlier partial report is now supplemented by full witness/assembly review.

My own `verification/Referee1Consumer20260922.lean` reproduces all four exact frozen Challenge signatures and consumes the corresponding Solution declarations. It exits0, with all four LeanCert kernel assertions passing and every transitive axiom list exactly `propext`, `Classical.choice`, `Quot.sound`. I inspected the author's actual final `solution-build-final.log`: PASS3,086 jobs, plus separate axiom and metadata-validation logs. Those are honestly attributed author runs, not my full rebuild. Earlier failed development logs are retained and are not acceptance evidence. No Challenge import, sorry, custom axiom, native verification or unsafe definition occurs in the active local closure.

Exact boundary, active-source, supporting-library and execution hashes are recorded in `referee-1-proof-evidence-20260922.json`, SHA-256 `0593f5807684c0f3786627b2deaa663bd955fc9c80ce506fa1e7947c62de4e64`.

## Full target and universal upper bound

The four exports retain every complex nonsingular cyclic tridiagonal matrix, both nonzero corners, every n≥4, the fixed original ordering and every permitted active-column maximum-modulus tie. They bound every active entry at every stage, prove the literal source rational family attains F(n+1)+1 through actual row-swap Schur updates, and establish a genuine greatest element and nonempty bounded real supremum. There is no normalization, realness, deterministic tie rule, assumed front or assumed witness-admissibility hypothesis.

Base establishes actual complex entry maxima, positive denominator from a nonzero corner, zero padding and multiplier modulus≤1 using the nonzero maximal pivot. Front inducts through the literal swaps: future nonfinal rows have zero earlier pivot-column entries, so cannot be selected and remain unchanged. This derives the three possible pivot positions and the two surviving front positions from the arbitrary actual path. PairBounds handles all three choices with complex triangle inequalities and maximum/sum envelopes.

ColumnBounds covers ordinary, last and penultimate column histories, including late arrivals and n=4 empty ranges. Its slightly looser penultimate estimate is explicitly proved below the required global sharp value; it does not weaken the theorem. Upper treats both possible final two-row pivots and partitions every coordinate into zero padding, front positions or unchanged original entries. Thus the bound covers earlier removed pivot-row values as well as the final scalar. Division uses the proved positive original maximum. The upper proof was not replaced by a statement about a preassumed front process.

## Exact attaining input and actual path

WitnessInput proves the real rational factor formulas symbolically for arbitrary n. The lower factor is unit lower triangular, the upper factor is triangular with nonzero diagonal, and the original-to-factor row map is genuinely bijective. The determinant proof uses actual matrix multiplication, the proved row permutation and its unit sign, then the actual rational-to-complex determinant map. Hence the original complex input is nonsingular, not merely an abstract LU object.

The separate ordinary, second and final column calculations prove every forbidden entry zero. Fibonacci cancellation gives the final factor-product column entries, and the actual input corners are exactly1 and−1. Finite entry bounds and a corner prove initial maximum exactly1. Small index cases and n=4 are handled within the general calculation.

WitnessPath defines actual truncated LU residual sums and proves their pivot row/column formulas. Its residual Schur identity cancels only after the upper diagonal is proved nonzero. `stageFactor_next` checks the literal current-position row swap, including stage0 and the final-position cases. Induction proves that `witnessStates` equals the padded, row-assigned residual at every active stage. Therefore the chosen pivot's value is the genuine U diagonal, all competitors have norm bounded by it because every L entry has modulus≤1, and every candidate transition is the original `schurStep`. No generic LU-elimination claim or prohibited preliminary permutation is assumed. The actual final scalar is F(n+1)+1.

Proof combines the universal upper bound with this final entry and initial maximum1 to obtain equality of actual growth. `sharp_maximum` gives membership using the concrete valid witness and domination by the all-input upper theorem. `original_target` explicitly constructs nonemptiness and boundedness before invoking the genuine greatest-element supremum API. It cannot exploit the default real supremum of an empty or unbounded set.

## Quality, reuse, attribution and limits

The proof replaces unnecessary sorting with exact two-row maximum/sum invariants, carries the original scale through the upper estimate, and uses exact rational factor identities and Fibonacci induction rather than expensive finite determinant expansion or interval subdivision. Actual Mathlib complex norms, finite maxima, matrix determinants/permutations/casts and real supremum APIs were inspected. LeanCert's material role is its transitive kernel-trust audit; no reflective interval certificate is claimed. Current successful-build lint warnings are maintenance matters only, with no source correction requested.

The source credits Matthew J. Colbrook and retains its AI-assistance/reconstruction disclosure, Higham's original target, Holden's formalization credit and dependency licenses. IE-15 layout study is credited; their different mathematical results are not substituted for complex GEPP. No novelty, source-author endorsement or human-review claim is made. There is no excluded canonical size, complex case, tie or active entry. No unresolved material finding remains.

## Active source hashes

| File | SHA-256 |
|---|---|
| `NLA/IE14/Base.lean` | `c819f4efef6a3990c7d410b78ca53c09f30e368cd74036b619c0625cd8d81f51` |
| `NLA/IE14/ColumnBounds.lean` | `337bf9f7976f617dc824463da1bcdf13a67f9d80ac002b09ea02398c40cd6e73` |
| `NLA/IE14/Definitions.lean` | `f8de5dfd03707340479aea91c66f30ab667a9439b89f9371e70dc890755c1202` |
| `NLA/IE14/Front.lean` | `59d4985e1f577a046c51ee7dc1dae59a0da07f910345291160a249540c229c6f` |
| `NLA/IE14/PairBounds.lean` | `6ad077f67ef8d9086ae15947593e7c6fd847a0a93683b97280320d9a82101e2e` |
| `NLA/IE14/Proof.lean` | `fa478a667ec0dfc6ae71cc32adaf12d69b1159533df90713261a65f25f5c733a` |
| `NLA/IE14/Upper.lean` | `c86e368a0d1ee4a0c8899893e9febe53dfe5e3cb21d4a0492b0b3859d4e0df72` |
| `NLA/IE14/WitnessInput.lean` | `a1718b92101ed3ccc695230e9850f96f34b2dd59453070026848efd5e73b99bb` |
| `NLA/IE14/WitnessPath.lean` | `723a4ad8914bf184676a1405621b89e91802d2c776d0698b7efc70504b8bb170` |
| `Solution.lean` | `c848e962decbfa53fc8594b85805d5bfee5dcd14dfc0445c2885693c83af92ca` |
