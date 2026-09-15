import json,hashlib,subprocess,zipfile
from pathlib import Path
root=Path.cwd();base=root/'docs/lean/verification-2026-09-15/PF-02/linux'
run=json.loads((base/'RUN.json').read_text());commit=run['verified_commit'];adir=base/'artifact/verify-20260915T023008Z-4834'
res=json.loads((adir/'result.json').read_text());assert res['repository_commit']==commit
sha=lambda b:hashlib.sha256(b).hexdigest()
checks={};inputs={}
for p,h in res['input_sha256'].items():
 data=subprocess.check_output(['git','show',f'{commit}:{res["project"]}/{p}'])
 actual=sha(data);assert actual==h,(p,actual,h);inputs[p]=actual
assert len(inputs)==57
for p,h in run['active_source_sha256'].items():assert sha((base/'active-source'/p).read_bytes())==h==inputs[p]
zp=base/'lean-PF-02.zip';zh=sha(zp.read_bytes());assert zh==run['artifact_sha256']
archive={}
with zipfile.ZipFile(zp) as z:
 assert z.testzip() is None
 for n in z.namelist():
  if not n.endswith('/'):
   b=z.read(n);assert (base/'artifact'/n).read_bytes()==b
   archive[n]=sha(b)
github=json.loads((base/'github-run.json').read_text());live=json.loads((base/'referee-1-live-run.json').read_text())
assert github['id']==live['id']==run['run_id']
assert github['head_sha']==live['head_sha']==commit
assert github['run_attempt']==live['run_attempt']==1
assert github['conclusion']==live['conclusion']=='success'
artifact=json.loads((base/'github-artifact.json').read_text());liveartifact=json.loads((base/'referee-1-live-artifact.json').read_text())
assert artifact['id']==liveartifact['id']==run['artifact_id']
assert artifact['digest']==liveartifact['digest']=='sha256:'+zh
assert artifact['workflow_run']['head_sha']==liveartifact['workflow_run']['head_sha']==commit
assert artifact['size_in_bytes']==liveartifact['size_in_bytes']==zp.stat().st_size
config=json.loads((base/'active-source/comparator.json').read_text());assert config==res['config']
assert len(config['theorem_names'])==9 and len(set(config['theorem_names']))==9
assert config['definition_names']==[]
assert set(config['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
log=(adir/'comparator.log').read_text()
for n in config['theorem_names']:
 assert log.count(n)>=3
 assert f"'{n}' depends on axioms: [propext, Classical.choice, Quot.sound]" in log
for m in ['Building Challenge','Building Solution','Built NLA.PF02.Structural','Built NLA.PF02.Numeric','Running Lean default kernel on solution.','Lean default kernel accepts the solution','Your solution is okay!','EXIT_STATUS=0']:assert m in log
for f,status in [('negative-sorry.log',1),('negative-native.log',1),('kernel-controls.log',0),('comparator-controls.log',0),('sandbox.log',0),('user-service.log',0),('dependencies.log',0),('mathlib-cache.log',0)]:
 txt=(adir/f).read_text();assert f'EXIT_STATUS={status}' in txt;checks[f]={'sha256':sha((adir/f).read_bytes()),'expected_exit':status}
assert "Illegal axiom detected: 'sorryAx'" in (adir/'negative-sorry.log').read_text()
assert "Illegal axiom detected: 'checked._native.native_decide.ax_1_1'" in (adir/'negative-native.log').read_text()
assert 'PASS: all three actual Comparator.runBuiltinKernel cases behaved as required' in (adir/'kernel-controls.log').read_text()
assert 'PASS: all five Comparator regressions' in (adir/'comparator-controls.log').read_text()
sand=(adir/'sandbox.log').read_text()
for m in ['MODE build: exit=0','MODE export: exit=0','PASS outside .lake truncate: denied','PASS symlink from .lake to outside write: denied','PASS build .lake write: allowed','PASS export .lake write-open: denied','PASS host parent: absent','PASS host loopback listener: unreachable','PASS AF_UNIX socket creation: denied','PASS effective capabilities: none','PASS no_new_privs: set','PASS nested namespace write attempt: rejected','NEGATIVE unknown option: exit=2','NEGATIVE unexpected --rw: exit=2','NEGATIVE unexpected --rwx: exit=2','NEGATIVE relative --rwx: exit=2','Outer and export fixture contents unchanged; only designated build fixture written.']:assert m in sand
harness={}
for p in ['tools/lean/harness.py','tools/lean/source-lock.json','.github/workflows/lean-verification.yml']:
 data=subprocess.check_output(['git','show',f'{commit}:{p}']);assert data==(root/p).read_bytes();harness[p]=sha(data)
assert harness['tools/lean/source-lock.json']==res['source_lock_sha256']==res['tool_receipt']['source_lock_sha256']
assert res['tool_receipt']['platform'].startswith('Linux-') and 'x86_64-unknown-linux-gnu' in res['tool_receipt']['lean_version']
other={str(p.relative_to(base)):sha(p.read_bytes()) for p in base.glob('*.json') if not p.name.startswith('referee-1-operational')}
out={'verdict':'PASS','reviewer':'/root/iv06_statement_referee_1; PF02 structural coauthor, operational review independent of evidence collection only','commit':commit,'all_57_git_inputs':inputs,'active_source_count':len(run['active_source_sha256']),'original_zip_sha256':zh,'archive_entries_verified':archive,'control_logs':checks,'harness_hashes':harness,'metadata_hashes':other,'exports':config['theorem_names'],'actual_linux':True,'fresh_live_github_identity_and_digest_verified':True,'limits':['No new Linux rerun or binary rebuild; reviewed retained actual run independently.','Dependency cache used; not a full dependency-source rebuild.','Not an independent mathematical code review; reviewer coauthored Structural modules.','Sandbox controls establish enumerated fixture results, not exhaustive operating-system security.']}
(base/'referee-1-operational-evidence.json').write_text(json.dumps(out,indent=2)+'\n')
print(f'PASS: all {len(inputs)} Git input hashes, {len(archive)} archive entries, {len(config["theorem_names"])} exports and all enumerated controls; live GitHub identity/digest match.')
