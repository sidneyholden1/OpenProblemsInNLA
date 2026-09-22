# IE-15 independent statement referee 1

**Verdict: PASS / approve this boundary before proof implementation.** No blocking statement or witness findings. This establishes statement fidelity and feasibility, not the universal upper-bound proofs or completed Lean verification.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the implementer. Date: 2026-09-14. Phase: statements only. Responsibilities: full source fidelity, arbitrary-input/all-path scope, row/column rook semantics, nonvacuity, maxima/suprema, witness checks and analytic proof obligations, plus reuse and attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not official Tau Ceti review or external human certification.

## Exact reviewed sources

I read the complete canonical README and full Stepaniants solution.md, including Theorem 1 and every section of the analytic proof, Definitions, Challenge, numerical targets, project README, formalization.yaml, Comparator config, the source witness script and retained exact output. Canonical README and solution are byte-identical to `9777c86853b40206f70438c92a47a7dec9bc66ae`, with hashes `15d158615000f0f121540d2d0bad95487e5d1b4dc26c17a2876ab56c8e0be4d1` and `abe560be8d00a2a98fb4a11619d5e77926649172fbb07828e747500139e97620`, respectively. The copied witness script is byte-identical to its retained source.

Every frozen statement-snapshot hash was independently verified and rechecked at report creation:

| File | SHA-256 |
| --- | --- |
| `NLA/IE15/Definitions.lean` | `f63b4ac19b98baad4db5941b35bd6ed5cc99f6b4d9c646cbd82523c5612b4ccf` |
| `Challenge.lean` | `a16d4575337e754f6dcb2cf36481ea5b7532b0fed0dd0d7416cd96fd50c7237f` |
| `NUMERICAL_TARGETS.md` | `cf55f7b8b6bd898b2eae37dbe5e39c82f9b772603894f158ad97340947570273` |
| `comparator.json` | `944d5c2688bcfeae2fb73510a8595fad6dc55c34d83b67974cb11d392c50eeac` |
| `formalization.yaml` | `d81c2f2d469406e97972e9cf7e755a27c49a897e5d7e06072ad2ab9f8df046f0` |
| `README.md` | `56234330124849367785ac2dc78ac5ebdb286f4e5faba9ceb177eba9e8df68c1` |

## Actual rook paths and growth

`isPath` starts from the actual A and constrains every stage indexed by Fin n. The selected row r and column c are both in the active region, the pivot is nonzero, and its absolute value dominates ALL entries in its active column and ALL entries in its active row. There is no global-maximum condition and no fixed search algorithm or tie-break restriction. Thus the predicate includes every admissible rook choice and tie, rather than complete pivoting or only diagonal paths.

`schurStep` correctly applies two independent swaps. For retained i,j it uses the entry at swapped row i and swapped column j, subtracts the swapped-row entry in old pivot column c divided by old pivot A(r,c), and multiplies by the old pivot-row entry in the swapped column. This is exactly the trailing Schur complement of the row/column-swapped matrix. The choices may overlap in numerical index without coupling the row and column permutations. Earlier rows/columns are padded with zero. The recurrence is imposed precisely when a next relevant stage exists, k+1<n; the final stage still requires its nonzero pivot. Sequence values at indices at least n are irrelevant to the maxima and path conditions.

The recursively defined `diagonalStates` supplies candidate actual Schur steps with r=c=k; it does not bake rook maximality or nonsingularity into the definition. Witness admissibility is a separate explicit proof obligation. The recursion's step at k=n−1 produces the all-zero padded state beyond the final measured stage, and later values are zero. No extra elimination state can affect growth or create a spurious witness.

`entryMax` is the genuine finite supremum of nonnegative absolute individual entries, and `growth` takes the same maximum over all n stages and every row/column before dividing by the original maximum. I inspected pinned Mathlib's `Finset.sup` join-fold definition and real sSup implementation. These are entry maxima, not spectral norms or merely pivot maxima. Padding zeros cannot change the maximum of a nonempty active stage. In the relevant dimensions, the first nonzero path pivot ensures strictly positive input maximum, so later normalization can be justified without totalized division at zero.

`rookGrowths` ranges jointly over ALL real matrices with actual determinant nonzero and ALL admissible paths. It is the set of exactly the growth values in the source supremum; a joint set is equivalent to taking the supremum over matrix/path pairs. The upper-bound signatures quantify over arbitrary A,S,r,c with only nonsingularity and the actual path predicate. No normalized entry bound, LDR factorization, positive-pivot condition or sign convention is inserted as an extra hypothesis. The final theorem separately demands nonemptiness and boundedness above in BOTH dimensions, as well as the actual real suprema. Consequently the real sSup fallback zero on empty or unbounded sets cannot prove the result.

## Exact witnesses and nonvacuity

The two literal matrices, determinants 3 and 70/9, input maxima one, and target growth factors 3 and 14/3 agree with Section 5. The witness export requires both true determinant equalities, both path proofs, both input maxima and both full growth equalities. These imply actual attained members of the corresponding growth sets, so the upper-bound and sharp-supremum claims are not vacuous.

I separately implemented exact Fraction arithmetic using the padded row/column-swap formula and an independent permutation-expansion determinant. The diagonal witnesses have pivots (1,1,3) and (1,1,5/3,14/3), with stage maxima (1,2,3) and (1,2,3,14/3). All selected pivots are nonzero and maximal in their own active rows and columns. Determinants, growth and final zero padding match the target. As an additional finite diagnostic I enumerated every admissible rook path of these specific matrices: 14 paths in order three and 56 in order four, with respective maximal growth 3 and 14/3. This does not prove universal arbitrary-input upper bounds. The author's retained exact witness output independently agrees.

## Analytic obligations retained by the statement

The source proof's normalization/permutation/sign reductions are material obligations. An implementation must prove positive scaling by the original entry maximum preserves rook conditions and growth, and that applying the path's eventual independent row/column permutations at the outset reproduces each active state up to permutations. It must derive LDR coordinates from those actual paths. Positive pivot signs and nonnegative last-row multipliers require justified real row/sign transformations, not assumptions on the original input.

Replacing the normalized last diagonal entry by one is used only to dominate the positive final pivot; earlier pivots and their active pivot rows/columns stay unchanged, and positivity keeps the modified final pivot nonzero. This reduction must be established before applying a scalar bound to arbitrary paths. Earlier Schur entries also need their own uniform bounds: one initially, at most two after one step, and at most four after two steps in order four. Proving only a last-pivot bound would not prove the exported growth bound.

The order-three argument must include the extension to a possibly singular three-by-three submatrix with two nonzero admissible pivots. In the order-four proof, restriction to indices 1,2,4 preserves those two pivot-row/column inequalities but does not automatically preserve nonsingularity. The source handles the zero final Schur value separately; an implementation cannot simply invoke the nonsingular public order-three theorem on that submatrix.

The recorded scalar plan retains the entire source domain, including 0<p≤1, arbitrary q>0, signs of a,b,d1,d2 and c1,c2 in [0,1], plus all three original-entry inequalities. Its cases q≤1, q>1 with opposite signs of a,b, and the mixed-sign d case are not omitted. The final bilinear-corner/separate-convexity reduction must be proved from those variables and actual input constraints. The source gives an exact analytic route; no interval sampling or rational-witness calculation establishes it. These substantial implementation obligations are feasible and fully exposed by the arbitrary-path statement signatures. No definition hides a normalized-coordinate conclusion in an admissibility assumption.

## Elaboration, reuse and remaining gates

I inspected the author's 2380-job statement-build log and independently replayed `lake env lean Challenge.lean` with pinned Lean 4.33.1 on local macOS using the shared cache. Exit 0, with exactly four intended Challenge placeholder warnings. There is no Solution or mathematical proof implementation in this reviewed boundary. The IE-05 padded-state/max-entry framework is reused consistently, with the additional column swap and second rook inequality correctly included. Future generic entry-bound and scaling lemmas can reuse existing Mathlib finite-supremum and matrix APIs. Exact arithmetic and kernel LeanCert for genuinely scalar inequalities are suitable; no interval search is needed for the witness certificates.

Metadata truthfully labels statement preparation, full intended scope in both dimensions and all remaining proof/verification gates. It retains Stepaniants's mathematical attribution, Higham's original question, Holden/Codex formalization credit, and source/automation disclosures without claiming external human endorsement or novelty. Comparator names all four intended exports, no definition replacements and only the three standard axioms. I did not independently repeat official schema validation. Actual proof replay, exported transitive axiom audits, two final proof reviews and isolated Linux Comparator/default-kernel replay with rejection controls remain future gates.

Evidence hashes:

- `verification/verify_witnesses.py`: `2462327de46efb167c1ded88dadb96b6ed5f4669a6a9eea7ecc01950f08865e0`
- `verification/numerical-precheck.log`: `7fb0cbc8c47229660f47236bb16033f0e9117daa6d745cc38c8f740718cc3f7e`
- `verification/referee_1_statement_check.py`: `14c4c05c4e3168e03662a152eb33b77974910dd576caaa74caaa03d3258061ed`
- `verification/referee-1-statement-precheck.log`: `10f0361c55a88e5c20d048a4858728cebcaa277ecd43928048f4d8df08dac908`
- `verification/referee-1-statement-build.log`: `50d63c229712f81aff1cbd6fef73778f0aef5fd6e8dd71d4202f61f83132682e`
- `verification/referee-1-statement-hashes.log`: `976b67519c8b4884a372f2e8a8d39dd4d544a9b072c1529bb4cda638e6b711a3`

No blocking changes requested. I did not modify frozen statements, proof or metadata, and made no push. This approval is specific to the exact bytes above; it must not be presented as formal proof of the universal upper bounds. Canonical target/ID/path/status are unchanged. Usage was checked at the start and during this bounded review and remained 26%, above the user's 25% stop threshold.
