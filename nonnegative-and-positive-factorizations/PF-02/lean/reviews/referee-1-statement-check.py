"""Bind independent PF-02 statement inspection and diagnostics to exact bytes."""
from pathlib import Path
import hashlib, json, subprocess

project=Path(__file__).resolve().parents[1]
root=project.parents[2]
sha=lambda b:hashlib.sha256(b).hexdigest()
receipt=json.loads((project/'verification/statement-source-hashes.json').read_text())
files={}
for name, expected in receipt['files_sha256'].items():
    actual=sha((project/name).read_bytes())
    assert actual==expected,(name,actual,expected)
    files[name]=actual
sources={}
for item in receipt['sources']:
    name=item['path']; content=(root/name).read_bytes()
    assert sha(content)==item['sha256']
    for rev in [receipt['source_base'],'deb549fa9ddd6b119e6c59016f268237e645dfa2']:
        assert subprocess.check_output(['git','show',rev+':'+name],cwd=root)==content
    sources[name]=sha(content)
build=json.loads((project/'verification/statement-build.json').read_text())
assert build['exit_code']==0 and build['intentional_placeholders']==9
log=(project/'verification/statement-build.log').read_bytes()
assert sha(log)==build['log_sha256']
assert log.count(b'declaration uses `sorry`')==9
assert b'Build completed successfully (2397 jobs).' in log
assert json.loads((project/'lake-manifest.json').read_text())['name']=='NLAPF02'
comparator=json.loads((project/'comparator.json').read_text())
assert comparator['theorem_names']==['NLA.PF02.'+n for n in receipt['exports']]
assert comparator['definition_names']==[]
assert set(comparator['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
for name in ['formalization.yaml','comparator.json','verification/statement-source-hashes.json','reviews/referee-1-exact-precheck.py','reviews/referee-1-exact-precheck.json','reviews/referee-1-statement-check.py']:
    files[name]=sha((project/name).read_bytes())
mathlib=project/'.lake/packages/mathlib'
depfiles=['Mathlib/LinearAlgebra/Matrix/PosDef.lean','Mathlib/LinearAlgebra/Matrix/Hermitian.lean','Mathlib/LinearAlgebra/Matrix/Rank.lean','Mathlib/LinearAlgebra/Matrix/Trace.lean','Mathlib/Topology/Constructions.lean','Mathlib/Topology/Instances/Matrix.lean','Mathlib/Topology/Connected/Basic.lean','Mathlib/Topology/Connected/TotallyDisconnected.lean','Mathlib/Topology/Instances/Sign.lean','Mathlib/Topology/Order/IntermediateValue.lean','Mathlib/Order/Lattice/Nat.lean']
output={'verdict':'APPROVE','reviewer':'Independent Codex AI agent /root/iv06_statement_referee_2, assigned statement referee 1 for PF-02','phase':'statement only','source_base':receipt['source_base'],'sources_equal_deb549fa':True,'sources_sha256':sources,'files_sha256':files,'mathlib_commit':subprocess.check_output(['git','rev-parse','HEAD'],cwd=mathlib,text=True).strip(),'inspected_dependency_files_sha256':{p:sha((mathlib/p).read_bytes()) for p in depfiles},'exports':receipt['exports'],'build_attribution':'Coordinator/author-run Challenge build; independently inspected receipt/log and hashes, not rerun by referee','build_exit_code':0,'build_jobs':2397,'intentional_placeholders':9,'independent_numerical_diagnostic':'reviews/referee-1-exact-precheck.py, executed exit 0; exact finite diagnostics only','resolved_finding':'Manifest name corrected from NLAIV06 to NLAPF02 before final hash check; dependency revisions unchanged','limitations':['No proof implementation reviewed or approved','No Linux Comparator or final export axiom audit performed','Sample congruence calculations are diagnostics, not a proof of the generic polynomial identity','Metadata is draft; later implementation and completion claims need final review']}
(project/'reviews/referee-1-statement-checks.json').write_text(json.dumps(output,indent=2)+'\n')
print(json.dumps({'verdict':output['verdict'],'checked_files':len(files),'checked_sources':len(sources),'exports':len(output['exports'])}))
