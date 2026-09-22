from pathlib import Path
import json, hashlib, subprocess, zipfile, re, sys
H=lambda b:hashlib.sha256(b).hexdigest()
for item in json.loads(Path('/private/tmp/nla-fourth-five/projects.json').read_text()):
 if item['id'] not in sys.argv[1:]:continue
 root=Path(item['root']); audit=root/'docs/lean/reverification-2026-09-14'/item['id']; linux=audit/'linux'
 run=json.loads((linux/'RUN.json').read_text()); api=json.loads((linux/'github-run.json').read_text()); art=json.loads((linux/'github-artifact.json').read_text()); vd=list((linux/'artifact').glob('verify*'));assert len(vd)==1; v=vd[0]; result=json.loads((v/'result.json').read_text()); commit=run['verified_commit']; project=root/item['project']
 assert commit==api['head_sha']==art['workflow_run']['head_sha']==result['repository_commit']==item['commit']
 assert run['run_id']==api['id']==art['workflow_run']['id']==item['run_id'] and api['conclusion']=='success' and api['status']=='completed'
 assert run['successful_attempt']==api['run_attempt'] and art['id']==run['artifact_id'] and art['name']=='lean-'+item['id'] and api['repository']['full_name']=='sidneyholden1/OpenProblemsInNLA'
 zp=linux/('lean-'+item['id']+'.zip'); digest=H(zp.read_bytes()); assert 'sha256:'+digest==art['digest']==run['github_artifact_digest'] and digest==run['artifact_sha256'] and zp.stat().st_size==art['size_in_bytes']
 members={}
 with zipfile.ZipFile(zp) as z:
  assert z.testzip() is None
  for n in z.namelist():
   if n.endswith('/'):continue
   data=z.read(n); assert data==(linux/'artifact'/n).read_bytes(); members[n]=H(data)
 assert set(members)=={str(p.relative_to(linux/'artifact')) for p in (linux/'artifact').rglob('*') if p.is_file()}
 def git(*args): return subprocess.check_output(['git','-C',str(root),*args])
 entries=[x.split(b'\t',1) for x in git('ls-tree','-rz',commit,'--',item['project']).split(b'\0') if x]
 proc=subprocess.Popen(['git','-C',str(root),'cat-file','--batch'],stdin=subprocess.PIPE,stdout=subprocess.PIPE)
 checked={}
 for meta,path in entries:
  mode,kind,oid=meta.decode().split();name=Path(path.decode()).relative_to(item['project']).as_posix();assert mode in ('100644','100755') and kind=='blob'
  proc.stdin.write(oid.encode()+b'\n');proc.stdin.flush(); header=proc.stdout.readline().split(); data=proc.stdout.read(int(header[2]));assert proc.stdout.read(1)==b'\n'; actual=H(data);assert actual==result['input_sha256'][name];assert H((project/name).read_bytes())==actual
  checked[name]={'sha256':actual,'git_blob':oid,'git_mode':mode,'matches_working_tree':True}
 proc.stdin.close();proc.wait();assert set(checked)==set(result['input_sha256']) and len(checked)==run['input_count']
 active={}
 for p in (linux/'active-source').rglob('*'):
  if p.is_file():
   n=str(p.relative_to(linux/'active-source'));assert H(p.read_bytes())==checked[n]['sha256']==run['active_source_sha256'][n];active[n]=H(p.read_bytes())
 assert set(active)==set(run['active_source_sha256'])
 closure=json.loads((audit/'referee-2-active-inputs.json').read_text())['files']
 for path,e in closure.items():assert checked[Path(path).relative_to(item['project']).as_posix()]['sha256']==e['sha256']
 cfg=json.loads((project/'comparator.json').read_text()); assert cfg==result['config'];assert set(cfg['permitted_axioms'])=={'propext','Quot.sound','Classical.choice'} and not cfg.get('definition_names')
 log=(v/'comparator.log').read_text(); exports=re.findall(r'^Exporting #\[(.*?)\] from (Challenge|Solution)$',log,re.M);assert len(exports)==2 and [x[1] for x in exports]==['Challenge','Solution']
 for names,module in exports:
  assert [n for n in names.split(', ') if n.startswith('NLA.')]==cfg['theorem_names']
 assert log.index('Building Challenge')<log.index('Building Solution')<log.index('Running Lean default kernel on solution.')<log.index('Lean default kernel accepts the solution')<log.index('Your solution is okay!')
 assert log.rstrip().endswith('EXIT_STATUS=0') and result['result']=='comparator-accepted'
 controls={}
 markers={
 'kernel-controls.log':['RETURN honest_with_inductives_and_quotients: accepted','RETURN invalid_raw_proof: rejected:','RETURN quotient_postcheck_mismatch: rejected: Quotient constant mismatch on: Quot.lift','PASS: all three actual Comparator.runBuiltinKernel cases behaved as required','EXIT_STATUS=0'],
 'comparator-controls.log':['PASS simple_match: exit 0, expected 0','PASS simple_mismatch: exit 1, expected 1','PASS simple_axiom_issue: exit 1, expected 1','PASS simple_kind_mismatch: exit 1, expected 1',"Challenge and solution theorem statement do not match: 'checked'",'PASS type_mismatch: exit 1, expected 1','PASS: all five Comparator regressions','EXIT_STATUS=0'],
 'negative-sorry.log':["Illegal axiom detected: 'sorryAx'",'EXIT_STATUS=1'],
 'negative-native.log':["Illegal axiom detected: 'checked._native.native_decide.ax_1_1'",'EXIT_STATUS=1'],
 'sandbox.log':['MODE build: exit=0','MODE export: exit=0','PASS build .lake write: allowed','PASS export .lake write-open: denied','PASS export .lake truncate: denied','NEGATIVE unknown option: exit=2','NEGATIVE unexpected --rw: exit=2','NEGATIVE unexpected --rwx: exit=2','NEGATIVE relative --rwx: exit=2','Outer and export fixture contents unchanged; only designated build fixture written.','EXIT_STATUS=0']}
 for f,ms in markers.items():
  text=(v/f).read_text();assert all(m in text for m in ms),(item['id'],f);controls[f]={'sha256':H(text.encode()),'required_markers':ms}
 sandbox=(v/'sandbox.log').read_text()
 for s in ['outside .lake write-open: denied','outside .lake truncate: denied','symlink from .lake to outside write: denied','outside .lake creation: denied','user namespace: private','pid namespace: private','mnt namespace: private','net namespace: private','ipc namespace: private','uts namespace: private','host parent: absent from private /proc','host loopback listener: unreachable','AF_UNIX socket creation: denied','effective capabilities: none','no_new_privs: set','nested namespace write attempt: rejected']:
  assert sandbox.count('PASS '+s)==2,(item['id'],s)
 harness={}
 for f in ['tools/lean/source-lock.json','tools/lean/harness.py','.github/workflows/lean-verification.yml']:
  data=git('show',commit+':'+f);assert data==(root/f).read_bytes();harness[f]=H(data)
 assert harness['tools/lean/source-lock.json']==result['source_lock_sha256']==result['tool_receipt']['source_lock_sha256']
 lock=json.loads((root/'tools/lean/source-lock.json').read_text());assert result['tool_receipt']['forsythe_commit']==lock['commit'];assert result['tool_receipt']['lean_toolchain']==lock['lean_toolchain']==(project/'lean-toolchain').read_text().strip()
 manifest=json.loads((project/'lake-manifest.json').read_text()); dep=(v/'dependencies.log').read_text(); dependency_checks={}
 for package in manifest['packages']:
  assert package['rev'] in dep,(item['id'],package['name']); dependency_checks[package['name']]=package['rev']
 assert dep.rstrip().endswith('EXIT_STATUS=0')
 jobs=json.loads((linux/'github-attempt-jobs.json').read_text())['jobs']
 verifyjobs=[j for j in jobs if j['name'].startswith('verify (')]
 assert len(verifyjobs)==1 and verifyjobs[0]['conclusion']=='success'
 assert verifyjobs[0]['head_sha']==commit and verifyjobs[0]['run_id']==api['id'] and verifyjobs[0]['run_attempt']==api['run_attempt']
 controljobs=[j for j in jobs if j['name']=='checker-controls'];assert len(controljobs)==1 and controljobs[0]['conclusion']=='skipped'
 artifacts=json.loads((linux/'github-all-run-artifacts.json').read_text())['artifacts'];matches=[x for x in artifacts if x['id']==art['id']];assert len(matches)==1 and matches[0]==art
 assert verifyjobs[0]['started_at']<=art['created_at']<=verifyjobs[0]['completed_at']
 evidence={'separate_checker_controls_job':'skipped; actual per-project controls independently inspected','attempt_verify_job_id':verifyjobs[0]['id'],'github_attempt_jobs_sha256':H((linux/'github-attempt-jobs.json').read_bytes()),'github_all_artifacts_sha256':H((linux/'github-all-run-artifacts.json').read_bytes()),'dependency_revisions_checked':dependency_checks,'verdict':'PASS','reviewer':'independent referee 2','run_id':api['id'],'attempt':api['run_attempt'],'verified_commit':commit,'artifact_id':art['id'],'artifact_sha256':digest,'receipt_dependency':'Coordinator-retrieved GitHub API receipts independently cross-checked; no fresh remote API query.','github_receipt_sha256':{f:H((linux/f).read_bytes()) for f in ['github-run.json','github-artifact.json','RUN.json']},'zip_members':members,'input_count':len(checked),'all_git_and_current_input_hashes':checked,'active_source_sha256':active,'active_proof_closure_matches_previous_review':True,'config':cfg,'all_exports_in_both_logs':True,'default_kernel_executed_and_accepted':True,'control_checks':controls,'two_sandbox_modes_checked':True,'harness_sha256':harness,'tool_receipt':result['tool_receipt'],'limitations':['No fresh remote API query or independent remote execution.','Checker binary hashes and bootstrap provenance are attested by the retained harness receipt; binaries are not retained for independent rehashing.','Operational evidence does not replace the separate statement and proof fidelity reviews.']}
 (audit/'referee-2-operational-checks.json').write_text(json.dumps(evidence,indent=2)+'\n')
 (audit/'referee2_operational.py').write_bytes(Path(__file__).read_bytes())
 print(item['id'],'PASS',len(checked),'inputs',len(members),'zip members',len(active),'active copies',len(cfg['theorem_names']),'exports')
