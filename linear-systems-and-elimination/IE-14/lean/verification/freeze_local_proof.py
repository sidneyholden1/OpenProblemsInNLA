from pathlib import Path
import hashlib,json,re
p=Path(__file__).resolve().parents[1]
def sha(f):return hashlib.sha256((p/f).read_bytes()).hexdigest()
s=json.loads((p/'reviews/statement-source-hashes.json').read_text())
preserved={f:('reviews/statement-original/'+f if f in ['README.md','formalization.yaml'] else f) for f in s}
assert all(sha(preserved[f])==h for f,h in s.items())
log=(p/'verification/solution-build-final.log').read_text();audit=(p/'verification/axioms.log').read_text()
assert 'Build completed successfully (3086 jobs).' in log
names=json.loads((p/'comparator.json').read_text())['theorem_names']
for name in names:assert f"'{name}' depends on axioms: [propext, Classical.choice, Quot.sound]" in audit
for f in [*p.glob('NLA/IE14/*.lean'),p/'Solution.lean']:
 assert not re.search(r'\b(sorry|admit|native_decide|axiom|unsafe)\b',f.read_text()),f
files=[str(f.relative_to(p)) for f in sorted(p.glob('NLA/IE14/*.lean'))]+['Solution.lean','Challenge.lean','NUMERICAL_TARGETS.md','README.md','formalization.yaml','lean-toolchain','lakefile.toml','lake-manifest.json','comparator.json','LICENSE','verification/solution-build-final.log','verification/AuthorAudit.lean','verification/axioms.log','verification/metadata-local-complete.log','verification/metadata-local-complete.json','verification/freeze_local_proof.py']
h={f:sha(f) for f in files}
(p/'reviews/proof-source-hashes.json').write_text(json.dumps(h,indent=2)+'\n')
r={'verdict':'PASS','phase':'local proof completion, pending independent final review and isolated Linux Comparator','build_exit_code':0,'build_jobs':3086,'build_command':'PATH=/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:$PATH lake build Solution','audit_exit_code':0,'audit_command':'PATH=/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:$PATH lake env lean verification/AuthorAudit.lean','exports':names,'permitted_and_actual_axioms':['propext','Classical.choice','Quot.sound'],'active_proof_holes':0,'frozen_statement_inputs_preserved':preserved,'proof_snapshot_sha256':sha('reviews/proof-source-hashes.json'),'hashes':h,'LeanCert_role':'Four actual exported kernel trust assertions, plus helper kernel audits; exact symbolic algebra and finite recurrences require no interval certificate','independent_final_reviews':'pending','isolated_linux_comparator':'pending'}
(p/'verification/local-proof-20260922.json').write_text(json.dumps(r,indent=2)+'\n')
print(f'PASS: {len(h)} proof inputs frozen; all16 statement inputs preserved;4 exports kernel standard-three only.')
