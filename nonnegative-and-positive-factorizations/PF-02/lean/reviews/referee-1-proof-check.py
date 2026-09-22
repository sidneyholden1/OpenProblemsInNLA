"""Hash-bind independently inspected PF-02 proof and completed local evidence."""
from pathlib import Path
import hashlib,json,re,subprocess
p=Path(__file__).resolve().parents[1];root=p.parents[2]
sha=lambda f:hashlib.sha256(f.read_bytes()).hexdigest()
freeze=json.loads((p/'verification/statement-freeze.json').read_text())
for name,h in freeze['files_sha256'].items():assert sha(p/name)==h,name
local=json.loads((p/'verification/local-proof.json').read_text())
for name,h in local['sha256'].items():assert sha(p/name)==h,name
for item in freeze['sources']:
    assert sha(root/item['path'])==item['sha256']
    assert subprocess.check_output(['git','show',freeze['source_base']+':'+item['path']],cwd=root)==(root/item['path']).read_bytes()
names=json.loads((p/'comparator.json').read_text())['theorem_names']
consumer=(p/'reviews/referee-1-consumer.log').read_text()
assert consumer.count('depends on axioms:')==9
assert 'error:' not in consumer
for n in names:assert "'"+n+"' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]" in consumer,n
terms=(p/'reviews/referee-1-material-terms.log').read_text()
assert terms.count('of_decide_eq_true (id (Eq.refl true))')==3
assert 'error:' not in terms
poly=(p/'reviews/referee-1-polynomial-inspection.log').read_text()
assert 'Generic polynomial proof constants (252)' in poly
assert 'Mathlib.Tactic.Ring.of_eq' in poly and 'Matrix.det_succ_row_zero' in poly
assert 'error:' not in poly
retention=(p/'reviews/referee-1-retention.log').read_text()
assert retention.count('Material proof retained:')==4
for n in ['witnessM_det','witness_coordinates_det','reflected_coordinates_det','congruence_coordinate_det']:assert 'NLA.PF02.'+n in retention
assert 'error:' not in (p/'reviews/referee-1-numeric-replay.log').read_text()
proofs=['NLA/PF02/Definitions.lean','NLA/PF02/Numeric.lean','NLA/PF02/StructuralBase.lean','NLA/PF02/Structural.lean','Solution.lean']
for f in proofs:
    text=(p/f).read_text()
    assert not re.search(r'^\s*(axiom|unsafe|opaque)\s',text,re.M)
    assert not re.search(r'\b(sorry|admit|native_decide)\b',text)
evidence=['reviews/referee-1-consumer.lean','reviews/referee-1-consumer.log','reviews/referee-1-material-terms.lean','reviews/referee-1-material-terms.log','reviews/referee-1-material-terms-initial.lean','reviews/referee-1-material-terms-initial.log','reviews/referee-1-polynomial-inspection.lean','reviews/referee-1-polynomial-inspection.log','reviews/referee-1-retention.lean','reviews/referee-1-retention.log','reviews/referee-1-numeric-replay.log','reviews/referee-1-proof-check.py','verification/local-proof.json','verification/solution-local.log','verification/structural-axioms.log']
active={f:sha(p/f) for f in proofs+['Challenge.lean','NUMERICAL_TARGETS.md','formalization.yaml','comparator.json','lakefile.toml','lake-manifest.json','lean-toolchain','verification/statement-freeze.json']}
(p/'reviews/referee-1-active-inputs.json').write_text(json.dumps(active,indent=2)+'\n')
out={'verdict':'PASS','phase':'independent final code review, local only','reviewer':'Codex AI agent /root/iv06_statement_referee_2, final referee 1, nonauthor','consumer_exit_code':0,'numeric_replay_exit_code':0,'material_term_command_exit_code':0,'polynomial_body_inspection_exit_code':0,'retention_exit_code':0,'initial_material_diagnostic_exit_code':1,'exports':names,'actual_axioms':['propext','Classical.choice','Quot.sound'],'frozen_statement_unchanged':True,'source_base':freeze['source_base'],'active_inputs_sha256':sha(p/'reviews/referee-1-active-inputs.json'),'evidence_sha256':{f:sha(p/f) for f in evidence},'commands':[['lake','env','lean','reviews/referee-1-consumer.lean'],['lake','env','lean','NLA/PF02/Numeric.lean'],['lake','env','lean','reviews/referee-1-material-terms.lean'],['lake','env','lean','reviews/referee-1-polynomial-inspection.lean'],['lake','env','lean','reviews/referee-1-retention.lean']],'runtime':'/private/tmp/nla-lean-runtime/lean-4.33.1-darwin_aarch64/bin','platform':'macOS aarch64','limits':['Linux Comparator/default-kernel and operational controls still pending','Coordinator whole-Solution build was inspected, not independently repeated in full','Material-term pretty printer abbreviates deep integer casts and could not render generic polynomial expression; its actual proof-body constants were inspected separately and Numeric.lean independently re-elaborated successfully','First printer probe used unknown pp.maxDepth option; original failure retained; no mathematical source error','LeanCert used for actual exported trust audits, not artificial interval computation']}
(p/'reviews/referee-1-proof-checks.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'verdict':'PASS','exports':len(names),'frozen_inputs_checked':len(freeze['files_sha256']),'active_sources':len(proofs)}))
