# MI-08 Lean proof and verification evidence

The stated fixed-list partial result is Lean verified; the canonical problem remains Partially resolved. The fixed-list feasibility characterization by rectangular sign matrices is proved for every positive dimension and row count. The rank and divisibility obstructions and an explicit order-twelve sign matrix establish that the actual minimum fixed pinching length is 12 for every dimension from 9 through 12. The source’s adaptive comparison is not formalized, and the all-dimension optimum remains open.

Mathematical result: Matthew J. Colbrook. Formalization: Sidney Holden, Center for
Computational Biology, Flatiron Institute, Simons Foundation, with OpenAI Codex
assistance. Original source authors and library credits remain in formalization.yaml,
NUMERICAL_TARGETS.md and the canonical page. No external human review or
source-author endorsement is claimed.

The four checked exports are `NLA.MI08.fixed_sign_equivalence`, `NLA.MI08.design_obstructions`, `NLA.MI08.hadamard_twelve`, `NLA.MI08.finite_minimums`.
Both independent statement reviews preceded implementation, both final proof
reviews PASS, and all exported transitive axiom closures contain only propext,
Classical.choice and Quot.sound. LeanCert uses kernel trust. Exact algebra and
finite certificates avoid unnecessary interval computation.

## Reproduce the actual Linux verification

The successful [Linux run](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34862187226) checked immutable revision
`a66e142cbe7907db6594ef57c7f542c3d33ad704`. Use non-root Linux with the documented isolation prerequisites
in tools/lean/HARNESS.md, check out that revision, and run from the repository root:

```sh
tools/lean/bootstrap.sh /absolute/path/to/nla-lean-tools
tools/lean/verify.sh matrix-inequalities-and-norms/MI-08/lean /absolute/path/to/nla-lean-tools
```

The verifier includes actual sandbox, raw-kernel and Comparator rejection
controls before checking all four declarations. The original artifact, all
45 exact checked inputs, receipt and independent operational audit are in
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
