# IE-18 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `3f48f1610726bc183fc71e0b1f4597dacba588e9` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

The three exports cover exact recurrence data, an admissible spectral counterexample and the full four-step conjecture negation. Both residual-map evaluations follow the actual matrix-vector and dot-product definitions. Nonzero initial/intermediate vectors and exact positive denominators 61/50 and 1381/93025 prevent zero-branch or total-division artifacts. Actual squared norms and their ratio are computed from all coordinates.

The spectral proof uses the true diagonal spectrum, positive definiteness of both M and I-M, and exclusion of eigenvalue one. The actual Mathlib eigenvalue ordering is never guessed: membership in the spectrum bounds every chosen pair, while two unequal spectrum values supply distinct eigenvalue indices attaining the finite maximum. Thus pairMaximum is genuinely 1/121, including its multiplicity/index semantics. The Euclidean norm is the square root of the coordinate-square sum. The proof squares that already-squared pair bound again to 1/14641, compares it with 1920682/21289638243, and uses nonnegative norms to obtain the strict unsquared amplification gap. A genuine nonzero-vector member of the amplification set then contradicts IsGreatest's upper-bound obligation; no attainment of the true maximum is needed to refute the proposed one.

The material scalar theorem is invoked through `leancert (trust := kernel)`. Inspection of its actual printed term shows Mathlib NormNum exact rational-comparison constructors, including a reflexively checked integer inequality; it is not a dyadic interval certificate. This is an optimized exact arithmetic route within LeanCert, plus explicit kernel trust audits. It would be inaccurate to describe this project as using interval enclosure for this point. All quantities and bridges match the source counterexample; there is no diagonal restriction on the universal target.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 3 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.IE18.residual_certificate` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE18.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE18.not_fourStepConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `linear-systems-and-elimination/IE-18/lean/Solution.lean` | `d257fd0b3def07c4503f2e084407116661cac5e556d7fe46573c9f7f78c7c0c3` |
| `linear-systems-and-elimination/IE-18/lean/NLA/IE18/Definitions.lean` | `dc32a03d0ab95a1b3f41f864f90d30d56c3dd041330015caa059e253ff47b28d` |
| `linear-systems-and-elimination/IE-18/lean/NLA/IE18/Proof.lean` | `0244e39c88101ab7a998bb0c5da56549d668d46ae068e4fc2ef5067fabdf4f73` |

Machine proof-checks SHA-256: `08a222b7dee814c1d6c8cd6de516323dd8d46f54b85f09381cffec64369a895f`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
