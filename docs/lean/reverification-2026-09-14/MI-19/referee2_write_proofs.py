from pathlib import Path
import json,hashlib,re,subprocess,shutil
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
notes=json.loads(Path(__file__).with_name('referee2_proof_notes.json').read_text())
extra_deps={
'MI-19':['mathlib/Mathlib/LinearAlgebra/Matrix/PosDef.lean'],
'MI-21':['mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean','LeanCert/LeanCert/Validity/DyadicBounds.lean'],
'MI-29':['mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean','LeanCert/LeanCert/Validity/DyadicBounds.lean'],
'RA-03':['mathlib/Mathlib/Analysis/InnerProductSpace/Spectrum.lean','mathlib/Mathlib/Analysis/InnerProductSpace/SingularValues.lean'],
'RA-07':['mathlib/Mathlib/Analysis/Complex/Polynomial/GaussLucas.lean','mathlib/Mathlib/Algebra/Polynomial/Splits.lean']}

for e in json.load(open('/private/tmp/nla-fifth-five/projects.json')):
 r=Path(e['root']);p=r/e['project'];a=r/'docs/lean/reverification-2026-09-14'/e['id'];co=json.loads((a/'referee-2-consumer.json').read_text());assert co['exit_code']==0;assert H(a/'referee-2-consumer.log')==co['log_sha256'];assert H(a/'referee-2-consumer.lean')==co['script_sha256']
 gate=json.loads((a/'statement-gate.json').read_text())
 for f,h in gate['files_sha256'].items():assert H(r/f)==h
 active=json.loads((a/'referee-2-active-inputs.json').read_text())
 for f,v in active['files'].items():assert H(r/f)==v['sha256']
 modules={k:v for k,v in active['files'].items() if k.endswith('.lean') and not k.endswith('/Challenge.lean')}
 for f in modules:
  txt=(r/f).read_text();assert not re.search(r'\bsorry\b|\badmit\b|^axiom\s|native_decide|ofReduceBool',txt,re.M),f
 build=json.loads((a/'solution-local.json').read_text());assert build['exit_code']==0;assert H(a/'solution-local.log')==build['log_sha256']
 evidence=['statement-gate.json','referee-2-active-inputs.json','referee-2-consumer.lean','referee-2-consumer.log','referee-2-consumer.json','solution-local.json','solution-local.log','referee-2-numerical-checks.json','referee2_numerics.py','referee2_statements.py','referee2_consume.py']
 if e['id']!='RA-07':
  run=json.loads((a/'referee-2-numerical-terms.json').read_text());assert run['exit_code']==0;assert H(a/'referee-2-numerical-terms.log')==run['log_sha256'];evidence+=['referee-2-numerical-terms.lean','referee-2-numerical-terms.log','referee-2-numerical-terms.json','referee2_terms.py']
 if e['id']=='MF-16':
  run=json.loads((a/'referee-2-krawczyk-aux.json').read_text());assert run['exit_code']==0;assert H(a/'referee-2-krawczyk-aux.log')==run['log_sha256'];assert 'of_decide_eq_true (id (Eq.refl true))' in (a/'referee-2-krawczyk-aux.log').read_text();evidence+=['referee-2-krawczyk-aux.lean','referee-2-krawczyk-aux.log','referee-2-krawczyk-aux.json','referee-2-cayley-hamilton.py','referee-2-cayley-hamilton.json']
 if e['id']=='MI-21':evidence+=['referee-2-riccati-rescaling.py','referee-2-riccati-rescaling.json']
 deps={f:H(p/'.lake/packages'/f) for f in extra_deps[e['id']]}
 checks={'verdict':'PASS','phase':'independent proof source and local export consumer','reviewer':'/root/iv06_statement_referee_2','candidate_commit':e['commit'],'source_base':e['base'],'observed_current_main_not_source':e['upstream_current_main_observed'],'active_source_count':len(modules),'export_count':len(co['exports']),'export_axioms':co['exports'],'consumer_exit_code':co['exit_code'],'consumer_command':co['command'],'consumer_cwd':co['cwd'],'coordinator_solution_build_exit_code':0,'unchanged_frozen_statement_gate':True,'active_sources_equal_candidate_and_preserved_base':True,'targeted_imported_semantics_sha256':deps,'evidence_sha256':{f:H(a/f) for f in evidence},'linux_status':'separate pending operational review, not inferred from historical PASS'}
 shutil.copy2(Path(__file__).with_name('referee2_proof_notes.json'),a/'referee2_proof_notes.json')
 (a/'referee-2-proof-checks.json').write_text(json.dumps(checks,indent=2)+'\n')
 report=f'''# {e['id']} — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `{e['base']}`, not newly authored work or the observed older main `{e['upstream_current_main_observed']}`. Candidate `{e['commit']}` preserves the reviewed mathematical bytes. Mathematical credit remains {'George Stepaniants; Ferber–Jain–Zhao retain their conjecture/prior-bound credit' if e['id']=='FR-12' else 'Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source'}. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

{notes[e['id']]}

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper ({len(modules)} Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all {len(co['exports'])} exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

'''+''.join(f'- `{n}` — type queried; standard-three axioms; kernel trust PASS.\n' for n in co['exports'])+'''
## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
'''+''.join(f"| `{f}` | `{v['sha256']}` |\n" for f,v in modules.items())+f"\nMachine proof-checks SHA-256: `{H(a/'referee-2-proof-checks.json')}`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.\n"
 (a/'PROOF-REFEREE-2.md').write_text(report);shutil.copy2(__file__,a/'referee2_write_proofs.py');print(e['id'],'proof PASS',len(co['exports']),flush=True)
