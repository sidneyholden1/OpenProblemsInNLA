# MI-08 independent statement referee 2

- Phase/date: statement review before proofs, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of implementation; not human peer review or official Tau Ceti service.
- Verdict: **PASS / APPROVE** at the exact bytes below. No blocking or substantive correction requested. Approval is explicitly for the advertised partial scope, not the complete all-dimension optimization or adaptive equivalence.
- Protocol: `docs/lean/REVIEW.md`; fidelity, degeneracy, proof feasibility, optimization, reuse and attribution reviewed. No implementation or metadata edited.

## Full source and precise partial scope

I read the complete canonical README, complete solution.md submission note and complete solution.tex proof, together with Definitions, Challenge, NUMERICAL_TARGETS, metadata, Comparator config and exact precheck. I independently checked all six snapshot hashes and all three canonical files against base `9777c86853b40206f70438c92a47a7dec9bc66ae`; all match.

The source proves a stronger fixed/adaptive comparison, while this boundary deliberately certifies fixed-list feasibility iff sign-design feasibility for all positive d,q, rank and divisibility obstructions, one actual order-twelve sign matrix, and actual minima for every dimension 9–12. README and manifest state the exclusion of adaptive equivalence and other optimum values. This is meaningful partial progress on the permanent original optimization target; no original ID, target or solved status is replaced.

## Quantifiers and actual matrices

`FixedPinching U` fixes one finite list U before quantifying over every real d×d X. The existential list in the theorem is outside that universal X quantifier. The inputs include nonsymmetric real matrices, so no restriction to symmetric X or permission for input-dependent factors is hidden. The identity uses actual diagonal extraction, ordinary real matrix multiplication, transpose, the exact finite sum and scalar 1/q. Actual orthogonality UᵀU=I is required for every list member. Positive q is built into FixedPinching and explicit in the equivalence; totalized division by zero cannot manufacture feasibility.

`SignDesign H` uses integer entries exactly ±1 and the actual column Gram equation HᵀH=qI for a q×d matrix. It is rectangular and does not incorrectly assume full square Hadamard structure or row orthogonality. Casting integer signs and Gram entries into ℝ preserves this equation; conversely real signs can be selected as the corresponding integer ±1. No arithmetic rounding or modular Gram interpretation is involved.

The equivalence is plausible with no missing premise: apply the universal averaging identity to diagonal matrix units Ejj. Each off-diagonal output diagonal coordinate is zero, hence its sum of squared U entries is zero. Every summand is nonnegative and q>0, forcing every U diagonal. Orthogonality forces diagonal entries ±1. Applying the identity to all off-diagonal units Eij then gives orthogonal sign columns. The reverse direction is entrywise expansion with those columns. This is a valid simplification of the fixed-list part of the stronger source proof. d=1 works; empty d is excluded from the equivalence and not needed for the canonical d≥1 target.

`design_obstructions` permits d=0 but its conclusion is then harmless. q>0 is essential for nonzero Gram scaling and is explicit. For d>0, cast to a field and use the full-rank Gram equation to obtain d≤q; no integer field structure should be assumed. For d≥3, three distinct columns suffice: expand (1+ab)(1+ac), sum over rows using the three pairwise Gram orthogonalities, and use divisibility of every integer summand by four. Thus the rectangular setting has exactly the hypotheses needed; it does not rely on a nonexistent square extension.

## Explicit Paley matrix and minimum nonvacuity

The first row and column are all ones; the 11×11 core is Q−I. The core indices 1,…,11 represent all residues modulo eleven, a simultaneous shift of the source field indexing. Their differences are unchanged. I checked the actual natural-number formula: i+11−j is nonnegative for Fin12 and in the core, so truncated subtraction does not corrupt the desired residue difference. The diagonal branch correctly supplies −1 rather than χ(0).

My independent integer diagnostic regenerates the nonzero quadratic residues modulo eleven, evaluates this exact natural-subtraction formula, compares it with the retained precheck matrix, and verifies every column Gram entry for each restriction to d=9,10,11,12. All pass. It also checks the first multiple of four not below each of those d is 12. Evidence is `verification/referee-2-independent-check.json`; these diagnostics are not Lean proofs.

`pinchingLengths d` is the actual set of lengths admitting FixedPinching, including its positive-length requirement. `phi d` is the natural sInf of this set. The final theorem separately asserts Nonempty and IsLeast with value 12, so an empty-infimum default cannot prove the advertised minimum. IsLeast requires both an actual length-twelve list and exclusion of every shorter feasible length. Column restriction gives upper feasibility; equivalence plus d≤q and 4∣q excludes all lower q in this range. Nat sInf equals the least member for a nonempty set; I inspected the imported `isLeast_csInf`/`csInf_eq_iff` definitions and hypotheses. No completeness or boundedness issue is hidden for ℕ. Every d in the entire interval is quantified, not merely its endpoints.

## Reuse, evidence, credit and future gates

I inspected Mathlib's actual integer Hadamard divisibility proof. It uses exactly the three-sign-product identity proposed here; adapting its row argument to columns of a rectangular matrix is justified. Existing rank, transpose, finite-sum and natural-infimum APIs are appropriate. A single exact 12×12 certificate with column restrictions avoids searching constructions or interval subdivision. LeanCert's planned 0<12 point check and kernel export audits must be verified on actual proof terms later; no numerical oracle belongs in the boundary.

I independently elaborated Challenge with the pinned Lean4.33.1 runtime/cache, exit zero, exactly four intentional sorry warnings; see `verification/referee-2-statement-elaboration.log`. I inspected the implementer's 1855-job statement log with the same warnings. Those placeholders establish no mathematics. No proof bodies were reviewed or written. Comparator selects all four exports, no replaceable definitions and only the standard three axioms. I inspected the draft manifest but did not independently rerun its official schema validator or actual Linux Comparator.

Colbrook's partial result, Bourin–Lee's original question, Holden's formalization and Codex assistance are distinguished. The manifest acknowledges the studied Mathlib Hadamard structure and author; source AI provenance and lack of source endorsement remain explicit. I do not independently authenticate priority, identities, affiliations or ownership. Final proof correctness/axiom reviews and isolated Linux Comparator/default-kernel/rejection controls remain required. No complete resolution of MI-08 or adaptive theorem is approved by this report.

## SHA-256

- `NLA/MI08/Definitions.lean`: `3d239b1379ea53cead7b54a06ed8ae92e2d191420f45a39b5466dcd6380c3965`
- `Challenge.lean`: `7ef811f91e89621f606400fb76756068f941c30f94ac4d9135bb6111d115413e`
- `NUMERICAL_TARGETS.md`: `c8bf9ab6782e2bec826664fe69cd09a523e495cedadbee64ada5f4eca6d25832`
- `comparator.json`: `18928dd61159e774c47a220a825f4666881e2a89fa825514bd800a91463bf465`
- `formalization.yaml`: `5a5e7b8ddc58f8eba0ddfbe8a865f65089503de2edc9e04ddc6d02c51f3264ac`
- `README.md`: `1a55dbd03860837653a88abe2d3d017ecf0537d6b885315704cb2066687166c0`
- `../README.md`: `814804db20ca8a73366cced2a5de00f8f01261f13d05d5bae1eaa1a1124289e2`
- `../solution.md`: `854a282d60852a4a15a91bcc8a2889d69a1268124faca6cbd92d40e4e547cd99`
- `../solution.tex`: `c15abfde319610c212c0e021531fd7a89640fb39fb39ef1c112c0cd64827f404`
- `reviews/statement-source-hashes.json`: `690a10fef480e3e7a18ce2e04c38db7b04184f564a8c02725fa909a20f782ca0`
- `verification/referee-2-independent-check.json`: `f7401c0f319622347a9ed93a28efc7b394dc93a5e0c4eca5d8736e89d408748f`
- `verification/referee-2-statement-elaboration.log`: `9597e8ada96e505a10703118c86d02bf0759e20fcaf920f40445b97aa7bc2b96`
- `verification/numerical_precheck.py`: `4fbacd2db7e41356c2c493d9f4fcd256a81c2622840f2d563d2756ae755aef23`
- `verification/numerical-precheck.json`: `f100927d3e4e2a1b7d4f4a5cd17f9a3d423d471d73e0dac829386a2538f74715`
- `verification/statement-build.log`: `f2908c8c15f9069ec8c86d4d6034ff73aa7ff41c3488389bb3e8e0ba7431b543`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/HadamardMatrix.lean`: `b04b0656bc502d39b1c7d238afe6152428778f59411a7ef9753c81565b231c31`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
