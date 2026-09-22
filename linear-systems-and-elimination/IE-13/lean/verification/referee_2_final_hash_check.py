"""Independent IE-13 final frozen-input/axiom evidence check; no proof edits."""
from pathlib import Path
import hashlib,json
P=Path(__file__).resolve().parent.parent
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
proof=json.loads((P/'reviews/proof-source-hashes.json').read_text())
statement=json.loads((P/'reviews/statement-source-hashes.json').read_text())
local=json.loads((P/'verification/local-proof-20260922.json').read_text())
for f,h in proof.items(): assert sha(P/f)==h, f
mapped=local['frozen_statement_inputs_preserved']
for f,h in statement.items(): assert sha(P/mapped[f])==h, f
gate=json.loads((P/'reviews/statement-gate.json').read_text())
for f,h in gate['review_reports_sha256'].items(): assert sha(P/f)==h,f
assert sha(P/'reviews/statement-source-hashes.json')==gate['statement_manifest_sha256']
assert sha(P/'reviews/proof-source-hashes.json')==local['proof_snapshot_sha256']
active=[f for f in proof if f.startswith('NLA/') or f=='Solution.lean']
for f in active:
 s=(P/f).read_text()
 assert not any(x in s for x in ['by sorry','sorryAx','native_decide','import Challenge','axiom ']),f
names=['NLA.IE13.'+n for n in ['upper_bound','rational_attainment','sharp_maximum','original_target']]
log=(P/'verification/referee-2-final-consumer.log').read_text()
assert 'error' not in log
for n in names: assert "'"+n+"' depends on axioms: [propext, Classical.choice, Quot.sound]" in log,n
libraries=['Mathlib/Data/Finset/Lattice/Fold.lean','Mathlib/LinearAlgebra/Matrix/Block.lean','Mathlib/LinearAlgebra/Matrix/Determinant/Basic.lean','Mathlib/Analysis/Complex/Norm.lean','Mathlib/Order/Bounds/Defs.lean','Mathlib/Order/ConditionallyCompletePartialOrder/Basic.lean']
extra=['reviews/proof-source-hashes.json','reviews/statement-source-hashes.json','reviews/statement-gate.json','verification/local-proof-20260922.json','verification/Referee2FinalConsumer.lean','verification/referee-2-final-consumer.log','verification/Referee2FinalConsumer-initial.lean','verification/referee-2-final-consumer-initial.log','verification/referee_2_final_hash_check.py','../../../docs/lean/REVIEW.md']
evidence={f:sha(P/f) for f in extra}
for f in libraries: evidence['.lake/packages/mathlib/'+f]=sha(P/'.lake/packages/mathlib'/f)
evidence['.lake/packages/LeanCert/LeanCert/Tactic/Verification.lean']=sha(P/'.lake/packages/LeanCert/LeanCert/Tactic/Verification.lean')
out={'verdict':'PASS','reviewer':'OpenAI Codex /root/iv06_statement_referee_2; AI nonauthor of IE-13','phase':'independent local final proof review; isolated Linux Comparator pending','consumer_exit_code':0,'consumer_command':'PATH=/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:$PATH lake env lean verification/Referee2FinalConsumer.lean','initial_consumer_exit_code':1,'initial_consumer_limitation':'The referee initially reversed #assert_trust arguments; four exact signatures and axiom queries succeeded, four audit commands failed to parse kernel as theorem. Initial script/log preserved. Only referee consumer syntax changed before successful repeat.','proof_input_count':len(proof),'active_lean_file_count':len(active),'statement_input_count':len(statement),'proof_inputs':proof,'preserved_statement_inputs':{f:{'location':mapped[f],'sha256':h}for f,h in statement.items()},'evidence_sha256':evidence,'exports':names,'actual_export_axioms':['propext','Classical.choice','Quot.sound'],'LeanCert_role':'Actual transitive kernel trust assertions for every export; no interval numerical certificates needed by these exact finite proofs.','author_build':{'jobs':3096,'exit_code':0,'attribution':'Coordinator/author build, log independently inspected; not claimed as referee-run build.'},'limitations':['Independent exact-signature consumer is local macOS; isolated Linux Comparator/default-kernel sandbox not yet reviewed.','No external human review or source-author endorsement claimed.','Finite rational diagnostics are transcription checks, not universal proof.']}
(P/'reviews/referee-2-final-evidence.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'verdict':'PASS','proof_inputs':len(proof),'active_lean_files':len(active),'statement_inputs':len(statement),'evidence_sha256':sha(P/'reviews/referee-2-final-evidence.json')},indent=2))
