# IE-17 Lean verification

Mathematical counterexample: Matthew J. Colbrook. Original questions: David
Chin-Lung Fong and Michael A. Saunders. Formalization: Sidney Holden, Center for
Computational Biology, Flatiron Institute, Simons Foundation, with OpenAI Codex
assistance. Source AI-assistance and priority qualifications remain in the
canonical entry and supplied manuscript.

This proves separate negative answers to both original questions: the optimal
spectral backward error and the projected-residual approximation each increase
from the first to the second exact LSMR iterate in the same 4×3 example.

## Scope and proof

The four exports cover actual variational LSMR iterates, full column rank,
attainment of both true backward-error minima, their strict increase, all four
Moore–Penrose identities, exact squared projected-error values, their strict
increase, and separate negations of the two universal monotonicity claims.

`Proof.lean` establishes feasible-set attainment in every finite real dimension,
exact Krylov/least-normal-residual/minimum-length identities, and the spectral
error bounds. Its lower bound handles both zero and nonzero perturbed residuals.
`Certificates.lean` verifies the rational upper perturbation and LDL positivity,
connects that certificate to the genuine rectangular Euclidean operator norm,
and proves the lower weighted sum-of-squares identity. `Approximation.lean`
derives the actual stacked projector and four Moore–Penrose identities before
reducing to exact scalar fractions. LeanCert's kernel-only point prover checks
the two rational separation cuts without interval subdivisions.

`NUMERICAL_TARGETS.md`, Definitions and Challenge were approved by two
independent AI referees and frozen at commit `0986a847` before proof bodies.
`verification/numerical_precheck.py` is a Fraction precheck, not proof evidence.
The four deliberate Challenge placeholders are isolated from Solution.

## Current evidence

Local `lake build Solution`: PASS (3677 jobs). All four exported axiom closures
are exactly `propext`, `Classical.choice`, `Quot.sound`; all LeanCert kernel-trust
audits pass. Two warnings originate inside LeanCert's point tactic, using a
deprecated Mathlib set-membership name; they do not change the proof or trust
closure. See `verification/final-build.log` and `verification/axioms.log`.

Both independent final proof reviews passed, including independent re-elaboration
and axiom audits. Reviewed proof checkpoint: `024fa03f`. The exact prior reviewed
README and metadata are retained in `reviews/proof-review-snapshot`.

Actual isolated Linux Comparator/default-kernel replay with rejection controls
remains pending. Canonical status remains
Solved; this local checkpoint is not a completed publication as Lean verified.

`formalization.yaml` follows the pinned official v0.4 schema. Comparator checks
all four exports, permits no definition holes and only the three standard
axioms above. Shared Comparator workflow provenance is retained in
`tools/lean/NOTICE.md`.
