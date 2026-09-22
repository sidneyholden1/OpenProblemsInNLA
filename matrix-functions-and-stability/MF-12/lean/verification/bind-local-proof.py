from pathlib import Path
import json,hashlib
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
old=json.loads(Path('reviews/statement-source-hashes.json').read_text())
checked={}
for k,v in old.items():
 p=Path('reviews/statement-review-snapshot')/k if k in ['README.md','formalization.yaml'] else Path(k)
 assert sha(p)==v,(k,sha(p),v)
 checked[k]={'actual_path':str(p),'sha256':v}
files=sorted([str(p) for p in Path('NLA').rglob('*.lean')]+['Solution.lean','Challenge.lean','NUMERICAL_TARGETS.md','README.md','formalization.yaml','comparator.json','lean-toolchain','lakefile.toml','lake-manifest.json','verification/solution-build-2.log','verification/axioms.log','verification/metadata-local.log'])
hashes={p:sha(p) for p in files}
Path('reviews/proof-source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
receipt={'verdict':'PASS','build_jobs':3110,'exports':4,'build_exit_code':0,'audit_exit_code':0,'kernel_assertions':4,'axioms':['propext','Classical.choice','Quot.sound'],'frozen_statement_inputs':checked,'proof_manifest_sha256':sha('reviews/proof-source-hashes.json'),'scope':'Full original target; final nonauthor reviews and Linux Comparator pending','source_authorship':'Mathematics attributed to Matthew J. Colbrook; formalization Sidney Holden with OpenAI Codex assistance'}
Path('verification/local-proof-20260922.json').write_text(json.dumps(receipt,indent=2)+'\n')
print('Bound',len(hashes),'proof inputs; all',len(checked),'frozen statement inputs preserved.')
