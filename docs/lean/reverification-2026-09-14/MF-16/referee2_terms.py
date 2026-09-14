from pathlib import Path
import json,hashlib,re,subprocess,os,sys
H=lambda b:hashlib.sha256(b).hexdigest()
for e in json.load(open('/private/tmp/nla-fourth-five/projects.json')):
 if e['id']=='FR-12':continue
 r=Path(e['root']);p=r/e['project'];a=r/'docs/lean/reverification-2026-09-14'/e['id'];q=a/'referee-2-consumer.json'
 if not q.exists():continue
 out=a/'referee-2-numerical-terms.json'
 if out.exists():continue
 log=(a/'referee-2-consumer.log').read_text();names=sorted(set(re.findall(r'NLA\.[A-Za-z0-9_.]+\._proof_[A-Za-z0-9_]+',log)))
 if e['id']=='MF-16':names=['NLA.MF16.actual_krawczyk_checked','NLA.MF16.certified_root_proved']
 script=a/'referee-2-numerical-terms.lean';script.write_text('import Solution\nimport LeanCert.Tactic.Verification\nset_option pp.proofs true\n'+''.join(f'#print {n}\n#print axioms {n}\n#assert_trust kernel {n}\n' for n in names));env=os.environ.copy();env['PATH']='/private/tmp/nla-lean-runtime/lean-4.33.1-darwin_aarch64/bin:'+env['PATH'];cmd=['lake','env','lean',str(script)]
 with (a/'referee-2-numerical-terms.log').open('wb') as f:run=subprocess.run(cmd,cwd=p,env=env,stdout=f,stderr=subprocess.STDOUT)
 assert run.returncode==0,(e['id'],'term probe failed');data=(a/'referee-2-numerical-terms.log').read_bytes();out.write_text(json.dumps({'verdict':'PASS','names':names,'exit_code':run.returncode,'command':cmd,'cwd':str(p),'script_sha256':H(script.read_bytes()),'log_sha256':H(data)},indent=2)+'\n');(a/'referee2_terms.py').write_bytes(Path(__file__).read_bytes());print(e['id'],'terms PASS',len(names),flush=True)
