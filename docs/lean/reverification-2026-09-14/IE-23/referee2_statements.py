from pathlib import Path
import json,hashlib,subprocess,re,shutil
H=lambda b:hashlib.sha256(b).hexdigest()
notes=json.loads(Path(__file__).with_name('referee2_statement_notes.json').read_text())
libs={
'IE-23':['LinearAlgebra/Matrix/Rank.lean','LinearAlgebra/Matrix/NonsingularInverse.lean','Analysis/InnerProductSpace/PiL2.lean','Analysis/SpecialFunctions/Pow/Real.lean'],
'MI-22':['Analysis/InnerProductSpace/SingularValues.lean','Analysis/CStarAlgebra/Matrix.lean','LinearAlgebra/Matrix/PosDef.lean','Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean'],
'MI-23':['Analysis/InnerProductSpace/SingularValues.lean','Analysis/CStarAlgebra/Matrix.lean','LinearAlgebra/Matrix/PosDef.lean','Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean'],
'RA-20':['RingTheory/Nullstellensatz.lean','RingTheory/Smooth/Locus.lean','Analysis/Calculus/FDeriv/Defs.lean','LinearAlgebra/Matrix/Rank.lean'],
'IV-06':['Topology/Connected/Clopen.lean','Topology/Order/IntermediateValue.lean','LinearAlgebra/Matrix/ToLinearEquiv.lean','SetTheory/Cardinal/Order.lean']}

for e in json.load(open('/private/tmp/nla-sixth-five/projects.json')):
 root=Path(e['root']);rel=Path(e['project']);p=root/rel;a=root/'docs/lean/reverification-2026-09-14'/e['id'];names=['README.md','NUMERICAL_TARGETS.md','Challenge.lean','comparator.json','formalization.yaml','lean-toolchain','lake-manifest.json','lakefile.toml'];sources=[str(rel.parent/'README.md'),'docs/lean/REVIEW.md']+[str(rel/n) for n in names]+[str(rel/'NLA'/e['id'].replace('-','')/'Definitions.lean')]
 if e['id'] in ['MI-22','MI-23','RA-20']:sources += [str(rel.parent/n) for n in ['solution.md','solution.tex']]
 else:sources += ['references/colbrook-recovered-2026-09-11/manuscripts/IE-23.tex' if e['id']=='IE-23' else 'references/colbrook-intervals-2026-09-11/manuscripts/IV-06.tex']
 for name in ['SOURCE_CORRESPONDENCE.md','SourceCorrespondence.md']:
  if (p/name).exists():sources.append(str(rel/name))

 hashes={}
 for f in sources:
  data=subprocess.check_output(['git','-C',str(root),'show',e['base']+':'+f]);q=root/f
  if q.exists():assert q.read_bytes()==data,(e['id'],f)
  hashes[f]={'sha256':H(data),'bytes':len(data),'read_method':'local source and immutable Git comparison' if q.exists() else 'git show immutable preserved source'}
 cfg=json.loads((p/'comparator.json').read_text());decls=re.findall(r'^theorem\s+(\w+)',(p/'Challenge.lean').read_text(),re.M);assert cfg['theorem_names']==['NLA.'+e['id'].replace('-','')+'.'+n for n in decls];assert cfg['definition_names']==[] and set(cfg['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
 build=json.loads((a/'challenge-local.json').read_text());log=(a/'challenge-local.log').read_bytes();assert build['exit_code']==0 and H(log)==build['log_sha256'];assert log.decode().count('declaration uses `sorry`')==len(decls) and 'Build completed successfully' in log.decode()
 shutil.copy2(Path(__file__).with_name('referee2_statement_notes.json'),a/'referee2_statement_notes.json')
 deps={f:H((p/'.lake/packages/mathlib/Mathlib'/f).read_bytes()) for f in libs[e['id']]};num=json.loads((a/'referee-2-numerical-checks.json').read_text());assert num['verdict']=='PASS'
 evidence={'verdict':'PASS','phase':'statement only before proof inspection','reviewer':'/root/iv06_statement_referee_2 (independent AI agent)','preserved_source_base':e['base'],'observed_upstream_main_not_source_base':e['upstream_current_main_observed'],'source_hashes':hashes,'actual_imported_semantics_sha256':deps,'exports':cfg['theorem_names'],'numerical_diagnostics':num,'numerical_evidence_sha256':H((a/'referee-2-numerical-checks.json').read_bytes()),'numerical_log_sha256':H((a/'referee-2-numerical.log').read_bytes()),'numerical_generator_sha256':H((a/'referee2_numerics.py').read_bytes()),'coordinator_challenge_build':build,'coordinator_receipt_sha256':H((a/'challenge-local.json').read_bytes()),'no_active_proof_or_solution_inspected':True,'historical_metadata_claims_not_reaudited':True}
 (a/'referee-2-statement-checks.json').write_text(json.dumps(evidence,indent=2)+'\n')
 report=f'''# {e['id']} — independent statement referee 2

**PASS — approved exact statement boundary.** No blocking mathematical fidelity, vacuity or numerical-data finding. Proof and actual isolated Linux Comparator remain separate future gates.

Independent AI reviewer `/root/iv06_statement_referee_2`, 2026-09-14. This applies `docs/lean/REVIEW.md` across full-target fidelity, mathematical meaning, degeneracies, numerical obligations, computation reduction, API reuse and attribution. It is the local Tau Ceti adaptation, not official Tau Ceti endorsement or external human peer review. I read the complete canonical page and complete informal source, actual Definitions and Challenge, numerical target plan, and the relevant scope/attribution/automation material in the project guide and manifest. No active Proof/Solution body or historical proof verdict was used as evidence for approval.

The authored source is preserved commit `{e['base']}`, deliberately not the observed older main `{e['upstream_current_main_observed']}`. This is reverification of existing George Stepaniants formalization, with original mathematical proof/counterexample credit retained for {'the Codex automated maintainer audit; Kubjas, Sodomaco and Tsigaridas retain the conjecture credit' if e['id']=='RA-20' else 'Matthew J. Colbrook and the original problem authors retained in the sources'}. No authorship, license or permanent problem ID was changed. {'RA-20 has no canonical page at the older observed main; no equality to a nonexistent older target is claimed.' if e['id']=='RA-20' else ''} Historical statement-stage notices and old published PASS claims remain historical, not evidence of a new proof or Linux run. Metadata's old verification claims were not reaudited at this phase.

## Full original target and obligations

{notes[e['id']]}

## Evidence and remaining gate

The independent exact Python reconstruction is retained as `referee2_numerics.py` with `referee-2-numerical-checks.json`; it uses rational/integer arithmetic and explicitly labels its diagnostic scope. It neither imports an author-supplied PASS nor proves the final universal theorem. Existing earlier reviewed CFC/matrix and finite-enumeration projects provide useful proof-organization examples; no mathematical theorem from those examples is introduced as an assumption. Targeted actual library semantics are hash-bound in the machine report. Full active-proof and transitive trust inspection must follow both statement approvals.

The coordinator's fresh pinned `lake build Challenge` returned exit 0 with exactly {len(decls)} deliberate placeholder warnings. I checked the matching receipt/log SHA-256 and complete export inventory; this build was the coordinator's, not my own, and establishes no proof. All {len(decls)} Challenge declarations match comparator.json, with no definition-name exceptions and only the standard three permitted final axioms. The zero proof-hole count in historical metadata excludes the isolated Challenge placeholders. Later proof review must check every actual export type/axiom closure and material LeanCert route; actual Linux Comparator must separately check statement identity, default kernel and rejection controls.

## Exact source binding

| Source | SHA-256 |
| --- | --- |
'''+''.join(f"| `{f}` | `{h['sha256']}` |\n" for f,h in hashes.items())+f"\nMachine statement-checks SHA-256: `{H((a/'referee-2-statement-checks.json').read_bytes())}`. It also binds the numerical generator/data, coordinator build and inspected library definitions. Approval applies only to these exact bytes.\n"
 (a/'STATEMENT-REFEREE-2.md').write_text(report);shutil.copy2(__file__,a/'referee2_statements.py');print(e['id'],'statement PASS',len(decls),flush=True)
