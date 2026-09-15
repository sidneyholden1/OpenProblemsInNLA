from pathlib import Path
import json,hashlib,zipfile,subprocess,re
p=Path(__file__).resolve().parent;root=p.parents[3];linux=p/'linux';r=json.loads((linux/'RUN.json').read_text());api=json.loads((linux/'github-run.json').read_text());a=json.loads((linux/'github-artifact.json').read_text());jobs=json.loads((linux/'github-attempt-jobs.json').read_text())['jobs'];z=linux/'lean-IV-03.zip';sha=lambda b:hashlib.sha256(b).hexdigest()
assert api['id']==r['run_id'] and api['head_sha']==r['verified_commit'] and api['run_attempt']==1 and api['conclusion']=='success'
assert a['id']==r['artifact_id'] and a['digest']=='sha256:'+sha(z.read_bytes())=='sha256:'+r['artifact_sha256']
j=next(j for j in jobs if j['name'].startswith('verify (IV-03,'));assert j['conclusion']=='success' and j['started_at']<=a['created_at']<=j['completed_at']
assert next(j for j in jobs if j['name']=='checker-controls')['conclusion']=='skipped'
with zipfile.ZipFile(z) as zz:
 assert zz.testzip() is None
 for f in zz.infolist():
  if not f.is_dir():assert zz.read(f)==(linux/'artifact'/f.filename).read_bytes(),f.filename
rp=next((linux/'artifact').rglob('result.json'));result=json.loads(rp.read_text());assert result['repository_commit']==r['verified_commit'] and result['result']=='comparator-accepted'
project=result['project'];cfg=result['config'];assert cfg['definition_names']==[] and set(cfg['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
roster=subprocess.check_output(['git','ls-tree','-r','--name-only',r['verified_commit'],'--',project],cwd=root,text=True).splitlines();assert {str(Path(f).relative_to(project)) for f in roster}==set(result['input_sha256'])
for f in roster:
 name=str(Path(f).relative_to(project));b=subprocess.check_output(['git','show',r['verified_commit']+':'+f],cwd=root);assert sha(b)==result['input_sha256'][name],name
assert sha(subprocess.check_output(['git','show',r['verified_commit']+':tools/lean/source-lock.json'],cwd=root))==result['source_lock_sha256']
assert result['tool_receipt']['source_lock_sha256']==result['source_lock_sha256']
log=(rp.parent/'comparator.log').read_text();assert log.rstrip().endswith('EXIT_STATUS=0')
for phase in ('Challenge','Solution'):
 x=re.findall(r'Exporting #\[(.*?)\] from '+phase,log);assert len(x)==1;assert set(cfg['theorem_names'])<={n.strip() for n in x[0].split(',')}
for n in cfg['theorem_names']:assert f"'{n}' depends on axioms: [propext, Classical.choice, Quot.sound]" in log
for marker in ['Running Lean default kernel on solution.','Lean default kernel accepts the solution','Your solution is okay!']:assert marker in log
ops=json.loads((p/'ROOT-LINUX-CHECKS.json').read_text());assert ops['verdict']=='PASS'
for name,check in ops['actual_per_project_controls'].items():
 t=(rp.parent/name).read_text();assert sha((rp.parent/name).read_bytes())==check['sha256'];assert t.rstrip().endswith('EXIT_STATUS='+str(check['expected_exit']))
 for marker in check['required_markers']:assert marker in t
out={'verdict':'PASS','reviewer':'/root/iv06_statement_referee_2; delegated publication and operational audit','verified_commit':r['verified_commit'],'run_id':r['run_id'],'attempt':1,'input_count':len(roster),'export_count':len(cfg['theorem_names']),'artifact_id':a['id'],'artifact_sha256':r['artifact_sha256'],'all_archive_members_match':True,'all_git_inputs_match':True,'actual_kernel_and_control_logs_inspected':True,'evidence_sha256':{str(f.relative_to(p)):sha(f.read_bytes()) for f in [linux/'RUN.json',linux/'github-run.json',linux/'github-artifact.json',linux/'github-attempt-jobs.json',rp,p/'ROOT-LINUX-CHECKS.json']},'separate_checker_job':'skipped; controls execute inside project verification','scope':'Operational acceptance only; independent semantic reviews retained separately','dependencies':'Pinned dependencies with official Mathlib cache, not a full dependency-source rebuild'}
(p/'OPERATIONAL-CHECKS.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
