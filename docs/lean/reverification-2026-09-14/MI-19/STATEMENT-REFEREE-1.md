# MI-19 independent statement referee 1 — 2026-09-14

PASS — explicit approval of the exact statement boundary recorded below. No blocking fidelity, scope, numerical, denominator or vacuity finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, covering the relevant Tau Ceti fidelity, correctness, scope, generality, computation, reuse/API, documentation and attribution angles. It is not an official Tau Ceti verdict or external human peer review. This phase reads statements and complete informal sources only; no active Proof or Solution body was inspected.

## Source provenance and scope review

The authored project is preserved from `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Both source and formalization authorship remain unchanged. I read the complete canonical page, complete informal proof, Definitions, Challenge, numerical targets, project README, Comparator and formalization manifest. Historical completed-status prose refers to prior executions, and stage-one prose is historical; neither is evidence of completion of this fresh campaign. The recorded old and preserved canonical target sections have the same mathematics with rendering/whitespace differences. No permanent ID or target is changed.

The two exports cover the complete negative target. The conjecture retains every n≥2, every complex Hermitian PSD input, q in the closed interval [0,1], and every nonempty proper subset. PosSemidef is the actual all-complex-vector quadratic-form predicate, with Hermitian symmetry. Inversions count every pair i<j in the original full order; q is cast into ℂ and raised to a natural number, preserving 0^0=1. The restricted sum filters by the actual image equality S.image σ=S, hence setwise preservation. The paper's interior singleton {2} is correctly represented by {1:Fin 4}; neither restriction nor reindexing recomputes inversions on smaller blocks.

ComplexOrder compares real parts at equal imaginary parts. For Hermitian inputs the inverse-permutation pairing explains the intended reality (inversion counts agree for σ and σ⁻¹, and the preserving class is inversion-closed). The required concrete export additionally proves both sums' imaginary parts zero. Its strict reversal therefore cannot exploit complex incomparability. Gram identity, PSD, allowed q, subset admissibility and the actual two permutation sums all occur as conclusions, not hypotheses. The second export negates the entire original conjecture.

I independently multiplied XᵀX, enumerated all 24 permutations, selected exactly six preserving the singleton, and recomputed both entire polynomial coefficient lists. Their difference agrees with the stated factorization and gives −3235575/16384 at 7/8. This independently checks the sign, indexing and denominator. The actual finite sums still require Lean proofs; the script is not a substitute. Mathlib's proved decomposeFin equivalence is a suitable checked enumeration API. One scalar point comparison is sufficient; no q-interval, eigenvalue approximation or positive-definite perturbation is needed.

Exact rank two, all-q polynomial identities as public results, and the positive-definite perturbation extension are excluded from the formal claim; none is needed to refute the full canonical assertion. Colbrook's mathematical authorship, Stepaniants's formalization authorship, and Bapat/Lal/da Fonseca question attribution remain distinct.

## Evidence and approval limits

The reproducible [referee-1-precheck.py](referee-1-precheck.py), run independently by this referee with argument `MI-19`, exited 0; [referee-1-precheck.log](referee-1-precheck.log) records exact results. The script does not inspect authored proof bodies and does not replace a Lean proof.

The coordinator's fresh macOS aarch64 `lake build Challenge` exited 0. I inspected its log and verified the recorded log digest: exactly 2 deliberate Challenge placeholders were reported. This was the coordinator's execution, not a second rebuild by this reviewer. Challenge compilation proves well-formedness only. Comparator selects all 2 reviewed signatures, no definition holes and exactly the standard three permitted axioms.

Every read authored file is byte-identical to the preserved source. Exact source, boundary, relevant pinned-library, script, result and execution hashes are retained in [referee-1-statement-evidence.json](referee-1-statement-evidence.json), SHA-256 `f6af70e437a209b21bd5062e3b8eebb4d1cc0b94f331fd8b51733c502bf0adb1`. The inspected Mathlib definitions and example proofs justify the semantic/API choices; LeanCert's point tactic has multiple proof-producing routes, so the actual later term must be inspected before claiming a particular numerical backend. RA-07 has no numerical backend requirement.

I approve these exact statements for the subsequent gated proof audit. Actual proof correctness, transitive axioms, material certificate terms, final independent proof reviews and fresh Linux Comparator/default-kernel/sandbox checks remain unreviewed at this phase. No authored source, metadata or historical evidence was changed.
