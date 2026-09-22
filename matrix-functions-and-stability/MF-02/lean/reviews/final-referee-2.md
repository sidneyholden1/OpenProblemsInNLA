# MF-02 independent final referee 2

Verdict: **PASS** for the exact frozen complete implementation. Reviewer: OpenAI Codex agent new_target_screen, an AI agent and nonauthor of every MF-02 proof. I previously independently reviewed the statements and made no proof edits. Exact reviewed hashes are in [referee-2-final-evidence.json](referee-2-final-evidence.json), covering all 22 frozen inputs, complete canonical/manuscript source, my exact consumer and its successful log. This is distinct from agent2's independent report final-referee-agent2.md; a filename collision was corrected without changing either consumer or evidence receipt.

I read the complete original target and all six manuscript sections, docs/lean/REVIEW.md, Definitions, Challenge, all nine implementation modules, Solution, numerical plan, statement gate, metadata and actual build log. Every frozen proof hash and statement-gate hash matched (using preserved README/metadata snapshots). My verification/Referee2ExactConsumer.lean reproduces all seven frozen signatures against Solution alone. It compiled with exit zero; all seven independent LeanCert kernel assertions passed and printed exactly propext, Classical.choice and Quot.sound. The log is verification/referee-2-exact-consumer.log. No custom axiom, native computation axiom, unsafe implementation or proof placeholder occurs in the implementation; Challenge's seven intended holes are not imported by Solution.

## Fidelity and full target

RegisterRun preserves every stored value and permits all free real linear combinations as operands and output, including shared-subexpression reuse. Register degree bounds are proved by actual history/span induction. ProgramCosts constructs genuine two-product cubic stages and their correctly ordered compositions. Final scaling is absorbed into stage coefficients, with no hidden extra stage.

Errors are the actual maxima over both closed gap intervals and real infima over actual programs and coefficient lists. Fixed-polynomial attainment and nonempty/bounded conditions are proved. Coefficient-infimum attainment is not assumed: cubic_square chooses an actual error below a positive slack threshold, improves that composition, and proves the infimum estimate. The feasible natural stage set is nonempty and its infimum is feasible/minimal, preventing empty-infimum fallback. All budgets and every real gap in (0,1) remain quantified; no sample, gap restriction, budget cap or approximation premise appears in the exports.

## Correctness and proof quality

DegreeError constructs the odd part, proves its square has only even coefficients, contracts that square to degree at most D, performs the exact interval transformation and applies pinned Mathlib exterior Chebyshev extremality. Cosh/log identities derive the actual gap-ratio value. Positive slack handles the zero-error case without circularly assuming positivity. Solution supplies this proved DegreeBound to every internal assembly interface; it is not an unproved final hypothesis.

The cubic construction proves critical-point, interval and gap estimates by exact factorization and positivity, avoiding interval subdivision. Its explicit scaled cubic squares any positive error below one. Genuine program cost inclusion, degree lower bounds, constructive upper bounds and rigorous infimum strictness yield the stage bounds. Zero and one budgets and both uniform bounds are explicitly established. The implementation need not separately expose E1=r: its alternative endpoint argument proves exactly the requested minimum-stage result.

## Reuse, scope and attribution

The implementation appropriately reuses pinned Mathlib polynomial expansion/contraction, Chebyshev extremality, compactness and ordered-infimum APIs. Internal DegreeBound interfaces keep module dependencies clear and are visibly discharged. Names/modules reflect mathematical responsibilities. Minor retained style-linter warnings are nonblocking. Metadata preserves Stepaniants' expository authorship, Chen–Chow's cubic, Cheon–Kim–Kim's prior order and Holden/AI formalization. The claim is the canonical uniform asymptotic order, not an exact optimal stage formula, optimal leading constant or same-budget optimum. No novelty or source-author endorsement is claimed.

No changes requested. This review does not claim a fresh Linux Comparator run, external human peer review or official Tau Ceti endorsement. Canonical promotion requires the separate Linux acceptance gate.
