# MI-29 independent statement referee 1 — 2026-09-14

PASS — explicit approval of the exact statement boundary recorded below. No blocking fidelity, scope, numerical, denominator or vacuity finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, covering the relevant Tau Ceti fidelity, correctness, scope, generality, computation, reuse/API, documentation and attribution angles. It is not an official Tau Ceti verdict or external human peer review. This phase reads statements and complete informal sources only; no active Proof or Solution body was inspected.

## Source provenance and scope review

The authored project is preserved from `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Both source and formalization authorship remain unchanged. I read the complete canonical page, complete informal proof, Definitions, Challenge, numerical targets, project README, Comparator and formalization manifest. Historical completed-status prose refers to prior executions, and stage-one prose is historical; neither is evidence of completion of this fresh campaign. The recorded old and preserved canonical target sections have the same mathematics with rendering/whitespace differences. No permanent ID or target is changed.

All five exports match the canonical positive-definite/invertible-Hermitian formulation in every n≥1 and for all nonnegative real k,p. B is not required positive and no commutation is assumed. IsUnit is actual square-matrix-ring invertibility. Both determinant expressions preserve the noncommuting product order. Explicit CFC.rpow under MatrixOrder is the unital spectral power; rpow_zero on nonnegative matrices is I, whereas the different nonunital zero-power operation is not selected. CFC.abs is the actual sqrt(star X*X), and the matrix star is conjugate transpose.

The generic natural-power agreement includes zero. The separate all-matrix modulus bridge requires both genuine positivity and the eighth-power identity, rather than substituting the witness's rational Gram expression as a definition. The generic positive-real determinant export is under the original assumptions and proves imaginary parts zero and positive real parts. Thus ComplexOrder expresses the stated ordinary real comparison, with reality as a consequence. Invertibility of A and B gives invertible Gram moduli; spectral powers and their sums have their intended positive meaning, including the zero-exponent endpoints.

My exact independent script constructs the source A,M,B and verifies det B=−1/125, with negative and positive diagonal quadratic-form witnesses showing B is genuinely indefinite. It computes D=A^6, H=(MA²M)^4 and J=(AM²A)^4, preserving left/right alignment, then both full determinants at z=5^−8. The results are 136990346414301954149/61035156250000000000 and 4537743716162890657/1907348632812500000, with positive right-minus-left gap 21036678407451/156250000000000. Independent polynomial determinant expansion also recovers the two-coefficient gap, including cancellation of constant and cubic terms.

The actual CFC reductions, all witness hypotheses, determinant values and strict reversal are required conclusions. The final export negates the complete all-real-exponent target, not an integer-exponent substitute. Generic CFC lemmas and repeated squaring permit only one rational point check; numerical square roots, spectra and interval grids are unnecessary. Singular-input extensions, the proved k=2 case and positive-B variants are explicitly excluded. Colbrook's mathematical authorship and Stepaniants's formalization attribution are preserved.

## Evidence and approval limits

The reproducible [referee-1-precheck.py](referee-1-precheck.py), run independently by this referee with argument `MI-29`, exited 0; [referee-1-precheck.log](referee-1-precheck.log) records exact results. The script does not inspect authored proof bodies and does not replace a Lean proof.

The coordinator's fresh macOS aarch64 `lake build Challenge` exited 0. I inspected its log and verified the recorded log digest: exactly 5 deliberate Challenge placeholders were reported. This was the coordinator's execution, not a second rebuild by this reviewer. Challenge compilation proves well-formedness only. Comparator selects all 5 reviewed signatures, no definition holes and exactly the standard three permitted axioms.

Every read authored file is byte-identical to the preserved source. Exact source, boundary, relevant pinned-library, script, result and execution hashes are retained in [referee-1-statement-evidence.json](referee-1-statement-evidence.json), SHA-256 `e078114e8121c167538501356967a54755e8f894074e7aa63e45a5524f6ea340`. The inspected Mathlib definitions and example proofs justify the semantic/API choices; LeanCert's point tactic has multiple proof-producing routes, so the actual later term must be inspected before claiming a particular numerical backend. RA-07 has no numerical backend requirement.

I approve these exact statements for the subsequent gated proof audit. Actual proof correctness, transitive axioms, material certificate terms, final independent proof reviews and fresh Linux Comparator/default-kernel/sandbox checks remain unreviewed at this phase. No authored source, metadata or historical evidence was changed.
