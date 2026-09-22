# IE-15 independent statement referee 2

- Phase/date: pre-proof statement review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of implementation; not human peer review or official Tau Ceti service.
- Verdict: **PASS / APPROVE** at the exact hashes below. No blocking statement correction requested. This is not approval of an implemented universal upper-bound proof.
- Protocol: `docs/lean/REVIEW.md`; full scope, correctness/degeneracy, feasibility, reuse and credit covered. Usage checked during review: 26% remaining, above the requested stop threshold. No proof or metadata edited.

## Source and full target

I read the complete canonical README and complete George Stepaniants solution.md, including all normalization, order-three, scalar-lemma, order-four and witness sections. I read every definition/Challenge target, NUMERICAL_TARGETS, current metadata/config and retained exact witness script/log. All six statement hashes match. The complete canonical sources match immutable base `9777c86853b40206f70438c92a47a7dec9bc66ae`.

The boundary retains both original constants together: 3 and 14/3. Universal upper_three and upper_four quantify arbitrary real nonsingular matrices and arbitrary admitted rook paths. Neither assumes diagonal pivoting, normalized entries, positive pivots, an LDR factorization or an extremizing witness. Every tie is included. The final theorem requires genuine nonempty bounded growth sets and their exact suprema. The unrelated order-five lower bound on the canonical page is correctly outside scope.

## Actual pivot recurrence, indices and denominators

`isPath` starts with S0=A. At every k it chooses current row r and column c at least k, requires a nonzero pivot, and bounds every active entry in that column and every active entry in that row by the selected absolute pivot. It does not impose global maximality, a search-start convention, a smallest-index rule, or any restriction on ties.

`schurStep` performs exactly the current row and column interchanges: its surviving entry is old A[swap(k,r,i),swap(k,c,j)], its pivot column entry is old A[swap(k,r,i),c], its pivot row entry is old A[r,swap(k,c,j)], and its denominator is old A[r,c]. This remains correct when a surviving row i=r receives old row k and/or a surviving column j=c receives old column k. The next active block is i,j>k; all earlier entries are padded by zero. I independently compared the formula with separately executed row/column swaps then elimination for all 30 active pivot positions across the four stages of an order-four rational test matrix. Those finite diagnostics supplement direct semantic inspection; they are not the universal proof.

The recurrence is imposed whenever k+1<n, so every relevant later stage is forced; no irrelevant terminal update is required. The final stage is included in pivot and growth conditions. Values S[k] for k≥n cannot affect growth. The path's initial nonzero pivot implies entryMax A>0 in the positive dimensions at issue; det A≠0 is also explicit in all universal targets and in the growth-set membership. Thus totalized real division at zero cannot discharge the desired result. Empty dimension behavior is irrelevant to orders three and four.

`diagonalStates` uses the actual Schur step recursively at diagonal pivots. Its value at n becomes zero after the final padded update, and later values remain zero, but none of those indices enters growth. The witness theorem still separately proves every rook condition, so recursion does not assume admissibility or encode a desired growth number.

## Actual maxima, sets and witness feasibility

entryMax and growth use Mathlib finite suprema of nonnegative real entry magnitudes. Growth ranges over all entries of every stage 0,…,n−1, including the input and all intermediate stages. These are entry maxima, not a final-pivot-only ratio or another matrix norm. Zero padding preserves maxima of absolute values. The underlying finite supremum folds lattice maxima from zero, as reviewed in the shared pinned IE-05 implementation.

rookGrowths is exactly the set of all ratios attained by real nonsingular matrices and admitted rook paths. A single supremum of this full set represents the original supremum over matrices and paths. The final theorem explicitly requires Nonempty and BddAbove for each dimension, preventing empty/unbounded real-sSup defaults. The actual universal bounds and witness membership suffice for both directions of the supremum equality, through the usual conditional least-upper-bound APIs.

I independently performed exact Fraction elimination using the actual padded formula on both source witnesses. I checked initial maxima one, every selected pivot's row and column inequalities, all stages, determinant products 3 and 70/9, and growths exactly 3 and 14/3. Their active blocks match the complete source tables. Evidence: `verification/referee-2-independent-check.json`. This independent calculation did not execute the author's script; I separately inspected that retained script and its matching log. All are diagnostic preparation, not Lean proof evidence.

## Analytic proof obligations and optimization

The scalar plan preserves the full source domains, including p>0, q>0, nonnegative c variables, signed d variables, and all three original-entry bounds. The difficult negative-d1/positive-d2 case, q≤1 branch, zero/sign endpoints, and separate convexity corner reduction are present in the complete source. A future helper restricted to only nonnegative d variables would not suffice. No such restriction is currently in the boundary.

The planned normalization must actually transport arbitrary row/column pivot paths, entry maxima and growth; prove sign changes and positive pivots; and derive every LDR multiplier/entry bound. The possibly singular three-dimensional submatrix must be handled with its first two nonzero pivots, without incorrectly importing a nonsingularity assumption for that submatrix. Earlier entries must also be bounded, not just the final positive pivot. These are explicit future implementation obligations; my statement approval does not assume they have been formalized. The source gives a plausible complete analytic route, and the final targets demand all these bridges. Scalar exact inequalities and a small kernel LeanCert comparison can reduce computation; interval sampling cannot replace universal analytic steps.

## Mechanical gates, reuse and credit

I independently elaborated Challenge using the pinned Lean4.33.1 runtime/cache, exit zero with exactly four intentional sorry warnings. `verification/referee-2-statement-elaboration.log` retains the result. The author's 2380-job log agrees. This establishes well-formed statements only. Comparator selects all four exports, no definition replacements, and only propext, Classical.choice and Quot.sound. I inspected draft metadata but did not independently rerun its schema validator or actual Linux Comparator.

The adaptation of IE-05 finite entry maxima and padded paths is appropriate and credited, with the necessary extra column swap and row maximality supplied explicitly. Exact rational witnesses and a source analytic reduction avoid unnecessary numerical search. George Stepaniants's mathematical resolution, Higham's original question, Holden's formalization and Codex assistance remain distinct; AI-review/source-nonendorsement qualifications and Apache license are retained. No priority, affiliation or ownership authentication is claimed.

No Solution proof was inspected or written. Two final proof reviews, all-export kernel/axiom checks and actual isolated Linux Comparator/default-kernel/rejection controls remain required before any formal verification promotion. The proof difficulty and remaining work are not hidden by this statement PASS.

## SHA-256

- `NLA/IE15/Definitions.lean`: `f63b4ac19b98baad4db5941b35bd6ed5cc99f6b4d9c646cbd82523c5612b4ccf`
- `Challenge.lean`: `a16d4575337e754f6dcb2cf36481ea5b7532b0fed0dd0d7416cd96fd50c7237f`
- `NUMERICAL_TARGETS.md`: `cf55f7b8b6bd898b2eae37dbe5e39c82f9b772603894f158ad97340947570273`
- `comparator.json`: `944d5c2688bcfeae2fb73510a8595fad6dc55c34d83b67974cb11d392c50eeac`
- `formalization.yaml`: `d81c2f2d469406e97972e9cf7e755a27c49a897e5d7e06072ad2ab9f8df046f0`
- `README.md`: `56234330124849367785ac2dc78ac5ebdb286f4e5faba9ceb177eba9e8df68c1`
- `../README.md`: `15d158615000f0f121540d2d0bad95487e5d1b4dc26c17a2876ab56c8e0be4d1`
- `../solution.md`: `abe560be8d00a2a98fb4a11619d5e77926649172fbb07828e747500139e97620`
- `reviews/statement-source-hashes.json`: `375d61e5b9a84ca70d55a65d8952d2f5714c19cc4d19974431938323892f5f20`
- `verification/referee-2-independent-check.json`: `ab0261edd75dc9357f014c4f5a2231eac85b7d899404f3cd5fcf9daea0b1cc43`
- `verification/referee-2-statement-elaboration.log`: `50d63c229712f81aff1cbd6fef73778f0aef5fd6e8dd71d4202f61f83132682e`
- `verification/verify_witnesses.py`: `2462327de46efb167c1ded88dadb96b6ed5f4669a6a9eea7ecc01950f08865e0`
- `verification/numerical-precheck.log`: `7fb0cbc8c47229660f47236bb16033f0e9117daa6d745cc38c8f740718cc3f7e`
- `verification/statement-build.log`: `2cba7487927267a98b1652accb54892e56e841f13fe0ecf90e48e93c9eab5d7d`
- `.lake/packages/mathlib/Mathlib/Data/Finset/Lattice/Fold.lean`: `79b80dd5aa12886d31c582ab00585627dc4e7f1d7607c7b707484f38d95ce2f4`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
- `.lake/packages/mathlib/Mathlib/Logic/Equiv/Basic.lean`: `5b69b238b9fb70f3b1fdede5be53fa5d69047943bf1b1e36162f37de71b67cc8`
