from pathlib import Path
import json,hashlib,subprocess
P=Path(__file__).resolve().parent.parent
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
snap=json.loads((P/'reviews/statement-source-hashes.json').read_text())
for f,h in snap.items():assert sha(P/f)==h,f
assert sha(P/'reviews/statement-source-hashes.json')=='3098cac38d80fbe4e2a3a7ec95f221c5e3f1ea7fb73e1fa5d86a99991fd649dd'
orig=(P/'../../../references/colbrook-matrix-2026-09-11/original-proofs/MI-04.tex').read_text()
rendered=(P/'../solution.tex').read_text()
assert orig in rendered,'complete original mathematical source must be embedded unchanged'
for x in json.loads((P/'verification/source-provenance.json').read_text())['source_files']:
 b=subprocess.check_output(['git','show','3212647d7b16dd1fc5bf33ed5c2b07a4b156dbf0:'+x['git_path']],cwd=P)
 assert hashlib.sha256(b).hexdigest()==sha(P/x['path'])
lib=['Mathlib/Analysis/CStarAlgebra/Matrix.lean','Mathlib/LinearAlgebra/Matrix/PosDef.lean','Mathlib/LinearAlgebra/Matrix/Hermitian.lean','Mathlib/Analysis/InnerProductSpace/PiL2.lean']
extra=['verification/Referee2StatementProbe.lean','verification/referee-2-statement-probe.log','verification/referee_2_statement_check.py','reviews/statement-source-hashes.json','../../../docs/lean/REVIEW.md']
out={'verdict':'APPROVE','reviewer':'OpenAI Codex /root/iv06_statement_referee_2; independent AI nonauthor','phase':'statements only','candidate_inputs':snap,'own_probe_exit_code':0,'own_probe_command':'PATH=/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:$PATH lake env lean verification/Referee2StatementProbe.lean','original_tex_embedded_unchanged':True,'five_source_files_match_immutable_base':True,'evidence_sha256':{f:sha(P/f) for f in extra},'imported_source_sha256':{f:sha(P/'.lake/packages/mathlib'/f)for f in lib},'limits':['Challenge placeholders establish no target theorem.','Own probe checks exact definitions/norms and scalar/dimension-one endpoint only.','Author finite1320rescaling diagnostic inspected, not claimed as independently authored or as universal proof.','Full proof, final reviews and isolated Linux Comparator remain pending.']}
(P/'reviews/referee-2-statement-evidence.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'verdict':'APPROVE','candidate_inputs':len(snap),'evidence_sha256':sha(P/'reviews/referee-2-statement-evidence.json')},indent=2))
