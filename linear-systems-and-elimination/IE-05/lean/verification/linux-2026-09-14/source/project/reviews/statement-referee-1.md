# IE-05 independent statement review 1

**Verdict: PASS / approve the frozen statement boundary for proof implementation.**

Phase: statement only, before proof bodies. Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the statement implementer. Date: 2026-09-14. This applies the repository's `docs/lean/REVIEW.md` adaptation of Tau Ceti correctness, fidelity, scope, quality, reuse/API and attribution standards; it is not an official Tau Ceti review or endorsement.

## Evidence and exact boundary

I read the complete canonical IE-05 README and `solution.md`, Definitions, Challenge, numerical targets, exact precheck program and full JSON output. The canonical sources are byte-identical to base `9777c86853b40206f70438c92a47a7dec9bc66ae`: README SHA-256 `b5e980fa1f171ac540465212341dfc589d4f34d33c0b59d54a520dd3b0a4f1f5`; solution SHA-256 `1b94eda6df18066f2f09b66b8b28a18ca071c0c2fb070b536dc8c798992ae434`. No permanent ID/path or original mathematical target is changed.

I independently recomputed every following file hash and matched `reviews/statement-source-hashes.json`:

| File | SHA-256 |
| --- | --- |
| `NLA/IE05/Definitions.lean` | `39e5c319afb8d8b18b4c60518a3be0f79381416b2e5340b18cf3485a7b0528e6` |
| `Challenge.lean` | `d9ee825a21016cd86c1d507e32f117bfd3039e6bb94e84597d35ec74f8911a0a` |
| `NUMERICAL_TARGETS.md` | `349088fa17814d5122d1bcd9769adb9dfbd67b7424f59ab869a73100658c4241` |
| `verification/numerical_precheck.py` | `44b6502d1b4eddc0330a70abcd436d0a503ce814133a000e7dc71e859182e7d3` |
| `verification/numerical-precheck.json` | `0b3d2d0d2c0348dd29a94d5263a1d9a0a55b1151550c7f2bc99ad31368a01e4b` |

## Scope and nonvacuity

The conjecture quantifies over every natural dimension at least two and over positive-diagonal QR factors of the prescribed real lower triangular matrix. `positiveQR` imposes the actual square-matrix relations QᵀQ=I and QR=L, upper triangularity and strictly positive diagonal of R. These characterize the prescribed positive QR convention, rather than replacing QR by the different LU factorization used to describe elimination. The standard uniqueness of positive QR makes this relational formulation faithful. The first export requires concrete QR witnesses for both the original L8 and the one-entry-modified lower matrix, so the n=8 specialization used in the refutation is not vacuous.

`isPath` constrains all n active stages: the input is stage zero; each pivot lies in the active first column at a row at least k; it is nonzero and attains the largest active-column absolute value. `schurStep` uses `Equiv.swap k p` on the retained rows and the original row p as the new pivot row, exactly implementing a current-row swap followed by the trailing Schur complement. The recurrence is required whenever k+1<n; the final stage still has its nonzero pivot constraint. Earlier rows/columns are padded with zero. Unconstrained sequence values at indices at least n cannot affect the recurrence or growth. No column pivoting or preliminary permutation is introduced.

`isFirstPath` additionally requires p≤i for every maximizing eligible row i, hence selects the first available current row. Crucially, `orthogonalGrowths` uses the unrestricted `isPath`, so every admissible tie choice remains on the left side of the conjecture. The candidate and displayed counterexample are each required to follow a real first-available path, not just an asserted LU surrogate. Both explicit paths choose p(k)=k; this is a conclusion required by the pivot export, not an assumption in the general definition.

`entryMax` and `growth` use the genuine finite supremum of nonnegative absolute entries, with the latter ranging over all n states and all row/column indices. I inspected pinned Mathlib `Data/Finset/Lattice/Fold.lean`: `Finset.sup` is the join fold from bottom, with `sup_le_iff` and `le_sup` giving precisely the maximum bounds. The NNReal bottom is zero; padded zeros do not change the active-entry maximum. The stage-zero inclusion and nonzero first pivot ensure positive denominator for every admissible path in the relevant dimensions. There is no accidental use of a spectral or row-sum norm.

I also inspected the real `SupSet` implementation in `Algebra/Order/Archimedean/Real/Basic.lean` and the conditional-supremum API. The real sSup defaults to zero on an empty or unbounded set. The exported separation theorem explicitly requires BOTH nonemptiness and boundedness above of the entire n=8 all-orthogonal/all-tie growth set, ruling out use of that fallback. A general max-next≤2·max-current path estimate is sufficient for boundedness; no exact supremum or maximizing orthogonal matrix is claimed.

The strict exhibited growth gap plus membership in that genuine bounded set gives candidate growth < sSup. The final `¬ ExtremizerConjecture` specializes its original universal quantifiers at n=8, the positive QR witness and the verified first-row path. One-sided bounds suffice for this full negation. Omitting formal equality for every source stage maximum is an intentional computation reduction, not a weakening of the original counterexample conclusion.

## Exact numerical checks and planned proof bridges

I independently replayed exact rational elimination directly from each H, separately from the precheck's LU-derived state construction. Column scaling by each strictly positive square root cancels in same-column pivot comparisons and in Schur elimination. All eight states agreed with the proposed LU state formula; every pivot was positive and the first row was a maximizing row. Numbers of tied eligible maxima at consecutive stages were (8,7,6,5,4,3,2,1) for the candidate and (8,6,6,5,4,3,2,1) for the counterexample. Thus ties are substantial and the proposed convention is actually exercised.

The independent checks verified positive D, HᵀH=diag(D), H=L·T, upper triangular HᵀL with positive diagonal, and all Schur states. Candidate input maximum squared is 2601/3286, peak squared 5462 and exact diagnostic growth squared 17948132/2601. Counterexample input maximum squared is 3969/5272, peak squared 5272 and diagnostic growth squared 27793984/3969. The exact squared gap is 117335164/1147041. The rational separator 167/2 has its square strictly between these two values. This agrees with the complete Stepaniants source and the frozen explicit entries, including the sole modification at zero-based position (7,1).

The planned smaller Lean obligations are sufficient: candidate all-stage numerator bound with a single input-entry lower bound, and counterexample all-input upper bound with a single final-pivot lower bound. Common positive column roots should be factored out once. Exact finite arithmetic and optional LeanCert kernel point cuts avoid interval subdivision and repeated irrational arithmetic. The separate required QR/path exports prevent the arithmetic certificate from bypassing the mathematical objects. Final proof review must check these bridges and the general all-path growth bound in actual Lean code.

## Reuse, attribution and checks

The use of Mathlib finite NNReal suprema is consistent with the nearby IE-19 norm-definition pattern, which I inspected, while the local growth definition correctly takes individual entries rather than IE-19's row sums. The definitions use ordinary matrix transpose, multiplication, real square root and row permutation APIs. Local names distinguish candidate, witness, general path, first-tie path and growth set. No custom definition contains the desired counterexample conclusion. Numerical targets credit George Stepaniants for the counterexample and John Peca-Medlin for the conjecture, distinguish formalization credit and AI assistance, and avoid claiming a new sharp supremum or asymptotic result.

I inspected the author statement-build log (2380 jobs) and independently ran pinned Lean 4.33.1 `lake env lean Challenge.lean`, exit 0. Its only four warnings are the four deliberate Challenge placeholders. This establishes statement elaboration, not theorem truth. My independent rational checks passed and are also diagnostics, not kernel evidence.

Own evidence hashes:

- `verification/referee-1-statement-build.log`: `8e1b766c1caf0cccb2cc0201c9af1ba85c48f1a4f551a43c878ec818d8bdbc53`
- `verification/referee-1-statement-precheck.log`: `7c5724f0ff4da0c99e8372238f8c32037fe8c7259974a24ec8306ab7e99c9f47`

## Remaining gates

No blocking statement changes requested. Approval applies only to the mathematical bytes above; later metadata scaffolding is outside this boundary. Proof bodies, final independent reviews, exported transitive axiom closure, and real isolated Linux Comparator/default-kernel replay with rejection controls remain separate gates. I have not claimed those future gates passed, and statement approval alone must not promote the canonical problem to Lean verified. Usage checked during this review: 30% of the main account window remains, above the user's 25% checkpoint threshold.
