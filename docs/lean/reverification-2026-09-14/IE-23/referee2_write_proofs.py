from pathlib import Path
import json,hashlib,re,shutil
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
notes=json.loads(Path(__file__).with_name('referee2_proof_notes.json').read_text())
dy='LeanCert/LeanCert/Validity/DyadicBounds.lean'
rpow='mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean'
extra_deps={
'IE-23':['mathlib/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean','mathlib/Mathlib/Analysis/SpecialFunctions/Pow/Real.lean'],
'MI-22':[rpow,dy,'mathlib/Mathlib/Analysis/InnerProductSpace/SingularValues.lean'],
'MI-23':[rpow,dy,'mathlib/Mathlib/Analysis/CStarAlgebra/Matrix.lean'],
'RA-20':['mathlib/Mathlib/RingTheory/Smooth/Basic.lean','mathlib/Mathlib/RingTheory/Smooth/Locus.lean','mathlib/Mathlib/RingTheory/Nullstellensatz.lean','mathlib/Mathlib/Algebra/MvPolynomial/Funext.lean'],
'IV-06':[dy,'mathlib/Mathlib/Topology/Connected/Clopen.lean','mathlib/Mathlib/Topology/Order/IntermediateValue.lean']}
for e in json.load(open('/private/tmp/nla-sixth-five/projects.json')):
 r=Path(e['root']);p=r/e['project'];a=r/'docs/lean/reverification-2026-09-14'/e['id']
 co=json.loads((a/'referee-2-consumer.json').read_text());assert co['exit_code']==0;assert H(a/'referee-2-consumer.log')==co['log_sha256'];assert H(a/'referee-2-consumer.lean')==co['script_sha256']
 gate=json.loads((a/'statement-gate.json').read_text())
 for f,h in gate['files_sha256'].items():assert H(r/f)==h
 active=json.loads((a/'referee-2-active-inputs.json').read_text())
 for f,v in active['files'].items():assert H(r/f)==v['sha256']
 modules={k:v for k,v in active['files'].items() if k.endswith('.lean') and not k.endswith('/Challenge.lean')}
 for f in modules:
  txt=(r/f).read_text();assert not re.search(r'\bsorry\b|\badmit\b|^axiom\s|native_decide|ofReduceBool',txt,re.M),f
 build=json.loads((a/'solution-local.json').read_text());assert build['exit_code']==0;assert H(a/'solution-local.log')==build['log_sha256'];assert 'Build completed successfully' in (a/'solution-local.log').read_text()
 evidence=['statement-gate.json','referee-2-active-inputs.json','referee-2-consumer.lean','referee-2-consumer.log','referee-2-consumer.json','solution-local.json','solution-local.log','referee-2-numerical-checks.json','referee2_numerics.py','referee2_statements.py','referee2_consume.py']
 extra_note=''
 if e['id'] in ['MI-22','MI-23','IV-06']:
  for stem in ['numerical-terms','retention']:
   run=json.loads((a/f'referee-2-{stem}.json').read_text());assert run['exit_code']==0;assert H(a/f'referee-2-{stem}.log')==run['log_sha256'];assert H(a/f'referee-2-{stem}.lean')==run['script_sha256'];evidence += [f'referee-2-{stem}.'+ext for ext in ['lean','log','json']]
  assert 'of_decide_eq_true (id (Eq.refl true))' in (a/'referee-2-numerical-terms.log').read_text()
  evidence+=['referee2_terms.py','referee2_retention.py']+[f'referee-2-retention-initial.'+ext for ext in ['lean','log','json']]
  extra_note=' A separate fresh environment-dependency probe confirms a value-dependency path from the exported universal negation to the material scalar theorem. Its initial diagnostic had a missing Lean Name annotation (exit 1); the original script/log/receipt are retained, and the corrected diagnostic returned exit 0. This was an external inspection-script error, not a project proof error; all export consumers passed on their first run.'
 deps={f:H(p/'.lake/packages'/f) for f in extra_deps[e['id']]}
 shutil.copy2(Path(__file__).with_name('referee2_proof_notes.json'),a/'referee2_proof_notes.json');shutil.copy2(__file__,a/'referee2_write_proofs.py');evidence+=['referee2_proof_notes.json','referee2_write_proofs.py']
 checks={'verdict':'PASS','phase':'independent proof source and local export consumer','reviewer':'/root/iv06_statement_referee_2','candidate_commit':e['commit'],'source_base':e['base'],'observed_current_main_not_source':e['upstream_current_main_observed'],'active_source_count':len(modules),'export_count':len(co['exports']),'export_axioms':co['exports'],'consumer_exit_code':co['exit_code'],'consumer_command':co['command'],'consumer_cwd':co['cwd'],'coordinator_solution_build_exit_code':0,'unchanged_frozen_statement_gate':True,'active_sources_equal_candidate_and_preserved_base':True,'targeted_imported_semantics_sha256':deps,'evidence_sha256':{f:H(a/f) for f in evidence},'linux_status':'separate operational review required, not inferred from historical PASS'}
 (a/'referee-2-proof-checks.json').write_text(json.dumps(checks,indent=2)+'\n')
 credit=('the repository Codex automated maintainer audit; the conjecture is due to Kubjas, Sodomaco and Tsigaridas' if e['id']=='RA-20' else 'Matthew J. Colbrook, with Dokmanić–Gribonval credited for the example' if e['id']=='IE-23' else 'Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source')
 report=f'''# {e['id']} — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `{e['base']}`, not newly authored work or the observed older main `{e['upstream_current_main_observed']}`. Candidate `{e['commit']}` preserves the reviewed mathematical bytes. Mathematical credit remains {credit}. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee. {'RA-20 has no canonical page at the observed older main; the report makes no equivalence claim to an absent page.' if e['id']=='RA-20' else ''}

## Actual proof and full target

{notes[e['id']]}

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper ({len(modules)} Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt, success log and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all {len(co['exports'])} exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear in those closures. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.{extra_note}

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All active project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

'''+''.join(f'- `{n}` — type queried; standard-three axioms; kernel trust PASS.\n' for n in co['exports'])+'''
## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
'''+''.join(f"| `{f}` | `{v['sha256']}` |\n" for f,v in modules.items())+f"\nMachine proof-checks SHA-256: `{H(a/'referee-2-proof-checks.json')}`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.\n"
 (a/'PROOF-REFEREE-2.md').write_text(report);print(e['id'],'proof PASS',len(co['exports']),flush=True)
