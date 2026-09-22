#!/usr/bin/env python3
import os, argparse, collections, concurrent.futures, datetime, hashlib, io, json, pathlib, re, subprocess, zipfile
ROOT=pathlib.Path('/private/tmp/nla-20260922/sp05-linux'); REPO=pathlib.Path('/private/tmp/nla-20260922-sp05'); GH='/Users/sholden/.local/bin/gh'; REMOTE='sidneyholden1/OpenProblemsInNLA'; RUN=35693379965
sha=lambda b:hashlib.sha256(b).hexdigest()
def gh(*a):return subprocess.check_output([GH,*a])
def savejson(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def api(p):return json.loads(gh('api',p))
def git(*a):return subprocess.check_output(['git','-c','url.https://github.com/.insteadOf=git@github.com:','-c','credential.helper=!/Users/sholden/.local/bin/gh auth git-credential',*a],cwd=REPO,env={**os.environ,'GIT_CONFIG_GLOBAL':'/dev/null'})
def status():
 v=json.loads(gh('run','view',str(RUN),'--repo',REMOTE,'--json','status,conclusion,headSha,url,jobs'))
 stamp=datetime.datetime.now(datetime.timezone.utc).strftime('%Y%m%dT%H%M%SZ');savejson(ROOT/f'status-{stamp}.json',v);savejson(ROOT/'latest-status.json',v)
 print(json.dumps({'status':v['status'],'conclusion':v['conclusion'],'headSha':v['headSha'],'jobs':dict(collections.Counter(j['conclusion'] or j['status'] for j in v['jobs'])),'failed':[j for j in v['jobs'] if j['conclusion'] in ['failure','cancelled','timed_out']]}))
 return v

def collect():
 v=json.loads((ROOT/'latest-status.json').read_text());assert v['status']=='completed' and v['conclusion']=='success', 'Run not completed successfully; do not collect as PASS'
 run=api(f'repos/{REMOTE}/actions/runs/{RUN}');savejson(ROOT/'github-run.json',run)
 arts=api(f'repos/{REMOTE}/actions/runs/{RUN}/artifacts?per_page=100');savejson(ROOT/'github-artifacts.json',arts)
 def one(a):
  dest=ROOT/a['name'];dest.mkdir(exist_ok=True);savejson(dest/'github-artifact.json',a)
  z=dest/(a['name']+'.zip')
  if not z.exists():z.write_bytes(gh('api',f"repos/{REMOTE}/actions/artifacts/{a['id']}/zip"))
  digest=sha(z.read_bytes());assert a.get('digest')=='sha256:'+digest,(a['name'],'digest')
  with zipfile.ZipFile(z) as zz:
   assert zz.testzip() is None
   for name in zz.namelist():assert not pathlib.PurePosixPath(name).is_absolute() and '..' not in pathlib.PurePosixPath(name).parts
   zz.extractall(dest/'artifact')
  return {'artifact':a['name'],'artifact_id':a['id'],'sha256':digest,'bytes':z.stat().st_size}
 with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool: receipts=list(pool.map(one,arts['artifacts']))
 savejson(ROOT/'downloads.json',receipts); print('Downloaded/digest-checked',len(receipts),'original ZIPs')

def audit():
 receipts=json.loads((ROOT/'downloads.json').read_text()); run=json.loads((ROOT/'github-run.json').read_text()); assert run['conclusion']=='success'; results=[]; cache={}
 blobproc=subprocess.Popen(['git','cat-file','--batch'],cwd=REPO,stdin=subprocess.PIPE,stdout=subprocess.PIPE)
 def blobhash(obj):
  blobproc.stdin.write((obj+'\n').encode());blobproc.stdin.flush();header=blobproc.stdout.readline().decode().split();assert header[1]=='blob';size=int(header[2]);data=blobproc.stdout.read(size);assert len(data)==size and blobproc.stdout.read(1)==b'\n';return sha(data)
 for rec in receipts:
  d=ROOT/rec['artifact']; found=list((d/'artifact').rglob('result.json'));assert len(found)==1,(rec['artifact'],len(found));f=found[0];v=json.loads(f.read_text());assert v['result']=='comparator-accepted'; commit=v['repository_commit'];project=v['project']; logdir=f.parent
  try:git('cat-file','-e',commit+'^{commit}')
  except subprocess.CalledProcessError:git('fetch','origin',commit)
  assert git('rev-parse',commit+':'+project)==git('rev-parse',run['head_sha']+':'+project),(project,'tested tree differs from event head')
  tree={}
  for line in git('ls-tree','-r','-z',commit,'--',project).split(b'\0'):
   if line:
    meta,path=line.split(b'\t',1);mode,kind,obj=meta.decode().split();assert mode in ['100644','100755'] and kind=='blob';rel=str(pathlib.PurePosixPath(path.decode()).relative_to(project));tree[rel]=obj
  assert tree.keys()==v['input_sha256'].keys(),(project,'file-set mismatch')
  for path,obj in tree.items():
   if obj not in cache:cache[obj]=blobhash(obj)
   assert cache[obj]==v['input_sha256'][path],(project,path)
  lock=git('show',commit+':tools/lean/source-lock.json');assert sha(lock)==v['source_lock_sha256']==v['tool_receipt']['source_lock_sha256'];assert 'x86_64-unknown-linux-gnu' in v['tool_receipt']['lean_version'];assert '4.33.1' in v['tool_receipt']['lean_version']
  config=json.loads(git('show',commit+':'+project+'/comparator.json'));assert config==v['config'];assert not config.get('definition_names');assert set(config['permitted_axioms'])<= {'propext','Classical.choice','Quot.sound'}
  logs={p.name:p.read_text() for p in logdir.glob('*.log')}
  checks={'comparator.log':['Building Challenge','Building Solution','Exporting #[','from Solution','Lean default kernel accepts the solution','Your solution is okay!','EXIT_STATUS=0'], 'kernel-controls.log':['RETURN honest_with_inductives_and_quotients: accepted','RETURN invalid_raw_proof: rejected','Quotient post-check rejects the solution','RETURN quotient_postcheck_mismatch: rejected','PASS: all three actual Comparator.runBuiltinKernel cases behaved as required','EXIT_STATUS=0'],'comparator-controls.log':['PASS simple_match:','PASS simple_mismatch:','PASS simple_axiom_issue:','PASS simple_kind_mismatch:','PASS type_mismatch:','PASS: all five Comparator regressions','EXIT_STATUS=0'],'negative-sorry.log':["Illegal axiom detected: 'sorryAx'",'EXIT_STATUS=1'],'negative-native.log':["Illegal axiom detected: 'checked._native.native_decide.ax_1_1'",'EXIT_STATUS=1'],'sandbox.log':['MODE build: exit=0','MODE export: exit=0','PASS build .lake write: allowed','PASS export .lake write-open: denied','PASS export .lake truncate: denied','NEGATIVE unknown option: exit=2','NEGATIVE unexpected --rw: exit=2','NEGATIVE unexpected --rwx: exit=2','NEGATIVE relative --rwx: exit=2','Outer and export fixture contents unchanged; only designated build fixture written.','EXIT_STATUS=0'],'user-service.log':['EXIT_STATUS=0'],'dependencies.log':['EXIT_STATUS=0'],'mathlib-cache.log':['EXIT_STATUS=0']}
  for file,markers in checks.items():
   assert file in logs,(project,file)
   for m in markers:assert m in logs[file],(project,file,m)
  for m in ['PASS outside .lake write-open: denied','PASS outside .lake truncate: denied','PASS symlink from .lake to outside write: denied','PASS outside .lake creation: denied','PASS user namespace: private','PASS pid namespace: private','PASS mnt namespace: private','PASS net namespace: private','PASS ipc namespace: private','PASS uts namespace: private','PASS host parent: absent from private /proc','PASS host parent signal lookup: denied','PASS host loopback listener: unreachable','PASS AF_UNIX socket creation: denied','PASS effective capabilities: none','PASS no_new_privs: set','PASS nested namespace write attempt: rejected']:
   assert logs['sandbox.log'].count(m)==2,(project,m)
  assert re.search(r'Sandbox UID: [1-9][0-9]*',logs['sandbox.log'])
  export_lines=[s for s in logs['comparator.log'].splitlines() if s.startswith('Exporting #[') and s.endswith(' from Solution')]; assert len(export_lines)==1
  for n in config['theorem_names']:assert n in export_lines[0],(project,n)
  results.append({'verdict':'PASS','project':project,'repository_commit':commit,'head_sha':run['head_sha'],'input_count':len(tree),'export_count':len(config['theorem_names']),'theorems':config['theorem_names'],'artifact':rec,'result_sha256':sha(f.read_bytes()),'log_sha256':{name:sha((logdir/name).read_bytes()) for name in checks},'source_identity':'every tracked input hash independently matched exact Git blob at repository_commit','default_kernel':True,'all_rejection_controls':True,'all_isolation_controls':True})
  print(project,'PASS',len(tree),'inputs',len(config['theorem_names']),'exports',flush=True)
 blobproc.stdin.close();blobproc.wait();assert blobproc.returncode==0
 assert len(results)==1,len(results)
 expected={'eigenvalues-and-inverse-problems/SP-05/lean'}
 assert {x['project'] for x in results}==expected, 'Project selection mismatch'
 savejson(ROOT/'AUDIT-RESULTS.json',{'verdict':'PASS','run_id':RUN,'run_url':run['html_url'],'head_sha':run['head_sha'],'projects':results,'total_exports':sum(x['export_count'] for x in results),'total_inputs':sum(x['input_count'] for x in results),'unique_git_blobs_hashed':len(cache),'limits':'Independent operational evidence audit by coordinator /root, a nonauthor of SP05 proofs; separate from the two source reviews. Tested repository_commit may be the pull-request merge commit rather than event head SHA; both retained.'})
 print('ALL PASS')
if __name__=='__main__':
 import sys
 {'status':status,'collect':collect,'audit':audit}[sys.argv[1]]()
