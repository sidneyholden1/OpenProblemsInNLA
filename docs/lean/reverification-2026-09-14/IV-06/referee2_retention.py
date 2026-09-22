from pathlib import Path
import json,hashlib,subprocess,os
H=lambda b:hashlib.sha256(b).hexdigest()
terms={'MI-22':('not_weightedLogMajorizationConjecture','numerical_separation'),'MI-23':('not_generalizedGeometricMeanConjecture','scalar_gap_positive'),'IV-06':('not_componentBoundConjecture','numerical_separator_margin')}
header='''import Solution
import Lean
open Lean Elab Command
private def retentionPath (env : Environment) (target : Name) : Nat → List (Name × List Name) → NameSet → Option (List Name)
  | 0, _, _ => none
  | _, [], _ => none
  | k+1, (n,path)::rest, seen =>
    if n == target then some (path.reverse)
    else if seen.contains n then retentionPath env target k rest seen
    else
      let children : List Name := match env.find? n with
        | none => []
        | some ci => match ci.value? (allowOpaque := true) with
          | none => []
          | some v => v.getUsedConstants.toList.filter (fun (d : Name) => "NLA.".isPrefixOf d.toString)
      retentionPath env target k (rest ++ children.map (fun d => (d,d::path))) (seen.insert n)
'''
for e in json.load(open('/private/tmp/nla-sixth-five/projects.json')):
 if e['id'] not in terms:continue
 r=Path(e['root']);p=r/e['project'];a=r/'docs/lean/reverification-2026-09-14'/e['id'];ns='NLA.'+e['id'].replace('-','')+'.';root,term=[ns+x for x in terms[e['id']]]
 s=a/'referee-2-retention.lean';s.write_text(header+f'''run_cmd do
  let env ← getEnv
  match retentionPath env `{term} 10000 [(`{root}, [`{root}])] {{}} with
  | none => throwError "No retained material scalar path"
  | some path => logInfo m!"Material scalar retained: {{path}}"
''')
 env=os.environ.copy();env['PATH']='/private/tmp/nla-lean-runtime/lean-4.33.1-darwin_aarch64/bin:'+env['PATH'];cmd=['lake','env','lean',str(s)]
 with (a/'referee-2-retention.log').open('wb') as f:run=subprocess.run(cmd,cwd=p,env=env,stdout=f,stderr=subprocess.STDOUT)
 out={'verdict':'PASS' if run.returncode==0 else 'FAIL','exit_code':run.returncode,'command':cmd,'cwd':str(p),'root':root,'material_scalar':term,'script_sha256':H(s.read_bytes()),'log_sha256':H((a/'referee-2-retention.log').read_bytes())};(a/'referee-2-retention.json').write_text(json.dumps(out,indent=2)+'\n');(a/'referee2_retention.py').write_bytes(Path(__file__).read_bytes());print(e['id'],run.returncode,flush=True)
