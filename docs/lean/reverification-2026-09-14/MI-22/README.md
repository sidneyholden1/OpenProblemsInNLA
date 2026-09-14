# MI-22: fresh independent reverification — PASS

This is an additional independent review and Linux replay of an existing authored
formalization, requested by Sidney Holden on 2026-09-14. It is not a new proof or
a new solved-status claim. Preserved authored source: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.
Current upstream main was observed at the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`;
this campaign does not identify the preserved source as current upstream main.
The preserved canonical target and its relation to the older main are recorded in
[SOURCE-PROVENANCE.json](SOURCE-PROVENANCE.json). The original target agrees mathematically across the two revisions.
George Stepaniants retains formalization credit; all mathematical source credits,
canonical pages, metadata and historical evidence remain unchanged.

- Two fresh independent AI-agent statement reviews and two proof reviews: PASS.
- Fresh local Challenge and Solution builds, plus independent export/type/axiom
  queries for all **8** configured declarations: PASS.
- [Fresh Ubuntu Comparator and default-kernel replay](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34900776190): PASS at
  `c08c30f050524f79ef2cdbb001babcd0e93876ba`. No definition exceptions; only `propext`, `Classical.choice`
  and `Quot.sound` are permitted.
- Actual per-project sandbox, kernel and Comparator rejection controls: PASS,
  including rejected `sorry` and native-compiler axioms.
- Original artifact digest matches GitHub; all **514** input hashes
  match the exact tested Git objects. See [Linux receipt](linux/RUN.json),
  [independent operational review](OPERATIONAL-REFEREE-2.md) and
  [coordinator checks](ROOT-LINUX-CHECKS.json).
- Original `formalization.yaml` validates against the pinned official v0.4 schema;
  permanent-ID validation and tests pass.

The reviewed project uses pinned public dependencies and the official Mathlib
cache. A full dependency-source rebuild is not claimed. LeanCert use is documented
per project in the proof reviews, including actual kernel trust audits and any
material numerical certificate. No interval certificate is claimed for a purely
exact algebraic proof.
These are AI-agent reviews applying the repository's Tau Ceti adaptation, not
external human peer review or official Tau Ceti endorsement.

This publication adds only this separate audit record outside the tested project.
The one neutral campaign notice under the project's reviews directory was already
part of the tested commit. Thus every tested project byte stays identical. The
original ZIP and active source copies are retained here; historical nested inputs
remain available in the immutable Git ancestry rather than being copied recursively.

See [proof acceptance](PROOF-ACCEPTANCE.json),
[statement referee 1](STATEMENT-REFEREE-1.md),
[statement referee 2](STATEMENT-REFEREE-2.md),
[proof referee 1](PROOF-REFEREE-1.md), and
[proof referee 2](PROOF-REFEREE-2.md). Earlier pending-phase notices are historical.
