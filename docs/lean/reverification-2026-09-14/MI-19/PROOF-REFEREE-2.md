# MI-19 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `6f4c39feaa5ae494168dcc55af250b2acf126a02` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

Both exports preserve the full complex PSD subset conjecture. The proof identifies the actual Gram factor by all entries and invokes Mathlib's conjugate-transpose Gram positivity, giving positivity for every complex vector. Enumeration uses the actual permutation decomposition equivalence; it computes all 24 permutations with their original inversion counts and filters exactly the six preserving the interior singleton. This avoids an unjustified relabeling of q-inversions. Full and restricted sums have zero imaginary parts and exact gap -3235575/16384 at q=7/8; complex order is then reduced through its real embedding. The witness subset is nonempty and proper, every admissibility obligation is supplied, and the strict reverse comparison directly refutes the full universal claim. No block-product proxy or finite-sample assumption enters.

The material strict_scalar_gap was printed: leancert (trust := kernel) selects Mathlib NormNum rational comparison constructors ending in Eq.refl true. It is exact kernel arithmetic, not a dyadic interval calculation. Gram reduction, finite permutation equivalences and a single tiny scalar inequality appropriately minimize computation. Original q-permanent and subset conjecture credit and Colbrook's counterexample credit are preserved.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 2 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.MI19.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI19.not_subsetConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-19/lean/Solution.lean` | `18bf53ea1d745b4488718297559c3c77e3bcb902596b9c9aae5f448bdcb800c4` |
| `matrix-inequalities-and-norms/MI-19/lean/NLA/MI19/Definitions.lean` | `170e406d1f6bf0ca60e5b65998308b030cf08cc0def51c25c9860524ad3441ac` |
| `matrix-inequalities-and-norms/MI-19/lean/NLA/MI19/Proof.lean` | `53ab38bfef6e52f6c039eba5056659be43f9b8e7a7b3453a62769dc3f0ef3c37` |

Machine proof-checks SHA-256: `57cbeeac2073f8d7b2fe2dbdae75951c54044173f0b180689f68182fc0d44a85`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
