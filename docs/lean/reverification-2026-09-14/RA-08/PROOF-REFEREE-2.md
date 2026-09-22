# RA-08 independent proof re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the original implementation. Protocol: `docs/lean/REVIEW.md`; Tau Ceti correctness, full-target fidelity, nonvacuity, proof quality, reuse, clarity and credit criteria are adapted without official endorsement.

**Verdict: PASS — no mathematical or trust blocker found in this frozen active proof.** This approves the unchanged authored proof after this campaign's two fresh statement approvals. It does not create a new proof or by itself certify a new Linux run.

## Actual proof path and scope

OrderedExistence correctly transports Mathlib's SORTED eigenvalues through its arbitrary reindexing to an ordered complete orthogonal decomposition, including zero dimension. SpectralCFC constructs a selected-basis star algebra hom on continuous functions over the actual finite spectrum and uses the genuine uniqueness theorem to identify it with cfc. Thus every chosen eigenbasis is valid, repeated eigenspaces are retained, off-half-line extension values are irrelevant, and the CFC junk fallback is excluded by self-adjointness and finite-spectrum continuity. Spectral transports the Euclidean operator norm through orthogonal conjugation and diagonal norm, then proves both tails from the antitone family; it does not use a default matrix norm. The Rayleigh estimate uses actual L2 Cauchy-Schwarz and the continuous operator norm.

Witness proves exact projection identities, PSD complement, PSD order and positive definiteness of the unchanged rational matrix. Location excludes every actual eigenvalue in (1,17/16) using removal of the high coordinate, a true quadratic compression bound and its eigenvector equation; no numerical spectral premise occurs. Fourth uses two rectangular dimension-kernel arguments and all-basis quadratic bounds to prove the actual fourth eigenvalue t for every selected basis. Tails then proves all-basis truncation identities and both optimal errors exactly t. Scalar proves a degree-six minorant by a positive-coefficient shift on the entire unbounded high spectral component, while Polynomial identifies its genuine CFC; Functional applies pointwise SAME-MATRIX cfc_mono on the now-proved spectrum. This is not operator monotonicity of min(x,1).

Certificate performs three rational matrix-vector products, uses symmetry to turn the squared cubic matrix's Rayleigh value into a vector squared length, and proves the exact strict gap identity. Numerical's actual printed LeanCert term checks constant zero below the rational witnessGap on [0,0], precision -53/depth 10. Its auxiliary checkStrictUpperBoundDyadicChecked = true is proved by of_decide_eq_true (id (Eq.refl true)). The positive sign is materially consumed by counterexample_proved through the Rayleigh comparison. The final proof constructs genuine ordered data before specializing the complete conjecture at epsilon zero. All fourteen exported types match the reviewed contracts.

The computation is effectively minimized: no full degree-six matrix expansion, eigenvalue intervals or subdivisions. The selected CFC architecture explicitly credits Mathlib authors Jon Bannon and Jireh Loreaux and its Apache source. Mathematical counterexample credit remains Colbrook and formalization credit Stepaniants, with the original-question and actual contributor disclosures retained. The stronger source contour ratio, separate Nystrom sketch identity and nuclear extensions are correctly excluded; the full canonical implication is refuted.

## Independent checks actually performed

I read every active local module reachable from Solution, including Definitions and the public export wrappers: 17 files and 1818 source lines. Historical duplicate snapshots and unused files were excluded from this active-closure count. Every active source hash was independently compared with both upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the frozen `statement-gate.json`; all matched. The reviewed canonical/source/numerical boundary remains bound by `STATEMENT-REFEREE-2.md`.

I manually followed every Challenge export through its public declaration to the active implementation and independently verified that comparator.json lists exactly these 14 names, has no definition exceptions and permits exactly propext, Classical.choice and Quot.sound. The fresh `referee-2-export-audit.lean` consumer imports Solution, queries every actual type and transitive axiom closure, and applies LeanCert #assert_trust kernel to every export. I executed it with pinned Lean 4.33.1 on macOS aarch64; exit code 0. All 14 axiom outputs contain exactly the standard three, with no custom axiom, sorryAx or native/compiler trust. The active source scan likewise found no proof holes, unsafe implementations, external implementations or Challenge import. The scan is supplementary, not a replacement for the actual transitive audits.

I also inspected the coordinator's fresh successful full Solution build receipt and log, and independently verified its recorded log hash `ccc2cf5bce32a66d1d37f38c625defb4ef7d414e02c2043ea3403bb52a49c428`. That full build is the coordinator's run. My own run was the independent fresh export consumer/term inspection on its resulting local objects, not a second full source/dependency rebuild. For IS-03 and RA-08, the additional retained numerical-checker queries inspect the actual auxiliary Boolean certificate terms and also exit successfully. Relevant imported Mathlib facts and LeanCert trust/checker implementations were checked directly; pinned dependency axioms are covered transitively, rather than claiming a human-style read of all Mathlib.

Exact fresh evidence hashes and all per-export axiom results are in `referee-2-proof-checks.json`; the complete module roster is in `referee-2-active-inputs.json`. No authored Lean source, canonical target, configuration, publication metadata or historical evidence was altered. All inspection files live in this new external audit directory.

## Separate operational limits

The isolated Linux Comparator, full statement identity including definitions, default-kernel export replay, actual sandbox and rejection controls, artifact/source provenance and publication acceptance remain separate gates. This report does not substitute historical PASS text or a local consumer for those checks. It makes no human peer-review, Tau Ceti endorsement or novelty claim. Only the mathematical scope listed above is approved.

## Every reviewed export

- `NLA.RA08.orderedSpectral_exists`
- `NLA.RA08.orderedSpectral_semantics`
- `NLA.RA08.functionalCalculus_spectral`
- `NLA.RA08.spectral_tail_norms`
- `NLA.RA08.operator_rayleigh_bound`
- `NLA.RA08.witness_data`
- `NLA.RA08.witness_spectral_location`
- `NLA.RA08.minorant_scalar`
- `NLA.RA08.minorant_functional_calculus`
- `NLA.RA08.witness_tail_data`
- `NLA.RA08.witness_rational_certificate`
- `NLA.RA08.numerical_gap_positive`
- `NLA.RA08.counterexample`
- `NLA.RA08.not_concaveSpectralTransferConjecture`

## Exact active-source SHA-256 identities

| Repository-relative active file | SHA-256 |
| --- | --- |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Basis.lean` | `d8e6500500d2c8f42a7fbe60ef837372d56c65b25f6f0a3d50fdda12406942cc` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Certificate.lean` | `0b778f56004f1616d27d22df87ff8b041b7904348ff19449ccdb537400fe963b` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Definitions.lean` | `8c2f3a76e44730b1f9d5bc8e896070c10868bae817d0c3d11ace22b3c7d94c41` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Fourth.lean` | `e414ce445e90dda38d27df3fa7ec615d3b1da36406e61753978c242ee308965a` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Functional.lean` | `1ce46effb082c1719943700b3166a995b652efa3d95ff52ff9c1e249972590a9` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Location.lean` | `824dfeda0dec85e0588d8051ecbfc5684fb8311bed118a04c1dbd36b74910537` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Numerical.lean` | `91d63b0a0cc41d4edde6782e8ff7726ebcbead479d2d56ee566968bc91f1b989` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/OrderedExistence.lean` | `4da2bb55befc17bca7d520fbae186aafede693927bcb2768e810790a0a3de37b` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Polynomial.lean` | `126f5035af58b4bf070132deca3728988170379d12be3ae05ca4e8e1b1798445` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/ProjectionNorm.lean` | `a825d41bcee3599049bb7e97bd1354377a7f0fb76caa185268c6b1cd658a699d` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Proof.lean` | `8e225fd88e4fb1d546a26241f835dca9ee08756cc52e3f7fe640ba8b11cf8318` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Scalar.lean` | `8dae02527bfb5592a965a9cd73df20974c314c75c38d414248879719c11c063f` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Spectral.lean` | `8b700ff01b12e8d37c330ebbdb799a61af766483606e1870f555a6d182ca8833` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/SpectralCFC.lean` | `df90bbcab9837df4b0c51de0a98de4795745b204b1f58ab7690e4707ab0d59d6` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Tails.lean` | `5bce3453792e45ec9b74e86648092090738254fa08ea5e9b488b90c32ea84449` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Witness.lean` | `b6c03b390059df9ecc5f2fcf5899869d4dbf3d959f05a0d2dfbad858fd6c3420` |
| `randomized-and-low-rank-approximation/RA-08/lean/Solution.lean` | `7dc0f17661a7eead3e4555bbc692ebcc0add5e10b8c6414d51f2cd43c69730cc` |
