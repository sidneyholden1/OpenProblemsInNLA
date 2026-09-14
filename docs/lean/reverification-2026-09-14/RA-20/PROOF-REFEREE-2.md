# RA-20 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `32e8d9416e0f6ae1735d4ea410113c0724afa102` preserves the reviewed mathematical bytes. Mathematical credit remains the repository Codex automated maintainer audit; the conjecture is due to Kubjas, Sodomaco and Tsigaridas. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee. RA-20 has no canonical page at the observed older main; the report makes no equivalence claim to an absent page.

## Actual proof and full target

The twelve exports refute the complete original four-formula generic critical-count conjecture at n=s=3. Algebra.lean proves rank≤2 from explicit width-two factorizations when abc=0 and the converse from determinant≠0 implying full rank. Every actual hollow symmetric variety point is recovered. The entire nine-variable vanishing ideal is proved equal to the pullback of (abc): squarefreeness gives radicality, the Nullstellensatz identifies the whole vanishing ideal, and a surjective polynomial pullback yields a coordinate-preserving isomorphism to C[a,b,c]/(abc). This is not a presentation assumed as the definition.

Smooth.lean and SmoothTransport.lean prove the actual local algebraic smooth-locus equivalence. At an intersection, a hypothetical splitting of P/(abc)²→P/(abc) forces lifted coordinates a+abc*u etc.; cancellation in the localized polynomial domain and evaluation at the point gives 1=0 because all pairwise products vanish. The proof explicitly verifies the localized presentation's surjectivity/kernel, evaluation map and nonzero product. At exactly one zero coordinate, the other coordinates are units, the relation kills that coordinate, and the constructed chart gives a retraction from a formally smooth localized polynomial algebra. Pinned Mathlib's square-zero lifting criterion, localization smoothness and transport by algebra isomorphism supply the genuine semantics. Quotient evaluation primes are constructed and identified by surjective comap. Origin and axes are excluded by proof, not assumptions.

Tangent.lean proves substitution and product rules for the formal derivative and handles every polynomial in the full ideal, including singular points. Differential.lean constructs actual continuous-linear matrix coordinate maps and HasFDerivAt proofs, so totalized fderiv is not exploited at nondifferentiable inputs. The full complex bilinear Frobenius objective counts all nine entries; its derivative is 2 sum(X−U)Z, and each actual two-coordinate component chart has the second Frechet derivative 4I with trivial kernel. Critical.lean then covers all complex tangent directions and exhausts the smooth critical set by three actual matrices, distinct on the nonzero off-diagonal open set.

Generic.lean keeps all six symmetric-data coordinates, proves reconstruction, and uses the infinite-domain polynomial identity theorem to intersect that open set with every arbitrary nonempty principal open. Count.lean proves actual Cardinal.mk=3, rules out generic count four on any qualifying open, and contradicts the original formula. No Nat.card collapse, chosen single datum, different metric or hidden graph/diagonal restriction replaces the generic target. The optional numeric diagnostic is supporting exact algebra only; the proof itself is symbolic, with LeanCert kernel trust audits and no artificial interval step.

Mathematical credit is the repository's Codex automated maintainer audit; the conjecture remains attributed to Kubjas, Sodomaco and Tsigaridas. George Stepaniants retains the AI-assisted formalization credit. Nonblocking wording: one existing comment says 'complete local ring', but ABCLocal and ABCPolynomialLocal are ordinary Localization.AtPrime types, not adic completions. The proof and this review rely on those actual localizations. No source edit was made. The result does not claim corrected generic formulas for all other orders or a general multiplicity scheme.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (11 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt, success log and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 12 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear in those closures. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All active project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.RA20.hollow_variety_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.reduced_coordinate_ring` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.algebraic_smooth_locus` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.algebraic_tangent_space` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.full_frobenius_differential` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.hollow_distance_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.generic_critical_locus` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.component_hessians` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.generic_data_intersection` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.generic_count_three` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.generic_count_not_four` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA20.not_criticalCountConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `randomized-and-low-rank-approximation/RA-20/lean/Solution.lean` | `755a58cc081172804c644ea83518581235763a6ecefcbff6c92f131ca44c32b5` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Algebra.lean` | `67adf1643bd62089a62d857c404bdb5ee1bbbd192984ed5f1169b8c5ec71f5f1` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Count.lean` | `99e44e2ec0d376cb346822c8f5a7edcc72c78448083361e5b4f2ea3aceb92c96` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Critical.lean` | `e8b2e3646d4b1f5e41e35ae4e23ba55d758cb6e48d125643d02eb1d51cab2040` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Definitions.lean` | `a649164ee7f11e88d8bfae4167ee0d9b9252a8683f253ab5a69981cde0e7cf94` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Differential.lean` | `8e24af9b30b668fd1c6bfc3799fe6d8771e4a6e96124087752a02f7b4d913ec7` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Generic.lean` | `47676372aa8e028a2c12bf6c23951b0edf5b7404a18abd24487d36399b7fb007` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Proof.lean` | `d3cb0dab572eb54795e6568c717e9e6f8200eb20f299e319fc3be36bbe8aaea1` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Smooth.lean` | `99ab24934f75382e9bad4a8e84945d0f1e14123804d5172a66b0da17a9eceb88` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/SmoothTransport.lean` | `0e7717ac9e55597ed69a816f44194af569ac7b092ceb4f9231ea86e4c7ad894f` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Tangent.lean` | `b03b6a1112737372072832d89b17ff0e19e00f631a925252269b75af3c44e178` |

Machine proof-checks SHA-256: `002030ce01b79127a1ad76a3bd9dc890dff5cf0169d835d45f86b87c4e343462`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
