from pathlib import Path
import hashlib,json,re
p=Path(__file__).resolve().parent.parent
sha=lambda f:hashlib.sha256(f.read_bytes()).hexdigest()
proof=json.loads((p/'reviews/proof-source-hashes.json').read_text())
for f,h in proof.items():assert sha(p/f)==h,f
stmt=json.loads((p/'reviews/statement-source-hashes.json').read_text())
preserved={}
for f,h in stmt.items():
 q=p/f
 if sha(q)!=h:q=p/'reviews/statement-original'/f
 assert sha(q)==h,f
 preserved[f]=str(q.relative_to(p))
active={};pending=['Solution.lean']
while pending:
 f=pending.pop()
 if f in active:continue
 text=(p/f).read_text();active[f]=sha(p/f)
 assert not re.search(r'\b(sorry|axiom|native_decide|implemented_by)\b',text),f
 for name in re.findall(r'^import (\S+)',text,re.M):
  if name.startswith('NLA.MI04.'):pending.append(name.replace('.','/')+'.lean')
log=(p/'verification/referee-2-final-consumer.log').read_text()
assert 'error:' not in log
assert log.count('[propext, Classical.choice, Quot.sound]')==4
sources=['../README.md','../solution.md','../solution.tex','../../../references/colbrook-matrix-2026-09-11/original-proofs/MI-04.tex','../../../references/colbrook-matrix-2026-09-11/verification/reviews/MI-04-review.md','../../../docs/lean/REVIEW.md']
imports=['Analysis/CStarAlgebra/Matrix.lean','Analysis/Matrix/Order.lean','LinearAlgebra/Matrix/PosDef.lean','LinearAlgebra/Matrix/SchurComplement.lean','Analysis/CStarAlgebra/ContinuousFunctionalCalculus/Order.lean','Analysis/CStarAlgebra/ContinuousFunctionalCalculus/Instances.lean','Analysis/InnerProductSpace/Adjoint.lean','Analysis/InnerProductSpace/PiL2.lean']
evidence=['verification/Referee2FinalConsumer.lean','verification/referee-2-final-consumer.log','verification/referee_2_final_check.py','reviews/proof-source-hashes.json','verification/local-proof-20260922.json']
r={'verdict':'APPROVE','reviewer':'OpenAI Codex /root/iv06_statement_referee_2; independent AI nonauthor','consumer_exit_code':0,'consumer_command':'PATH=/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:$PATH lake env lean verification/Referee2FinalConsumer.lean','active_source_sha256':active,'frozen_proof_inputs':proof,'frozen_statement_inputs_preserved':preserved,'source_sha256':{f:sha(p/f) for f in sources},'imported_source_sha256':{f:sha(p/'.lake/packages/mathlib/Mathlib'/f) for f in imports},'evidence_sha256':{f:sha(p/f) for f in evidence},'actual_export_axioms':['propext','Classical.choice','Quot.sound'],'scope':'Full canonical necessity and all orthonormal-pair modulus symmetry; optional source converse/equivalences excluded.','limits':['Independent AI source/code review and fresh exact local kernel consumer. No human endorsement.','Author build and metadata logs inspected and attributed, not duplicated.','LeanCert is used for genuine kernel trust audits, not numerical interval certificates.','Isolated Linux Comparator still pending.']}
(p/'reviews/referee-2-final-evidence.json').write_text(json.dumps(r,indent=2)+'\n')
print('PASS',len(proof),'frozen proof inputs;',len(stmt),'preserved statement inputs;',len(active),'active source files')
