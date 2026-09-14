# KE-04: fresh independent reverification — PASS

This is an additional independent review and Linux replay of an existing authored
formalization, requested by Sidney Holden on 2026-09-14. It is not a new proof or
a new solved-status claim. Upstream source: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.
George Stepaniants retains formalization credit; all mathematical source credits,
canonical pages, metadata and historical evidence remain unchanged.

- Two fresh independent AI-agent statement reviews and two proof reviews: PASS.
- Fresh local Challenge and Solution builds, plus independent export/type/axiom
  queries for all **24** configured declarations: PASS.
- [Fresh Ubuntu Comparator and default-kernel replay](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34868858154): PASS at
  `367acf8ecb423c609d501ccfea910de91ed4c82e`. No definition exceptions; only `propext`, `Classical.choice`
  and `Quot.sound` are permitted.
- Actual per-project sandbox, kernel and Comparator rejection controls: PASS,
  including rejected `sorry` and native-compiler axioms.
- Original artifact digest matches GitHub; all **4285** input hashes
  match the exact tested Git objects. See [Linux receipt](linux/RUN.json),
  [independent operational review](OPERATIONAL-REFEREE-2.md) and
  [coordinator checks](ROOT-LINUX-CHECKS.json).
- Original `formalization.yaml` validates against the pinned official v0.4 schema;
  permanent-ID validation and tests pass.

The reviewed project uses pinned public dependencies and the official Mathlib
cache. A full dependency-source rebuild is not claimed. LeanCert use is documented
precisely in the proof reviews: material kernel-reduced singleton certificates in
IS-03 and RA-08; kernel trust audits with exact algebra in KE-04, SP-06 and IE-16.
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
