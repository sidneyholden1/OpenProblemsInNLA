from pathlib import Path
import json,hashlib
p=Path(__file__).resolve().parents[1]
def sha(f):return hashlib.sha256((p/f).read_bytes()).hexdigest()
s=json.loads((p/'reviews/statement-source-hashes.json').read_text());assert all(sha(f)==h for f,h in s.items())
e=['verification/Referee2Statement.lean','verification/referee-2-statement-probe.log','verification/referee-2-statement-probe-initial.log','verification/referee_2_diagnostics.py','verification/referee-2-diagnostics.json','verification/referee-2-diagnostics.log','verification/write_referee_2_statement_report.py']
a=['../../../docs/lean/REVIEW.md','.lake/packages/mathlib/Mathlib/Analysis/Complex/Norm.lean','.lake/packages/mathlib/Mathlib/Data/Finset/Lattice/Fold.lean','.lake/packages/mathlib/Mathlib/Order/Bounds/Defs.lean']
evidence={'verdict':'APPROVE','reviewer':'OpenAI Codex /root/iv06_statement_referee_2','nonauthor':True,'phase':'statements only','statement_snapshot_sha256':sha('reviews/statement-source-hashes.json'),'source_hashes':s,'additional_source_sha256':{f:sha(f) for f in a},'evidence_sha256':{f:sha(f) for f in e},'probe_exit_code':0,'diagnostic_pairs':30,'coordinator_challenge_exit_code':0,'limitations':['Challenge intentionally has four placeholders; no theorem proof inspected or certified','Original failed diagnostic probe retained; final probe succeeds','Finite exact diagnostics do not prove universal bounds; isolated Linux Comparator pending']}
(p/'reviews/referee-2-statement-evidence.json').write_text(json.dumps(evidence,indent=2)+'\n')
report='''# IE-13 independent statement review

**APPROVE — exact full-target boundary, no blocking finding.**

Phase: before proof. Reviewer: OpenAI Codex agent `/root/iv06_statement_referee_2`, an AI nonauthor of this IE-13 boundary and future IE-13 proof. Date: 2026-09-22. This adapts the repository's Tau Ceti review protocol; no external human review or endorsement is claimed.

I read the complete canonical README, complete attributed IE-13 manuscript including preamble and status qualifications, complete informal review, all Definitions and four Challenge signatures, numerical targets, project documentation, manifest, Comparator configuration, pins, and the retained statement-build and finite-check material. All twenty frozen hashes were independently recomputed. Source base is `85490781eb0ca01c4545ded776117d7cb4cf9f52`.

## Fidelity, semantics and nonvacuity

The canonical unequal-bandwidth problem is retained and strengthened to every natural p,q, including p=q and both zero. The dimension lower bound remains n≥1+max(p,q). `IsBanded` imposes exactly the original at-most lower/upper bandwidth restrictions on arbitrary complex entries and actual determinant nonzero. No realness, exact bandwidth, normalization, front invariant, diagonal condition or derived bound is a premise.

`schurStep` uses the current row permutation at pivot k, leaves columns fixed, divides by the actual selected pivot and zero-pads eliminated rows/columns. `isPath` forces the original state, nonzero pivots at all n stages, each selected row active, and maximal complex modulus over the entire active column with weak inequalities retaining ties. Its final recurrence stops after the last used state; unconstrained later states never enter growth. This represents every canonical shrinking Schur path by padding and conversely. Required growth is every active entry at every stage, not just U or pivots. Stored multipliers are correctly excluded. Positive dimension and nonsingularity preclude a zero normalization denominator; the proof must establish that fact.

The pinned complex norm is sqrt(normSq), and Finset.sup is an actual finite supremum fold with bottom zero for nonnegative moduli. `bandGrowths` existentially ranges over all admissible dimensions, inputs and paths. Mathlib's genuine `IsGreatest` contains membership as well as universal domination. `original_target` additionally states nonemptiness and boundedness of the actual real set before identifying its genuine sSup; there is no empty-set escape or custom substitute for the supremum.

The zero-extended recurrence is transcribed correctly: natural subtraction reaching zero uses h₀=0, so the previous-p sum agrees at all early indices. The explicit p=0 branch gives1. The witness has fixed order2p+q+1 and exact rational entries embedded into ℂ; its original-row assignment matches the source. Its candidate pivot positions realize original labels p,0,…,p−1,p+1,… without an extra preliminary permutation. The full-path attainment conclusion includes the identity tail and all nonzero/maximal pivots, a useful strengthening of the manuscript's finite initial-stage diagnostics. For p=0 it is the identity with identity pivots. No assertion about this candidate is hidden in a definition or premise.

## Independent checks and proof feasibility

My separately reconstructed exact rational script checks30 pairs p=0…4,q=0…5, every forbidden structural zero, initial maximum1, the entire prescribed Schur path, every nonzero maximal pivot, nonsingularity via elimination, and exact recurrence growth. These are transcription/nonvacuity checks, not a universal proof. The author/coordinator's larger checks were read as corroboration only. My own Lean Definitions consumer passed with actual modulus, finite-supremum and greatest-element interfaces, a kernel-reduced recurrence example, p=0 branch and padding identity. An initial probe used a wrong unqualified API name and reduction tactic; its failed log is retained and the corrected probe passed. The coordinator's Challenge build PASS2380 with exactly four intentional placeholders was inspected; I did not duplicate that complete build.

The source's sorted-front argument requires an actual row-label/untouched-row invariant, monotonicity under sorting and fresh insertion, and the p-component envelope; all remain proof obligations. The scalar estimate is not a disguised theorem hypothesis. Exact sums, recurrences and complex triangle inequalities are appropriate and avoid artificial interval computation. LeanCert is truthfully planned as a kernel trust audit here. Mathlib finite supremum, determinant, permutation and conditional-completeness APIs are reused; IE-14's complex padded definitions are explicitly credited, without importing an unproved result. Comparator lists all four exports and only the standard three permitted axioms.

Mathematical attribution to Matthew J. Colbrook, original-problem credit to Higham, the source's reconstruction/substantial-AI disclosure, Sidney Holden's formalization credit and Apache licensing are preserved. Documentation correctly describes statements only and pending proof/final review/Linux. Optional closed forms are not separately promised; all required unequal pairs, zero bandwidths, complex inputs and tie paths remain included.

## Limits and exact identity

This approval authorizes proof work only. Four Challenge placeholders prove no mathematics; no active Proof/Solution body has been inspected or authored in this review. Final independent proof reviews, kernel axiom closure and the actual isolated Linux Comparator remain required. The accompanying `referee-2-statement-evidence.json` binds this exact snapshot, imported semantics and every independent script/log.

| Frozen file | SHA-256 |
|---|---|
'''+''.join(f'| `{f}` | `{h}` |\n' for f,h in s.items())
(p/'reviews/statement-referee-2.md').write_text(report)
print('APPROVE: report and evidence frozen, twenty snapshot hashes match.')
