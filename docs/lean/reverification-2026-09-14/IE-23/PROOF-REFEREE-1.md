# IE-23 independent proof referee 1 — 2026-09-14

PASS — complete local mathematical proof review of all 8 frozen exports, with no blocking finding. Linux Comparator and operational acceptance are separate gates.

This independent AI-agent review applies the relevant Tau Ceti adaptations in `docs/lean/REVIEW.md`: target fidelity, full scope, correctness, edge cases, proof trust, economical computation, actual library semantics, reuse and attribution. It is not official Tau Ceti endorsement or human peer review. Proof inspection began only after both statement approvals and the coordinator's frozen statement gate.

## Source and mathematical audit

I read every active project module in the table below and all Solution wrappers, independently of the other referee. All active bytes match preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, candidate `4e07fd953ec0d53915af22cc0a30c821c207e3af` and the statement gate. The source is deliberately not observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. The original canonical mathematics agrees with that older main, with rendering differences only. The earlier statement review's complete canonical/informal-source and library audit is bound in the evidence and remains unchanged. This reverification does not newly author an existing proof.

The eight exports cover genuine induced-norm semantics, the rational matrix/inverse identities, fourth-power control, complex action identities, actual attainment, exact suprema, global minimizers and the complete original uniqueness negation. Norms proves positive denominators for every nonzero complex vector, bounds the entire ratio set by a finite entry sum, supplies a nonzero input when m≥1, and obtains the actual IsLUB. The zero input is handled separately. There is no totalized-supremum or zero-division shortcut, including the harmless n=0 extension of the generic semantics.

Matrices proves both inverse products for the actual Gram matrix, its unit property and genuine inverse, the actual Moore–Penrose formula, AB=AX=I, rank two using the right inverse, and distinctness. FourthPower uses nonnegative nested square roots and the exact fourth-power SOS, with explicit squared/unsquared bridges. Actions expands real and imaginary parts, proves the contraction/isometry identities, and derives the norm lower bound for every complex right inverse Y from A(Yz)=z. It does not restrict competitors to a guessed family.

The nonzero z=(1,−1) actually attains the common value 2^(1/4). Minimizers proves both full real suprema equal that value, proves its lower bound for every complex right inverse and supplies membership for IsLeast of the entire feasible value set. Instantiating the universal conjecture at m=2,n=3,p=4 gives a direct contradiction. Solution's eight wrappers restate the frozen Challenge signatures. Pure exact algebra and finite norm identities avoid interval work; LeanCert performs the exported kernel trust audits.

The independent statement-stage Fraction/SOS diagnostics remain supplemental, now connected to the checked analytic proof. The source's all-p formulas, full minimizer classification, endpoint results, higher-dimensional families and different XA objective remain excluded. Colbrook and the source-attributed Dokmanić–Gribonval example retain their mathematical credit.

## Fresh execution, trust and evidence

I inspected the coordinator's fresh macOS aarch64 `lake build Solution` receipt and entire log: exit 0, 2394 jobs. I also read referee 2's fresh consumer script, receipt, all printed export types and all axiom closures: exit 0. Every export depends exactly on `propext`, `Classical.choice`, `Quot.sound`. These are their executions, not independent builds by me. I independently checked their script/log hashes, matched the entire Comparator export list and audited the source-to-target paths. No historical PASS is used as fresh execution evidence.

LeanCert kernel trust auditing only; all matrix and norm calculations use exact symbolic algebra, no numerical interval theorem.

The relevant pinned Mathlib APIs were read directly; additional CFC, localization, formal-smoothness and polynomial-evaluation APIs are hash-bound where used. Whole library hashes identify the inspected declarations and their proofs; this does not claim every dependency line was read. The comment-aware active-source scan found no holes, custom axioms, native_decide, unsafe or implemented_by. Challenge is outside the active import closure. All frozen boundary and statement-attachment hashes were rechecked.

[referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `e29095e190af019d39b346c9eb00cfa1e734a3fcde1c5f0fc38c7b310671d94e`, records the exact active closure, boundary files, additional API hashes, permitted axiom lists and fresh build/consumer/certificate attachments. The independent exact diagnostics from the statement stage remain supplementary, not substitutes for the checked proof. George Stepaniants retains original formalization authorship, Caltech affiliation and AI-assistance disclosure. Source mathematical and library credits are preserved.

No authored proof, metadata, canonical target or frozen statement evidence was modified. This PASS approves the reviewed mathematical implementation and local proof trust. It does not certify the separate Linux sandbox, rejection controls, Comparator identity replay or publication; those require their own actual retained evidence.

## Exact active source hashes

| Source | SHA-256 |
|---|---|
| `linear-systems-and-elimination/IE-23/lean/Solution.lean` | `ce642354744645994d4462dff367595ba441781d19ed57a2dd99fe2303e5c671` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Proof.lean` | `2224a18d89621ef254e3a606b8e711e1576e1bb4e312365a9b4b4706eddc9ca6` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Minimizers.lean` | `9dcb508619e2a15c44f94687bbaf7f179c27d7e323e360f4535bea5641e82597` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Actions.lean` | `950fe455fba3a7af6e927c369ecfd4bf4cf8d68d230b1fab775d185fdc42c451` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/FourthPower.lean` | `bd0f3a858a5f12cec417f8b2be9bcce63fac4abde60b085fcf113aa192daafc6` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Norms.lean` | `2a3886e0db7f5ad8e2c0039bdfaf0e05d9f524c587973fc101de2200fda200d4` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Definitions.lean` | `1af986f21059b5b9862decf09366d3ea8dba0c965a5b8550b8d9a0fcc41af33f` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Matrices.lean` | `c7d97a3b225a7abdf39da15f6eb13caf2af171a4316bfa238782b0c430f37906` |
