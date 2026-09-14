# MI-08 partial Lean verification

Mathematical partial result: Matthew J. Colbrook, University of Cambridge.
Original question: Jean-Christophe Bourin and Eun-Young Lee. Formalization:
Sidney Holden, Center for Computational Biology, Flatiron Institute, Simons
Foundation, with OpenAI Codex assistance.

Four exports prove fixed-list characterization by integer sign designs, rank
and divisibility obstructions, the explicit order-twelve certificate, and the
actual minimum 12 for every dimension 9 through 12. The source adaptive
comparison is outside this formalization. The all-dimension optimum remains
open. NUMERICAL_TARGETS.md fixes the mathematical boundary.

Status: complete local Lean 4.33.1 kernel build PASS (3584 jobs), with all four
exports using only propext, Classical.choice and Quot.sound. Both independent
statement reviews passed before implementation; frozen revision 607a5e4a.
Both independent final proof reviews PASS, including separate replays, axiom
audits and actual LeanCert term inspection. Reviewed proof revision: 987612e5.
Actual isolated Linux Comparator/default-kernel replay with rejection controls
remains pending. Canonical status remains
Partially resolved.

The fixed-list proof applies matrix units to the actual averaging identity;
nonnegative squares force every factor diagonal. No diagonal restriction is
assumed. Integer and real signs are related by exact casts. Actual matrix rank
and an adaptation of Dennj Osele's Mathlib Hadamard divisibility proof establish
the lower bounds. One explicit integer matrix is checked with decide +kernel;
LeanCert verifies the strict positive row count with trust:=kernel, and every
export passes LeanCert trust audits. No interval search or subdivision.

The official v0.4 manifest and Comparator configuration select all four targets,
with no definition replacements. Exact statement-reviewed metadata remains in
reviews/statement-review-snapshot; exact final-reviewed wrappers remain in
reviews/proof-review-snapshot, preserving the original hash record. Dependency and toolchain pins are retained;
local builds share a pinned cache. Shared workflow provenance is recorded in
tools/lean/NOTICE.md. The project retains the Apache-2.0 license.
