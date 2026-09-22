# IE-13 universal upper bound

This is an author implementation guide, not an independent referee report. The mathematical argument follows Matthew J. Colbrook's IE-13 manuscript. The generic entrywise and actual-path arguments adapt the IE-14 Lean development. The exact recurrence and envelope proofs here are new for the arbitrary band widths in IE-13.

`NLA.IE13.upper_bound_proved` has the exact frozen `Challenge.upper_bound` signature. It assumes only the original band/nonsingularity condition and the literal `isPath` predicate. All complex entries, all maximal-pivot ties, zero band widths, all admissible dimensions, and all intermediate entries remain quantified.

The active upper-bound closure is:

- `Base`: actual finite entry maximum and growth ratio; positive denominator from nonsingularity; norm bound for the literal row-swap Schur update.
- `Recurrence`: positivity, monotonicity, initial powers of two, finite sliding-window identities for `bandRec`, and the source witness's exact forward-substitution recurrence.
- `Profiles`: the finite envelope starts at `(1,0,...,0)` and updates to `(v₀+v₁,...,v₀+vₚ,1)`. Its first entry equals `bandRec p t` for positive time; the `p=0` envelope stays at one.
- `Budgets`: a sorting-free equivalent bound controls every subset by the corresponding envelope prefix. The pivot is adjoined to the swapped survivor subset, which has no repeated indices. The actual pivot bound and the subset sum together give the exact next prefix; the fresh row costs at most the original maximum.
- `Front`: future rows stay literally untouched, so any nonzero pivot lies in the finite front. A distant column is zero before its original upper-band arrival. Both facts are derived by induction through the actual Schur recurrence, including row swaps.
- `PathBudget`: rows outside the finite matrix are padded with zero solely for the auxiliary envelope. The original in-range values and swaps are proved identical to the actual matrices. The newly arriving row remains an original row and has norm at most `entryMax A`.
- `Upper`: early columns start from the all-ones envelope; distant columns start from a single fresh nonzero position. Each active old-front entry is bounded by the head of an envelope with time at most `p+q`. Untouched rows and padded zeros satisfy the same bound. The finite maximum and positive denominator give the exact growth inequality.

No numerical interval search is needed: all certificate obligations are finite sums, exact natural arithmetic, and real/complex norm inequalities. LeanCert's kernel trust audit is run on the actual final upper theorem; no `native_decide`, custom axiom, opaque numerical oracle, or Challenge import is used.

The normal build receipt is `verification/upper-build-final.log` (3083 jobs, success). The separate author consumer `verification/UpperAuthorAudit.lean` repeats the frozen upper signature, prints its actual axiom closure, and runs `#assert_trust ... kernel`; its log is `verification/upper-author-audit.log`. This establishes the local upper theorem only. Witness attainment, the completed Solution, independent final reviews, and Linux Comparator remain separate gates.
