# KE-04 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below.** No blocking fidelity or scope issue found.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not an implementer of this upstream proof. Date: 2026-09-14. Phase: new independent boundary review before this campaign's proof inspection, under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not an official Tau Ceti assessment or human peer review. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

I read the complete canonical page and full informal source identified below, the complete numerical boundary, Definitions and all 24 Challenge signatures. I independently compared the current three mathematical boundary files byte-for-byte with the immutable upstream commit: unchanged. Imported definitions/APIs were inspected where their semantics matter. I have not inspected the existing implementation modules for this campaign. This reviews an existing authored proof boundary; it does not pretend that the upstream proof has not yet been written. Historical statement-stage prose remains preserved as historical evidence.

## Fidelity, scope and proof obligations

The final `BlockLanczosConjecture` retains arbitrary real symmetric matrices, arbitrary dimensions/starting block with actual linearly independent columns, every largest-full-iteration index, every 1 <= k < j <= s, every 1 <= i <= (k-1)p, and independently chosen orthonormal Krylov bases. The stronger `FullPrefixBlockLanczosClaim` is separately connected to that exact target. The maximal-index predicate means actual maximality of finrank(K_s)=sp, not a chosen smaller prefix. An explicit existence contract for positive p and full starting rank prevents a merely empty maximal-index quantification.

Krylov spaces are actual spans of block-power columns and the action is Mathlib's Euclidean linear map. Full block dimension contains only finrank equality. The separate nesting, rank/independence, prefix, coefficient injectivity and basis-existence contracts expose the necessary bridges. Over the reals Hermitian means symmetric; a separate semantic contract records this. Compression is Q^T A Q and the frame projector is QQ^T. No orthogonality or compatibility between the two independently chosen bases is assumed.

I checked the actual pinned spectrum API: the symmetric endomorphism eigenvalues are antitone, and `Fin.rev` with matching eigenbasis reversal supplies increasing order. The boundary requires characteristic-root MULTISET equality and basis independence of the full ordered eigenvalue function, preserving repeated eigenvalues. Endpoint conversion uses i-1 and i+p-1; an explicit index theorem prevents the total helper's out-of-range zero from entering the target. p=0 and k=1 have empty admissible i ranges; positive-p maximality existence avoids a false assertion at p=0. Both inequalities remain strict, with no separated-endpoint or simple-spectrum premise.

All 24 contracts match the complete source quadratic argument. The compressed quadratic is the compression evaluated on its subspace and extended by zero, not an ambient polynomial with an extra complement term. Dimension p+1 versus codimension p supplies a nonzero intersection vector; PSD zero-form/kernel equivalence and later Krylov containment supply q(A)x=0; the nonannihilation theorem derives the contradiction from independent columns through A^kV. None of these conclusions appears inside the data definition. Equal endpoints remain included and are ruled out by the same argument. Pure exact algebra and kernel trust auditing are appropriate; no numerical intervals are needed. Finite precision is excluded. Colbrook retains mathematical credit, Simonova/Tichy conjecture credit, and Stepaniants formalization credit.

## Mechanical evidence and limitations

I inspected the coordinator's fresh `challenge-local.log` and `challenge-local.json`, independently verified their digest correspondence, and observed successful exit 0 with exactly 24 intentional Challenge placeholder warnings. Log SHA-256: `35bd459d8af392f76af79832e2a5c891e900cd8770d054288dd85723c0318158`. This was Lean 4.33.1 on macOS aarch64 with the shared pinned dependency cache, not Linux Comparator execution; I did not rerun it. Typechecking establishes well-formed statement types, not these mathematical conclusions. The Comparator configuration names all 24 contracts, no definition holes, and only propext, Classical.choice and Quot.sound. No fresh proof acceptance or Linux run is claimed by this report. Existing upstream reviews and runs are preserved, not treated as substitutes for this campaign's separate proof and operational checks.

Only this new report was written. No existing mathematical source, historical report, manifest, canonical target, ID or path was changed. A second independent boundary approval remains a coordinator gate before proof inspection.

## Exact reviewed source hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `eigenvalues-and-inverse-problems/KE-04/README.md`: `00f696298022dadf0aaf3e97e943682fcb9457b82b41a2d1e86331c6885f678d`
- `eigenvalues-and-inverse-problems/KE-04/solution.md`: `dd57fdb065f83dd9a5a4ac7946e3cd2801ec495b02c81f66110117f699fbaad6`
- `eigenvalues-and-inverse-problems/KE-04/lean/NUMERICAL_TARGETS.md`: `ad963526a371cdfee8eaaf179674d5cabd2a1d5a9ae5b123c96ac2f2b4271c47`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Definitions.lean`: `ae1baccc0cb622f83103eff8bb4a5efe4cd9a3bae4822ccca38da29554ae9ca4`
- `eigenvalues-and-inverse-problems/KE-04/lean/Challenge.lean`: `a27de227d483072e395b6658a97cbf31296503c7fab36e5f9dbf248b2efa299e`
- `eigenvalues-and-inverse-problems/KE-04/lean/comparator.json`: `c0c7086cb81abe8f422762d0db2cc55419828f08ba80d33f9157cb3f396a8b8e`
