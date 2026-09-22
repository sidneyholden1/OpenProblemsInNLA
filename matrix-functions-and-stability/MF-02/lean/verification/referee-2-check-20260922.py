from pathlib import Path
import json,hashlib,re,subprocess,os
p=Path.cwd();sha=lambda f:hashlib.sha256(f.read_bytes()).hexdigest()
manifest=json.loads((p/'reviews/proof-source-hashes.json').read_text())
for f,h in manifest.items(): assert sha(p/f)==h, f
gate=json.loads((p/'reviews/statement-gate.json').read_text())
for f,h in gate['boundary_hashes'].items():
 q=p/'reviews/statement-review-snapshot'/f if f in ['README.md','formalization.yaml'] else p/f
 assert sha(q)==h,f
s=(p/'Challenge.lean').read_text().replace('import NLA.MF02.Definitions','import Solution\nimport LeanCert.Tactic.Verification').replace('namespace NLA.MF02','namespace MF02Referee2\nopen NLA.MF02').replace('end NLA.MF02','end MF02Referee2')
args=['δ hδ hδ1','m p hp','δ hδ hδ1 D hD p hp','δ hδ hδ1','cs','m δ hδ hδ1','δ hδ hδ1']
names=re.findall(r'^theorem (\w+)',s,re.M)
for n,a in zip(names,args): s=s.replace(':= by sorry',f':= by exact NLA.MF02.{n} {a}',1)
for n in names:s+=f'\n#check @NLA.MF02.{n}\n#print axioms NLA.MF02.{n}\n#assert_trust kernel NLA.MF02.{n}\n'
s+='\n#print NLA.MF02.degree_error_bound\n#print NLA.MF02.cubic_bounds_and_strict\n#print NLA.MF02.stage_bounds\n'
f=p/'verification/Referee2Consumer20260922.lean';f.write_text(s)
env=dict(os.environ);env['PATH']='/private/tmp/nla-20260922-runtime/lean-4.33.1-darwin_aarch64/bin:'+env['PATH']
log=p/'verification/referee-2-consumer-20260922.log'
with log.open('w') as out:r=subprocess.run(['lake','env','lean',str(f)],env=env,stdout=out,stderr=subprocess.STDOUT)
receipt={'verdict':'PASS' if r.returncode==0 else 'FAIL','consumer_exit_code':r.returncode,'command':['lake','env','lean',str(f)],'proof_source_hashes':manifest,'frozen_boundary_checked':True,'evidence_sha256':{str(f.relative_to(p)):sha(f),str(log.relative_to(p)):sha(log),'verification/referee-2-check-20260922.py':sha(p/'verification/referee-2-check-20260922.py')}}
(p/'reviews/referee-2-proof-evidence-20260922.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(r.returncode)
