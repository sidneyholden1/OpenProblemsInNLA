# RA-20 independent proof referee 1 — 2026-09-14

PASS — complete local mathematical proof review of all 12 frozen exports, with no blocking finding. Linux Comparator and operational acceptance are separate gates.

This independent AI-agent review applies the relevant Tau Ceti adaptations in `docs/lean/REVIEW.md`: target fidelity, full scope, correctness, edge cases, proof trust, economical computation, actual library semantics, reuse and attribution. It is not official Tau Ceti endorsement or human peer review. Proof inspection began only after both statement approvals and the coordinator's frozen statement gate.

## Source and mathematical audit

I read every active project module in the table below and all Solution wrappers, independently of the other referee. All active bytes match preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, candidate `32e8d9416e0f6ae1735d4ea410113c0724afa102` and the statement gate. The source is deliberately not observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. RA-20 is absent from that older main; its preserved permanent target is reviewed here. The earlier statement review's complete canonical/informal-source and library audit is bound in the evidence and remains unchanged. This reverification does not newly author an existing proof.

The twelve exports prove the full joint four-formula conjecture false at n=s=3. Algebra starts with the actual rank-constrained symmetric hollow matrix variety. It proves det=2abc and both directions of membership, using actual width-two factorizations for rank≤2. It proves squarefreeness/radicality of abc and applies the actual complex Nullstellensatz to identify the entire vanishing ideal as a pullback. The surjective quotient map yields the coordinate-preserving algebra isomorphism; no proposed equation is assumed to define the original reduced variety.

Smooth proves genuine algebraic smoothness at the actual evaluation prime. Its localized presentation is surjective with principal kernel. At component intersections it uses the square-zero thickening P/(abc)² and the formal-smooth lifting criterion: a section would force 1=0 after evaluation, with cancellation justified in the localized domain. Away from intersections, the two nonzero coordinates are units, the remaining coordinate vanishes, and the constructed chart is an actual local algebra retraction from a formally smooth polynomial localization. Transport through the proved algebra equivalence and uniqueness of the quotient point prime gives the complete smooth-locus equivalence, including the origin and axes. A source comment says “complete local ring”; the actual type is ordinary Localization.AtPrime, with no adic completion, and that is the semantics reviewed here.

Tangent proves a substitution/product rule and uses the entire ideal pullback to characterize every tangent direction, including the larger singular tangent spaces. Differential supplies HasFDerivAt for the full complex-bilinear sum of all matrix-entry squares, so fderiv's default-zero branch is not exploited. It differentiates the actual continuous-linear-map-valued gradient for the Hessian and proves the nondegeneracy of 4I in each chart. Symmetry doubles each off-diagonal contribution; arbitrary data diagonals remain included.

Critical checks the three full smooth charts, every complex tangent direction, both directions of the critical-set characterization and injectivity of the candidate enumeration. Count computes the actual subtype cardinal as three. Generic restricts an arbitrary exceptional polynomial to all six symmetric coordinates, multiplies it by the three off-diagonal variables, and uses polynomial evaluation over the infinite domain ℂ to produce a datum avoiding both zero sets. This proves intersection with every competing nonempty principal open, so no alternate generic count four can survive. The full conjecture is then contradicted without assuming generic-count uniqueness.

LeanCert performs kernel trust audits only; no numerical interval is needed for exact algebra/calculus/cardinality. The two fresh letI style warnings are nonmathematical. Nondegenerate Hessians are exported, but a separate scheme-theoretic multiplicity theorem and corrected remaining formulas are not claimed. Mathematical credit remains the Codex automated maintainer audit, with the conjecture due to Kubjas–Sodomaco–Tsigaridas.

## Fresh execution, trust and evidence

I inspected the coordinator's fresh macOS aarch64 `lake build Solution` receipt and entire log: exit 0, 3494 jobs. I also read referee 2's fresh consumer script, receipt, all printed export types and all axiom closures: exit 0. Every export depends exactly on `propext`, `Classical.choice`, `Quot.sound`. These are their executions, not independent builds by me. I independently checked their script/log hashes, matched the entire Comparator export list and audited the source-to-target paths. No historical PASS is used as fresh execution evidence.

LeanCert kernel trust auditing only; exact symbolic algebra, calculus and cardinality, no numerical interval theorem.

The relevant pinned Mathlib APIs were read directly; additional CFC, localization, formal-smoothness and polynomial-evaluation APIs are hash-bound where used. Whole library hashes identify the inspected declarations and their proofs; this does not claim every dependency line was read. The comment-aware active-source scan found no holes, custom axioms, native_decide, unsafe or implemented_by. Challenge is outside the active import closure. All frozen boundary and statement-attachment hashes were rechecked.

[referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `37893ca46a71726cfb3276f5864ecf350f515a2ed84af5b6e624a7094b9969fe`, records the exact active closure, boundary files, additional API hashes, permitted axiom lists and fresh build/consumer/certificate attachments. The independent exact diagnostics from the statement stage remain supplementary, not substitutes for the checked proof. George Stepaniants retains original formalization authorship, Caltech affiliation and AI-assistance disclosure. Source mathematical and library credits are preserved.

No authored proof, metadata, canonical target or frozen statement evidence was modified. This PASS approves the reviewed mathematical implementation and local proof trust. It does not certify the separate Linux sandbox, rejection controls, Comparator identity replay or publication; those require their own actual retained evidence.

## Exact active source hashes

| Source | SHA-256 |
|---|---|
| `randomized-and-low-rank-approximation/RA-20/lean/Solution.lean` | `755a58cc081172804c644ea83518581235763a6ecefcbff6c92f131ca44c32b5` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Proof.lean` | `d3cb0dab572eb54795e6568c717e9e6f8200eb20f299e319fc3be36bbe8aaea1` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Differential.lean` | `8e24af9b30b668fd1c6bfc3799fe6d8771e4a6e96124087752a02f7b4d913ec7` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Definitions.lean` | `a649164ee7f11e88d8bfae4167ee0d9b9252a8683f253ab5a69981cde0e7cf94` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Count.lean` | `99e44e2ec0d376cb346822c8f5a7edcc72c78448083361e5b4f2ea3aceb92c96` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Generic.lean` | `47676372aa8e028a2c12bf6c23951b0edf5b7404a18abd24487d36399b7fb007` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Critical.lean` | `e8b2e3646d4b1f5e41e35ae4e23ba55d758cb6e48d125643d02eb1d51cab2040` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Tangent.lean` | `b03b6a1112737372072832d89b17ff0e19e00f631a925252269b75af3c44e178` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Algebra.lean` | `67adf1643bd62089a62d857c404bdb5ee1bbbd192984ed5f1169b8c5ec71f5f1` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/Smooth.lean` | `99ab24934f75382e9bad4a8e84945d0f1e14123804d5172a66b0da17a9eceb88` |
| `randomized-and-low-rank-approximation/RA-20/lean/NLA/RA20/SmoothTransport.lean` | `0e7717ac9e55597ed69a816f44194af569ac7b092ceb4f9231ea86e4c7ad894f` |
