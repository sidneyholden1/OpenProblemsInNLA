"""Run only after the actual complete Solution log passes; preserves statement receipts."""
from pathlib import Path
import hashlib,json,re,yaml,jsonschema
log=Path('verification/solution-build-final.log').read_text()
assert 'Build completed successfully' in log and 'error:' not in log
names=['upper_bound','rational_attainment','sharp_maximum','original_target']
for name in names:
 assert f"'NLA.IE14.{name}' depends on axioms: [propext, Classical.choice, Quot.sound]" in log
s=json.loads(Path('reviews/statement-source-hashes.json').read_text())
for f in ['README.md','formalization.yaml']:
 assert hashlib.sha256((Path('reviews/statement-original')/f).read_bytes()).hexdigest()==s[f]
y=yaml.safe_load(Path('formalization.yaml').read_text())
y['automation']['methods'][0]['tool_setup']='Lean 4.33.1, pinned Mathlib and LeanCert. Separate trusted Challenge and completed Solution; exact finite complex algebra and Fibonacci recurrence proofs, kernel trust only. Shared local dependency cache; isolated Linux Comparator remains pending.'
y['status']['scope']='Complete local proof of all four original exports, including every complex all-tie GEPP path, exact rational attainment and genuine sharp supremum. Solution compiles and all four LeanCert kernel checks pass with only the standard three axioms. Independent nonauthor final reviews and isolated Linux Comparator remain pending; canonical publication status unchanged.'
y['status']['sorry_count']=0
for r in y['status']['main_results']:
 r['file']='Solution.lean';r['sorry_count']=0
y['review']['status']='local-proof-complete-final-review-pending'
y['review']['notes']='Two independent nonauthor statement approvals and successful Challenge elaboration preceded proofs; exact statement gate and original README/YAML snapshots retained. Local full Solution and all four kernel audits pass. Root and iv06_statement_referee_1 are nonauthor final referees; final reviews and isolated Linux Comparator are pending. Authors do not self-review independently.'
header='# yaml-language-server: $schema=https://raw.githubusercontent.com/mathlib-initiative/formalization.yaml/99c678e569c7c4c0772db297c5ddd5e4c9b6322e/schema/v0.4.schema.json\n'
Path('formalization.yaml').write_text(header+yaml.safe_dump(y,sort_keys=False,allow_unicode=True,width=100))
Path('README.md').write_text('''# IE-14 Lean verification

The complete local proof establishes the sharp growth factor F_(n+1)+1 for
every order n≥4. It covers arbitrary complex nonsingular cyclic tridiagonal
inputs with both corners nonzero, every permitted GEPP tie, and every active
Schur entry in the original ordering. The explicit rational family attains
the bound through the literal row-swap elimination path. Nonemptiness,
boundedness, the greatest element and the genuine real supremum are proved.

**Local status:** Solution compiles; all four advertised exports pass LeanCert
kernel checks with only propext, Classical.choice and Quot.sound. The proof
implementation contains no placeholders. Challenge retains its four intentional
statement placeholders. Independent nonauthor final reviews and isolated Linux
Comparator checks are pending. No publication or Linux-success claim is made.

## Proof structure

- `Base.lean` supplies finite entry maxima and actual growth bounds.
- `Front.lean` derives the two-row front and untouched future rows from actual
  complex GEPP and the original sparsity pattern.
- `PairBounds.lean` and `ColumnBounds.lean` control every column history using
  complex norm inequalities and Fibonacci recurrences; `Upper.lean` assembles
  the full all-path upper bound.
- `WitnessInput.lean` proves the rational input's exact pattern, both nonzero
  corners, determinant and initial maximum.
- `WitnessPath.lean` proves the actual swapped Schur states equal truncated
  LU residual sums, every pivot is legal, and the final pivot is F_(n+1)+1.
- `Proof.lean` combines attainment with the upper bound and derives the sharp
  supremum. `Solution.lean` exports the four frozen Challenge statements.

No desired front property, scalar bound, normalization, factorization or pivot
admissibility is assumed in a public theorem. Finite rational diagnostics are
transcription checks only; the Lean proofs quantify over every required order.
The method uses exact finite algebra, avoiding unnecessary interval computation.

## Evidence and reproduction

Run `lake build Solution` with the pinned toolchain and dependencies. The actual
local build is recorded in `verification/solution-build-final.log`. The author's
separate witness audit and exact diagnostics are retained under `verification/`.
The two pre-proof nonauthor approvals and original statement hashes remain in
`reviews/`; `reviews/statement-original/` preserves the approved README and
formalization.yaml before this status update. Mathematical statement bytes and
pinned configuration are unchanged. The root-level shared Lean workflow provides
the required isolated Linux Comparator and rejection controls.

See [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) for exact contracts and the
source-to-formalization plan. All four results are listed in formalization.yaml
and comparator.json. Final independent reviews and Linux artifacts must be added
before describing this as fully accepted and published.

## Attribution

Mathematics is attributed in the complete manuscript to Matthew J. Colbrook,
Cambridge; its substantial AI assistance and reconstruction disclosures remain.
Higham retains original-problem credit. Formalization: Sidney Holden with OpenAI
Codex assistance. Apache-2.0. No novelty, external human review or source-author
endorsement is claimed. The complete source and earlier informal review are under
`references/colbrook-recovered-2026-09-11` at the repository root.

IE-15's padded-state proof layout was studied and adapted. Its real rook-pivoting
bound is not used as a complex GEPP result. Mathlib, LeanCert, Comparator and
formalization.yaml retain their licenses and credit; shared workflow attribution
is recorded in `tools/lean/NOTICE.md`.
''')
schema=json.loads(Path('../../../docs/lean/schema/v0.4.schema.json').read_text())
jsonschema.validate(y,schema)
c=json.loads(Path('comparator.json').read_text())
assert [r['declaration'] for r in y['status']['main_results']]==c['theorem_names']
assert all(r['sorry_count']==0 and r['file']=='Solution.lean' for r in y['status']['main_results'])
assert c['definition_names']==[] and set(c['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
print('PASS official v0.4 schema, four completed export declarations, preserved statement metadata and truthful pending final-review/Linux status.')
