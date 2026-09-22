from pathlib import Path
import json,hashlib,subprocess,os,sys,re,shutil
H=lambda b:hashlib.sha256(b).hexdigest()
terms={'FR-12':[],'MF-16':['actual_krawczyk_checked','preconditioner_det_exact','box_radius_exact','contraction_bound_small','certified_root_proved'],'TR-15':['negative_eigenvalue_certificate','upper_negative_eigenpair_proved'],'IE-18':['strict_scalar_gap','strict_amplification_gap'],'IE-19':['strict_scalar_gap','counterexample_proved']}
for e in json.load(open('/private/tmp/nla-fourth-five/projects.json')):
 if len(sys.argv)>1 and e['id'] not in sys.argv[1:]:continue
 r=Path(e['root']);p=r/e['project'];a=r/'docs/lean/reverification-2026-09-14'/e['id'];receipt=a/'solution-local.json'
 if not receipt.exists(): print(e['id'],'pending build');continue
 b=json.loads(receipt.read_text());assert b['exit_code']==0
 assert H((a/'solution-local.log').read_bytes())==b['log_sha256']
 out=a/'referee-2-consumer.json'
 if out.exists():print(e['id'],'already consumed');continue
 gate=json.loads((a/'statement-gate.json').read_text())
 for f,h in gate['files_sha256'].items():assert H((r/f).read_bytes())==h,(f,'gate mismatch')
 inputs={}
 for f in [p/'Solution.lean']+sorted((p/'NLA').rglob('*.lean'))+[p/'Challenge.lean',p/'comparator.json',p/'lake-manifest.json',p/'lakefile.toml',p/'lean-toolchain']:
  data=f.read_bytes();rel=str(f.relative_to(r));assert data==subprocess.check_output(['git','-C',str(r),'show',e['commit']+':'+rel]);assert data==subprocess.check_output(['git','-C',str(r),'show',e['base']+':'+rel]);inputs[rel]={'sha256':H(data),'bytes':len(data)}
 (a/'referee-2-active-inputs.json').write_text(json.dumps({'verdict':'PASS','candidate_commit':e['commit'],'source_base':e['base'],'files':inputs},indent=2)+'\n')
 names=json.loads((p/'comparator.json').read_text())['theorem_names'];ns='NLA.'+e['id'].replace('-','')+'.'
 source='import Solution\nimport LeanCert.Tactic.Verification\nset_option pp.universes true\nset_option pp.proofs true\n'
 for n in names:source+=f'#check @{n}\n#print axioms {n}\n#assert_trust kernel {n}\n'
 for n in terms[e['id']]:source+=f'#print {ns+n}\n#print axioms {ns+n}\n#assert_trust kernel {ns+n}\n'
 script=a/'referee-2-consumer.lean';script.write_text(source);env=os.environ.copy();env['PATH']='/private/tmp/nla-lean-runtime/lean-4.33.1-darwin_aarch64/bin:'+env['PATH'];cmd=['lake','env','lean',str(script)]
 with (a/'referee-2-consumer.log').open('wb') as log:proc=subprocess.run(cmd,cwd=p,env=env,stdout=log,stderr=subprocess.STDOUT)
 data=(a/'referee-2-consumer.log').read_bytes();assert proc.returncode==0,(e['id'],'consumer fail')
 s=data.decode();audit={}
 for n in names:
  mt=re.search("'"+re.escape(n)+r"' depends on axioms: \[([^\]]*)\]",s);assert mt,(e['id'],n);axioms=[re.sub(r'\.\{[^}]*\}','',v.strip()) for v in mt[1].split(',')];assert set(axioms)=={'propext','Classical.choice','Quot.sound'},(n,axioms);audit[n]=axioms
 evidence={'verdict':'PASS','command':cmd,'cwd':str(p),'runtime_path_prefix':env['PATH'].split(':')[0],'exit_code':proc.returncode,'exports':audit,'material_term_names':terms[e['id']],'script_sha256':H(script.read_bytes()),'log_sha256':H(data)};out.write_text(json.dumps(evidence,indent=2)+'\n')
 for name in ['referee2_numerics.py','referee2_statements.py','referee2_consume.py']:shutil.copy2('/private/tmp/nla-fourth-five/'+name,a/name)
 print(e['id'],'consumer PASS',len(names),flush=True)
