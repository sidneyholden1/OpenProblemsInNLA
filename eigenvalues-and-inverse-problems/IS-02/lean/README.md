# IS-02 Lean proof and verification evidence

The complete original necessary-locus conjecture has a Lean-verified negative answer. The complete spectral-uniqueness locus implication is disproved at order four. The actual symmetric stochastic witness has positive trace and the specified characteristic polynomial. Every admissible isospectral competitor is proved permutation-similar to it, while the witness is excluded from every proposed closed segment and from the actual extreme points. No competing matrix is restricted to a preselected support pattern.

Mathematical result: Matthew J. Colbrook. Formalization: Sidney Holden, Center for
Computational Biology, Flatiron Institute, Simons Foundation, with OpenAI Codex
assistance. Original source authors and library credits remain in formalization.yaml,
NUMERICAL_TARGETS.md and the canonical page. No external human review or
source-author endorsement is claimed.

The four checked exports are `NLA.IS02.witness_certificates`, `NLA.IS02.spectral_uniqueness`, `NLA.IS02.locus_exclusion`, `NLA.IS02.counterexample`.
Both independent statement reviews preceded implementation, both final proof
reviews PASS, and all exported transitive axiom closures contain only propext,
Classical.choice and Quot.sound. LeanCert uses kernel trust. Exact algebra and
finite certificates avoid unnecessary interval computation.

## Reproduce the actual Linux verification

The successful [Linux run](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34862184054) checked immutable revision
`b71728d93b1c376ee34a6fd04b4661c604704a14`. Use non-root Linux with the documented isolation prerequisites
in tools/lean/HARNESS.md, check out that revision, and run from the repository root:

```sh
tools/lean/bootstrap.sh /absolute/path/to/nla-lean-tools
tools/lean/verify.sh eigenvalues-and-inverse-problems/IS-02/lean /absolute/path/to/nla-lean-tools
```

The verifier includes actual sandbox, raw-kernel and Comparator rejection
controls before checking all four declarations. The original artifact, all
47 exact checked inputs, receipt and independent operational audit are in
verification/linux-2026-09-14. Local macOS builds are separate development checks.
Later publication metadata is not represented as the original checked input.

Toolchain: Lean 4.33.1. Mathlib is pinned at
`0df444a360eaa60ab8c11dca51a86af692955474`; LeanCert at
`621a43d7cf21f87872392a01e874f2f1dbddc926`. Comparator and its exporter follow
the hash-locked shared tools/lean/source-lock.json. Exact HTTPS dependencies
are committed in lake-manifest.json. Local development shares a pinned cache.

The official v0.4 formalization.yaml and comparator.json select all four results
with no replaceable definitions. Original statement and proof-review wrappers
are preserved in reviews/statement-review-snapshot and reviews/proof-review-snapshot
where applicable; original hash manifests remain unchanged. Shared provenance
and licenses: tools/lean/NOTICE.md and the project LICENSE.
