# IE-17 Lean verification

Mathematical counterexample: Matthew J. Colbrook. Original questions: David
Chin-Lung Fong and Michael A. Saunders. Formalization: Sidney Holden with
OpenAI Codex assistance.

The statement boundary covers both original questions: the optimal spectral
backward error and the projected-residual approximation each increase from the
first to the second exact LSMR iterate in the same 4×3 example. It includes
actual variational LSMR iterates, full column rank, attainment of the true
backward-error infima and all four Moore–Penrose identities.

Status: statements elaborate; both independent statement reviews passed. Proof
implementation has not started. No canonical status promotion is claimed.

See `NUMERICAL_TARGETS.md` for the exact statement-first boundary and optimized
rational certificate plan. `verification/numerical_precheck.py` is an exact
Fraction precheck, not a Lean proof. The four intentional Challenge placeholders
are isolated from the eventual solution environment.

Pinned Lean 4.33.1, Mathlib and LeanCert match the existing repository examples.
The final solution must use kernel-only LeanCert trust audits, no definition
holes, and only propext, Classical.choice and Quot.sound. Two independent final
reviews and actual isolated Linux Comparator/default-kernel replay with
rejection controls are required before publication as Lean verified.

`formalization.yaml` follows the pinned official v0.4 schema. Shared Comparator
workflow provenance is retained in `tools/lean/NOTICE.md`.
