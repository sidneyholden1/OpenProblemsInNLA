# RA-07 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `6a8aee632957b5a4fbc254d6bc12841ea658dcfe` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

All six exports prove the original affirmative second-difference claim for every positive real tuple and its stated index range. Elementary values are the actual powerset-cardinality sums: e0=1, higher coefficients vanish and every in-range coefficient is strictly positive. Finset product expansion and the actual iterated-derivative coefficient theorem give the generating-polynomial derivatives with factorials, rather than assuming coefficient identities.

The actual complex roots of the product lie in the strictly negative real ray. That open ray is proved convex, and Gauss-Lucas is applied only after positive degree is established at each derivative stage. Algebraic closure plus Splits.of_splits_map descends all complex roots to a genuine real splitting; the proof then enumerates the complete multiset of roots, retaining multiplicities. Reciprocal negatives produce a positive tuple of exactly n-d elements. Evaluating the complete factorization at zero fixes the constant, which is proved positive. This handles d=n and n=0 without treating an empty root set as evidence of a missing degree.

The finite-sum identity expands both ordered halves and cancels the diagonal, giving the exact unordered pair sum of positive weights times squared differences. For dimension at least two, explicit indices 0 and 1 prove the denominator strictly positive, so field simplification never divides by an unchecked zero. Constant scaling cancels in actual derivative ratios. The degree/index arithmetic ensures each relevant shifted tuple has at least two elements, including the final zero numerator. These identities yield the full original nonnegative second difference. Equal tuples legitimately give equality. No stronger index range, singular/nonpositive-input extension or probabilistic sampling claim is substituted.

This proof uses exact algebra, real/complex root geometry and LeanCert kernel trust audits only. It does not require a material numerical certificate. Reusing genuine Gauss-Lucas, splitting and derivative APIs avoids numerical root isolation and finite-sample proxies.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (6 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 6 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.RA07.elementary_values` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA07.generating_derivative_values` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA07.positive_derivative_factorization` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA07.power_sum_certificate` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA07.second_difference_certificate` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA07.errorSequence_convex` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `randomized-and-low-rank-approximation/RA-07/lean/Solution.lean` | `55ea9b34825481eb10fefc6409eab16db61849663849f2ca09f6ceb8a1857114` |
| `randomized-and-low-rank-approximation/RA-07/lean/NLA/RA07/Algebra.lean` | `1be33b680d0f66d793a564ec22aae8996474aa85f7699f4d1dff6639903cf013` |
| `randomized-and-low-rank-approximation/RA-07/lean/NLA/RA07/Definitions.lean` | `5eb47e2450eefe5a83e583173ac1de48c67be502a73f52cb4856a26c3fffb9ff` |
| `randomized-and-low-rank-approximation/RA-07/lean/NLA/RA07/Proof.lean` | `20c4d2a1078495b442f74126b42e0960462a1e82e3c5aec0b2c09065921dd21d` |
| `randomized-and-low-rank-approximation/RA-07/lean/NLA/RA07/Roots.lean` | `ccbb931696ed1fafcda2518daaccee8eacb201a10eaedefd694f573b44adecde` |
| `randomized-and-low-rank-approximation/RA-07/lean/NLA/RA07/Sums.lean` | `6a1410ed2efe6155f2f27c22b8afe37ffd0110812850f0d336c9ffee2dd8050b` |

Machine proof-checks SHA-256: `79036e0fc21f827bf9e424a3515115cf598620d60fd4a9e9ebd5fb650492bba7`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
