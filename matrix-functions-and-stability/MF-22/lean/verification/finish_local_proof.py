"""Freeze MF-22 local completion from hash-bound successful build and audit receipts; never claims Linux/publication acceptance.
Run only when both proof authors report the complete Solution ready.
"""
from pathlib import Path
import hashlib,json,re,shutil,subprocess,os,sys
import yaml,jsonschema
p=Path(__file__).resolve().parents[1]
def sha(f): return hashlib.sha256((p/f).read_bytes()).hexdigest()
env=os.environ.copy();env['PATH']='/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:'+env['PATH']
assert (p/'Solution.lean').exists(),'Solution must be complete before local freeze'
config=json.loads((p/'comparator.json').read_text());names=config['theorem_names'];assert len(names)==4
statement=json.loads((p/'reviews/statement-source-hashes.json').read_text())
for f,h in statement.items():
 original=p/('reviews/statement-original/'+f) if f in ['README.md','formalization.yaml'] and (p/('reviews/statement-original/'+f)).exists() else p/f
 assert hashlib.sha256(original.read_bytes()).hexdigest()==h,(f,'statement changed')
for f in [*p.glob('NLA/MF22/*.lean'),p/'Solution.lean']:
 assert not re.search(r'\b(sorry|admit|native_decide|axiom|unsafe)\b',f.read_text()),f
completion=json.loads((p/'verification/author-local-completion.json').read_text())
assert completion['build_exit_code']==0 and completion['consumer_exit_code']==0
for group in ['sha256','active_source_sha256']:
 for f,h in completion[group].items():assert sha(f)==h,(f,'stale completion receipt')
log=(p/'verification/solution-build-final.log').read_text()
auditlog=(p/'verification/author-audit.log').read_text()
m=re.search(r'Build completed successfully \((\d+) jobs\)',log);assert m
assert not re.search(r'\berror:',auditlog)
for name in names:
 assert "'"+name+"' depends on axioms: [propext, Classical.choice, Quot.sound]" in auditlog
preserved={}
for f,h in statement.items():
 dst='reviews/statement-original/'+f if f in ['README.md','formalization.yaml'] else f
 if dst!=f and not (p/dst).exists():
  assert sha(f)==h
  (p/dst).parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(p/f,p/dst)
 assert sha(dst)==h
 preserved[f]=dst
x=yaml.safe_load((p/'formalization.yaml').read_text())
x['status']['scope']='Complete local kernel proof of the original polynomial conditioning question and stronger linear bound for every fixed real rho>0, including rho²=10, for the exact uncorrected complex 2n-by-2n Toeplitz truncations. Eventual nonsingularity, actual uniformly bounded inverse entries and genuine induced Euclidean operator norms are proved. All spectral, noncancellation, boundary and inverse bridges are discharged. Two independent statement approvals preceded proof. Independent final reviews and actual isolated Linux Comparator remain pending; canonical status unchanged.'
x['status']['sorry_count']=0;x['status']['sorry_in_definitions']=0
x['status']['axioms']=['propext','Classical.choice','Quot.sound']
for result in x['status']['main_results']:
 result['file']='Solution.lean';result['sorry_count']=0;result['axioms']=['propext','Classical.choice','Quot.sound']
x['review']['status']='final-review-pending'
x['review']['notes']='Two independent nonauthor statement approvals were frozen before proof. Authors /root/iv06_statement_referee_2 and /root/new_target_screen are excluded as independent final referees. Local complete Solution and separate exact four-signature consumers passed LeanCert kernel assertions with only standard-three axioms. Independent final reviews and actual isolated Linux Comparator remain pending.'
x['automation']['methods'][0]['tool_setup']='Lean 4.33.1, exact pinned Mathlib/LeanCert HTTPS dependencies, separate trusted Challenge and complete Solution; actual exported proof closures checked in kernel mode.'
jsonschema.validate(x,json.loads((p/'../../../docs/lean/schema/v0.4.schema.json').read_text()))
assert [a['declaration'] for a in x['status']['main_results']]==names
(p/'formalization.yaml').write_text('# yaml-language-server: $schema=https://raw.githubusercontent.com/mathlib-initiative/formalization.yaml/99c678e569c7c4c0772db297c5ddd5e4c9b6322e/schema/v0.4.schema.json\n'+yaml.safe_dump(x,sort_keys=False,allow_unicode=True,width=100))
(p/'README.md').write_text('''# MF-22 Lean formalization

The complete original polynomial-conditioning target is proved locally, with the stronger linear bound for every fixed positive real parameter in the exact 2n-by-2n cubic C1 spline Schrödinger Toeplitz family. The exceptional parameter rho²=10 and the original uncorrected boundaries are included. Constants depend on the parameter and precede the quantifier over all sufficiently large integer sizes.

The four exports prove a dimension-independent forward spectral norm bound, eventual nonsingularity and actual uniformly bounded inverse entries, the linear spectral condition bound, and the original extended condition-number target with exponent1. Singular inputs have infinite condition number in the definition. Matrix norms are genuinely induced Euclidean operator norms; the inverse is Mathlib's actual matrix inverse. No root, spectral, transfer, boundary or inverse assertion is left as a final hypothesis.

Local status: complete Solution build and four exact-signature author consumers pass LeanCert kernel assertions; actual transitive axiom closures contain only propext, Classical.choice and Quot.sound. Two independent nonauthor statement reviews preceded proof. Independent final reviews and actual isolated Linux Comparator remain pending. Canonical status is unchanged.

[NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) retains the frozen contracts. [ANALYTIC_PROOF_NOTES.md](ANALYTIC_PROOF_NOTES.md) describes exact coprimality, the exceptional/nonexceptional Cayley roots, finite eigenbasis and adjugate visibility, and Green cancellation. Actual finite boundary reconstruction turns the forced-state Green response into the literal Toeplitz inverse. Fixed sparsity gives a uniform forward L2 norm, and the entrywise inverse bound gives the linear inverse L2 norm. All symbolic computations are exact; no interval root search or numerical oracle is needed.

Source mathematics: George Stepaniants, Caltech, complete solution.md/solution.tex. Bogoya, Böttcher, Ferrari, Grudsky and Serra-Capizzano retain original family/question credit. Source substantial ChatGPT/Codex assistance and automated-review disclosures remain intact. Formalization: Sidney Holden with OpenAI Codex assistance, Apache-2.0. No novelty, external human review or source-author endorsement claimed. Mathlib, LeanCert, Comparator and formalization.yaml retain licenses and credit; no cross-project theorem import.

Reproduce with `lake build Solution` using the pinned toolchain. Local receipts are in verification/local-proof-20260922.json; original reviewed metadata is retained in reviews/statement-original. The isolated Linux workflow is described in [the reproduction guide](../../../docs/lean/README.md). Exact diagnostic checks are transcription checks only, not substitutes for the all-parameter proof.
''')
validator=[sys.executable,str(p/'../../../tools/lean/validate_manifest.py'),str(p)]
v=subprocess.run(validator,cwd=p,text=True,capture_output=True)
(p/'verification/metadata-local-complete.log').write_text('Official v0.4 schema and four-export coverage PASS.\n'+v.stdout+v.stderr)
assert v.returncode==0,v.stdout+v.stderr
(p/'verification/metadata-local-complete.json').write_text(json.dumps({'verdict':'PASS','schema':'official pinned v0.4','exports':4,'validator_exit_code':0,'command':validator},indent=2)+'\n')
files=[str(f.relative_to(p)) for f in sorted(p.glob('NLA/MF22/*.lean'))]+['Solution.lean','Challenge.lean','NUMERICAL_TARGETS.md','README.md','formalization.yaml','ANALYTIC_PROOF_NOTES.md','PROOF_NOTES.md','verification/author-local-completion.json','verification/analytic-author-receipt.json','verification/AnalyticAuthorAudit.lean','verification/analytic-author-audit.log','lean-toolchain','lakefile.toml','lake-manifest.json','comparator.json','LICENSE','verification/solution-build-final.log','verification/AuthorAudit.lean','verification/author-audit.log','verification/metadata-local-complete.log','verification/metadata-local-complete.json','verification/finish_local_proof.py']
hashes={f:sha(f) for f in files}
(p/'reviews/proof-source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
receipt={'verdict':'PASS','phase':'complete local proof; final independent reviews and actual Linux pending','build_exit_code':completion['build_exit_code'],'build_jobs':int(m.group(1)) if m else None,'audit_exit_code':completion['consumer_exit_code'],'exports':names,'actual_axioms':['propext','Classical.choice','Quot.sound'],'active_proof_holes':0,'frozen_statement_inputs_preserved':preserved,'proof_snapshot_sha256':sha('reviews/proof-source-hashes.json'),'hashes':hashes,'independent_final_reviews':'pending','isolated_linux_comparator':'pending'}
(p/'verification/local-proof-20260922.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(f'PASS: {len(hashes)} final proof inputs; all{len(statement)} frozen statement inputs preserved;4 exact consumers kernel checked.')
