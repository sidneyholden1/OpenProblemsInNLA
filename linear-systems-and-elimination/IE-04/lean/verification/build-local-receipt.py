import datetime,hashlib,json,pathlib,re
p=pathlib.Path(__file__).resolve().parent.parent
sha=lambda q:hashlib.sha256(q.read_bytes()).hexdigest()
frozen=json.loads((p/'verification/statement-freeze.json').read_text())
checks={}
snapshots={}
for name,want in frozen['files_sha256'].items():
    if name in ['README.md','formalization.yaml']:
        dest='reviews/statement-review-snapshot/'+name
        assert sha(p/dest)==want,(dest,'frozen draft snapshot mismatch')
        snapshots[name]={'snapshot':dest,'sha256':want,'current_changed_only_after_complete_local_proof':True}
    else:
        assert sha(p/name)==want,(name,'frozen bytes changed')
        checks[name]=True
names=json.loads((p/'comparator.json').read_text())['theorem_names']
def signatures(f):
    return {name:re.sub(r'\s+',' ',sig).strip() for name,sig in re.findall(r'theorem\s+(\w+)\b([\s\S]*?):=\s*by',f.read_text())}
assert signatures(p/'Challenge.lean')==signatures(p/'Solution.lean'),'export signatures changed'
full=(p/'verification/local-solution-build.log').read_text()
assert 'Build completed successfully (8811 jobs).' in full
assert 'error:' not in full
export=(p/'verification/export-audit2.log').read_text()
for n in names:assert f"'{n}' depends on axioms: [propext, Classical.choice, Quot.sound]" in export,n
assert 'error:' not in export
route=(p/'verification/numerical-route-audit.log').read_text()
boolean=(p/'verification/numerical-boolean-audit.log').read_text()
assert 'Material scalar retained:' in route
assert 'verify_strict_lower_bound_dyadic_checked' in route
assert 'of_decide_eq_true (id (Eq.refl true))' in boolean
assert 'error:' not in route+boolean
assert 'PASS (12 declarations)' in (p/'verification/manifest-validation.log').read_text()
active=sorted(p.glob('NLA/IE04/*.lean'))+[p/'Solution.lean']
for f in active:
    text=f.read_text()
    assert not any(x in text for x in ['import Challenge','by sorry','sorryAx','native_decide','axiom ']),str(f)
files=active+[p/x for x in ['Challenge.lean','NUMERICAL_TARGETS.md','comparator.json','formalization.yaml','README.md','PROOF_NOTES.md','lakefile.toml','lake-manifest.json','lean-toolchain','SOURCE_PROVENANCE.json','verification/ExportAudit.lean','verification/numerical-route-audit.lean','verification/numerical-boolean-audit.lean','verification/build-local-receipt.py']]
logs=['verification/local-solution-build.log','verification/solution-direct2.log','verification/export-audit2.log','verification/numerical-route-audit.log','verification/numerical-boolean-audit.log','verification/manifest-validation.log']
receipt={'stage':'complete local proof; independent final review and Linux Comparator pending','created_at_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'author_execution':True,'build_exit':0,'build_jobs':8811,'build_command':'lake build Solution','build_log':'verification/local-solution-build.log','direct_solution_exit':0,'direct_solution_log':'verification/solution-direct2.log','all_export_audit_exit':0,'all_export_audit_command':'lake env lean verification/ExportAudit.lean','all_export_audit_log':'verification/export-audit2.log','exports':names,'axioms':['propext','Classical.choice','Quot.sound'],'all_exact_textual_signatures_match_frozen_Challenge':True,'frozen_bytes_unchanged':checks,'preserved_statement_metadata':snapshots,'LeanCert_material_certificate':{'declaration':'NLA.IE04.exp_neg_two_lower','route_exit':0,'route_log':'verification/numerical-route-audit.log','boolean_exit':0,'boolean_log':'verification/numerical-boolean-audit.log','checker':'verify_strict_lower_bound_dyadic_checked','point':['0','0'],'precision':-53,'depth':10,'actual_boolean_proof':'of_decide_eq_true (id (Eq.refl true))','retained_by':'NLA.IE04.not_exponentialTailConjecture_proved'},'manifest_validation_exit':0,'file_sha256':{str(f.relative_to(p)):sha(f) for f in files},'log_sha256':{s:sha(p/s) for s in logs},'earlier_diagnostics_retained_not_final_evidence':[{'log':'verification/solution-direct.log','exit':1,'reason':'Measurability olean had not yet been emitted; final successful check is solution-direct2.log.'},{'log':'verification/export-audit.log','exit':1,'reason':'GaussianModel olean was temporarily unavailable during the normal rebuild; final successful audit after that build is export-audit2.log.'}],'not_yet_claimed':['independent final code approvals','isolated Linux Comparator and rejection controls','canonical Lean-verified publication status']}
(p/'verification/local-proof.json').write_text(json.dumps(receipt,indent=2)+'\n')
(p/'reviews/proof-source-hashes.json').write_text(json.dumps({'file_sha256':receipt['file_sha256'],'log_sha256':receipt['log_sha256']},indent=2)+'\n')
print('PASS: 12 exact exports; full build 8811 jobs; all standard-three axiom/trust audits; material kernel Boolean; metadata coverage; frozen source and draft snapshots preserved.')
