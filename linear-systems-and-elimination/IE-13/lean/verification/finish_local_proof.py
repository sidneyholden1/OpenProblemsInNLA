"""Freeze IE-13 local-complete evidence only after successful Solution and author audit.
This script does not assert independent review, Linux acceptance, or publication.
"""
from pathlib import Path
import hashlib,json,re,shutil,subprocess,sys
import yaml,jsonschema
p=Path(__file__).resolve().parents[1]
def sha(f):return hashlib.sha256((p/f).read_bytes()).hexdigest()
log=(p/'verification/solution-build-final.log').read_text()
audit=(p/'verification/axioms.log').read_text()
m=re.search(r'Build completed successfully \((\d+) jobs\)\.',log)
assert m,'No successful normal Solution build'
assert not re.search(r'\berror:',audit),'Author audit failed'
config=json.loads((p/'comparator.json').read_text());names=config['theorem_names']
for name in names:
 assert f"'{name}' depends on axioms: [propext, Classical.choice, Quot.sound]" in audit
statement=json.loads((p/'reviews/statement-source-hashes.json').read_text())
preserved={}
for f,h in statement.items():
 dst='reviews/statement-original/'+f if f in ['README.md','formalization.yaml'] else f
 if dst!=f and not (p/dst).exists():
  assert sha(f)==h
  (p/dst).parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(p/f,p/dst)
 assert sha(dst)==h,(f,'frozen statement mismatch')
 preserved[f]=dst
# Proof source inspection is still a separate independent-review obligation.
for f in [*p.glob('NLA/IE13/*.lean'),p/'Solution.lean']:
 assert not re.search(r'\b(sorry|admit|native_decide|axiom|unsafe)\b',f.read_text()),f
x=yaml.safe_load((p/'formalization.yaml').read_text())
x['automation']['methods'][0]['tool_setup']='Lean 4.33.1, pinned Mathlib and LeanCert. Separate trusted Challenge and completed Solution, kernel trust only, exact HTTPS dependency pins, shared local cache.'
x['status']['scope']='Complete local kernel proof of the original unequal-bandwidth target, strengthened to all p,q≥0, with arbitrary complex nonsingular inputs, all admissible dimensions and pivot ties, all intermediate entries, exact rational attainment and the genuine nonempty bounded growth supremum. Both independent statement approvals preceded proof; independent final reviews and actual isolated Linux Comparator remain pending. Canonical status unchanged.'
x['status']['sorry_count']=0
x['status']['sorry_in_definitions']=0
x['status']['axioms']=['propext','Classical.choice','Quot.sound']
for result in x['status']['main_results']:
 result['file']='Solution.lean';result['sorry_count']=0;result['axioms']=['propext','Classical.choice','Quot.sound']
x['review']['status']='final-review-pending'
x['review']['notes']='Two independent nonauthor statement approvals were frozen before proof. Authors /root and /root/iv06_statement_referee_1 do not count as independent final referees. Local Solution build and all four exact exported kernel trust/standard-three axiom audits passed; independent final reviews and actual isolated Linux Comparator remain pending.'
x['related_formalizations'][0]['note']='IE-15 padded-state layout was studied. The IE-14 complex column-only GEPP boundary and generic entrywise/actual-path helpers were adapted locally with attribution. No cross-project imports or substituted IE-14/IE-15 growth theorem are used.'
schema=json.loads((p/'../../../docs/lean/schema/v0.4.schema.json').read_text())
jsonschema.validate(x,schema)
(p/'formalization.yaml').write_text('# yaml-language-server: $schema=https://raw.githubusercontent.com/mathlib-initiative/formalization.yaml/99c678e569c7c4c0772db297c5ddd5e4c9b6322e/schema/v0.4.schema.json\n'+yaml.safe_dump(x,sort_keys=False,allow_unicode=True,width=100))
(p/'README.md').write_text('''# IE-13 Lean formalization

Mathematics attributed in the complete source to Matthew J. Colbrook, Cambridge;
substantial AI assistance and reconstruction disclosures are preserved. Higham
retains original-problem credit. Formalization: Sidney Holden with OpenAI Codex
assistance. Apache-2.0; no novelty, external human review or endorsement claimed.

The full dimension-independent complex GEPP growth target is proved locally for
all nonnegative bandwidth pairs, strengthening the original unequal-pair target.
Both zero-bandwidth cases, every admissible dimension, every allowed pivot tie,
and every intermediate entry are included. The sharp value is 1 for p=0 and
h(p,p+q) otherwise. A rational matrix of order 2p+q+1 attains the bound along its
actual full pivot path. The genuine real growth set is nonempty and bounded,
and its supremum is the stated sharp value.

Local status: Solution builds successfully, all four exported theorems pass
LeanCert kernel trust assertions, and their axiom closures are exactly
propext, Classical.choice and Quot.sound. Two independent nonauthor statement
reviews preceded implementation. Independent final reviews and the actual
isolated Linux Comparator are still pending. Canonical status is unchanged.

[NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) records the frozen contracts and
exact rational witness. [UPPER_PROOF_NOTES.md](UPPER_PROOF_NOTES.md) explains
the subset-sum envelope that derives the bound from every literal Schur path.
The witness modules verify actual rational LU factors, nonzero maximal pivots,
row-label transport and the attaining entry. All computation is exact finite
algebra; no numerical interval search is necessary. LeanCert audits the actual
exported proof closures in kernel mode.

The source manuscript and full informal review are retained under
references/colbrook-recovered-2026-09-11 at repository root. IE-14 generic
entrywise and actual-path code was adapted with attribution; IE-15's earlier
padded-state layout was studied. There are no cross-project Lean imports.
Exact finite diagnostics are transcription checks only. Shared reproduction
workflow credit and licenses remain in tools/lean/NOTICE.md.

Reproduce locally with `lake build Solution`. Run the isolated Linux workflow
through the repository's [reproduction guide](../../../docs/lean/README.md).
Author execution receipts are in verification/local-proof-20260922.json;
original reviewed metadata is retained in reviews/statement-original.
''')
assert [r['declaration'] for r in x['status']['main_results']]==names
cmd=[sys.executable,str(p/'../../../tools/lean/validate_manifest.py'),str(p)]
r=subprocess.run(cmd,text=True,capture_output=True)
(p/'verification/metadata-local-complete.log').write_text('Official formalization.yaml v0.4 schema PASS; four-export exact coverage PASS.\n'+r.stdout+r.stderr)
assert r.returncode==0,r.stdout+r.stderr
(p/'verification/metadata-local-complete.json').write_text(json.dumps({'verdict':'PASS','schema':'pinned official v0.4','exports':4,'validator_exit_code':0,'command':cmd},indent=2)+'\n')
files=[str(f.relative_to(p)) for f in sorted(p.glob('NLA/IE13/*.lean'))]+['Solution.lean','Challenge.lean','NUMERICAL_TARGETS.md','README.md','formalization.yaml','UPPER_PROOF_NOTES.md','lean-toolchain','lakefile.toml','lake-manifest.json','comparator.json','LICENSE','verification/solution-build-final.log','verification/AuthorAudit.lean','verification/axioms.log','verification/metadata-local-complete.log','verification/metadata-local-complete.json','verification/finish_local_proof.py']
h={f:sha(f) for f in files}
(p/'reviews/proof-source-hashes.json').write_text(json.dumps(h,indent=2)+'\n')
receipt={'verdict':'PASS','phase':'local proof completion; independent final reviews and actual Linux Comparator pending','build_exit_code':0,'build_jobs':int(m.group(1)),'build_command':'lake build Solution (pinned Lean 4.33.1 runtime)','audit_exit_code':0,'audit_command':'lake env lean verification/AuthorAudit.lean (pinned Lean 4.33.1 runtime)','exports':names,'permitted_and_actual_axioms':['propext','Classical.choice','Quot.sound'],'active_proof_holes':0,'frozen_statement_inputs_preserved':preserved,'proof_snapshot_sha256':sha('reviews/proof-source-hashes.json'),'hashes':h,'LeanCert_role':'Four actual exported kernel trust assertions; exact finite algebra and recurrences require no interval certificate','independent_final_reviews':'pending','isolated_linux_comparator':'pending'}
(p/'verification/local-proof-20260922.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(f'PASS: {len(h)} proof inputs frozen; all{len(statement)} statement inputs preserved;4 exports kernel standard-three only.')
