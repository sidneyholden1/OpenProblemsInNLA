"""Freeze MI-04 local completion only; independent final reviews/Linux remain pending."""
from pathlib import Path
import hashlib,json,re,shutil,subprocess,sys
import yaml,jsonschema
p=Path(__file__).resolve().parents[1]
def sha(f):return hashlib.sha256((p/f).read_bytes()).hexdigest()
names=json.loads((p/'comparator.json').read_text())['theorem_names'];assert len(names)==2
statement=json.loads((p/'reviews/statement-source-hashes.json').read_text())
preserved={}
for f,h in statement.items():
 dst='reviews/statement-original/'+f if f in ['README.md','formalization.yaml'] else f
 if dst!=f and not (p/dst).exists():
  assert sha(f)==h,(f,'statement changed')
  (p/dst).parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(p/f,p/dst)
 assert sha(dst)==h,(f,'statement changed')
 preserved[f]=dst
assert json.loads((p/'reviews/statement-gate.json').read_text())['verdict'].startswith('PASS')
active=[str(f.relative_to(p)) for f in sorted(p.glob('NLA/MI04/*.lean'))]+['Solution.lean']
for f in active:
 assert not re.search(r'\b(sorry|admit|native_decide|axiom|unsafe)\b',(p/f).read_text()),f
build=(p/'verification/solution-build-final.log').read_text()
m=re.search(r'Build completed successfully \((\d+) jobs\)',build);assert m
log=(p/'verification/author-exact-audit.log').read_text();assert 'error:' not in log
for n in names:assert "'"+n+"' depends on axioms: [propext, Classical.choice, Quot.sound]" in log
x=yaml.safe_load((p/'formalization.yaml').read_text())
x['status']['scope']='Complete local kernel proof of the original universal positive-block norm implication for every finite n>=1 and arbitrary complex X, plus orthonormal-pair modulus symmetry. Actual Euclidean operator norms, literal PSD block matrices and all Hermitian A,B are retained. No invertibility, spectral simplicity, normality, perturbation or central bridge is an extra assumption. Optional converse, numerical-range theorem and four-way equivalence are excluded. Independent final reviews and actual isolated Linux Comparator remain pending; canonical status unchanged.'
x['status']['sorry_count']=0;x['status']['sorry_in_definitions']=0;x['status']['axioms']=['propext','Classical.choice','Quot.sound']
for v in x['status']['main_results']:
 v.update(file='Solution.lean',sorry_count=0,axioms=['propext','Classical.choice','Quot.sound'])
x['review']['status']='final-review-pending'
x['review']['notes']='Two independent nonauthor statement approvals were hash-bound before proof. Authors /root and /root/iv06_statement_referee_1 are excluded as final referees; independent final reviewers are /root/iv06_statement_referee_2 and /root/new_target_screen. Full local Solution and separate literal two-signature author consumer pass kernel trust checks with standard-three axioms. Final reviews and actual Linux gates remain pending.'
x['automation']['methods'][0]['tool_setup']='Lean 4.33.1, exact pinned Mathlib/LeanCert HTTPS dependencies, separate frozen Challenge and complete Solution, actual transitive kernel trust audit. Full build explicitly targets Solution; the frozen default target remains Challenge.'
jsonschema.validate(x,json.loads((p/'../../../docs/lean/schema/v0.4.schema.json').read_text()))
assert [v['declaration'] for v in x['status']['main_results']]==names
(p/'formalization.yaml').write_text('# yaml-language-server: $schema=https://raw.githubusercontent.com/mathlib-initiative/formalization.yaml/99c678e569c7c4c0772db297c5ddd5e4c9b6322e/schema/v0.4.schema.json\n'+yaml.safe_dump(x,sort_keys=False,allow_unicode=True,width=100))
(p/'README.md').write_text('''# MI-04 Lean formalization

The complete original universal positive-block norm implication is proved locally for every finite n>=1 and arbitrary complex matrix X. If every actual PSD block [[A,X],[X*,B]] with Hermitian A,B satisfies the actual spectral L2 norm bound by A+B, then X=alpha K+beta I for a Hermitian K and complex scalars alpha,beta. A second export proves the intermediate modulus symmetry for every genuine orthonormal pair. No invertibility, real-entry, normality, simple-spectrum or perturbation hypothesis is added. Scalar matrices and dimension one are included.

Only canonical necessity and the pair intermediate are advertised. The source's optional converse, numerical-range characterization and full four-way equivalence are not formal claims here.

Local status: full `lake build Solution` and a separate consumer of both literal frozen signatures pass; LeanCert kernel assertions and actual transitive axiom closures use only propext, Classical.choice and Quot.sound. Two independent nonauthor statement approvals preceded proof. Independent final reviews and actual isolated Linux Comparator are pending. Canonical status and original sources remain unchanged.

The exact PSD reflection/rescaling argument replaces the source's simple-eigenvalue second-order perturbation step; this is a formal-proof adaptation, not verbatim source reasoning. It proves positive-definite gap, arrow Schur identities, all genuine congruences and the PSD limit internally. Two rational weight configurations isolate coordinate moduli, then actual unitary basis extension handles all pairs. Pair symmetry gives normality, exact Fourier triples force spectral collinearity, and actual CFC real-spectrum geometry yields the Hermitian affine representation. All arguments are exact; no interval root search or numerical oracle is used. LeanCert audits kernel trust rather than a decorative numerical certificate.

Read [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md), the frozen [PROOF_PLAN.md](PROOF_PLAN.md), the implemented [rescaling proof map](RESCALING_PROOF_NOTES.md), [Definitions](NLA/MI04/Definitions.lean), [Solution](Solution.lean), and the [complete source manuscript](../solution.tex). Local receipts are in verification/local-proof-20260922.json. Reviewed statement metadata is preserved in reviews/statement-original.

Reproduce with explicit `lake build Solution` using the pinned toolchain. The frozen default target is Challenge and still contains exactly two deliberate placeholders; no placeholder is in the actual Solution closure. The isolated Linux procedure is in the [reproduction guide](../../../docs/lean/README.md). Exact diagnostic checks are finite transcription checks only.

Mathematical source: Matthew J. Colbrook, Cambridge. Original question: Bourin–Lee; Hayashi background. Formalization: Sidney Holden with OpenAI Codex assistance. Authors are agents /root and /root/iv06_statement_referee_1; independent final reviewers are /root/iv06_statement_referee_2 and /root/new_target_screen. AI-agent review is not external human peer review or author endorsement. Mathlib, LeanCert, Comparator and formalization.yaml retain licenses/credit. No cross-project mathematical theorem is imported.
''')
cmd=[sys.executable,str(p/'../../../tools/lean/validate_manifest.py'),str(p)]
v=subprocess.run(cmd,cwd=p,text=True,capture_output=True)
(p/'verification/metadata-local-complete.log').write_text('Official v0.4 schema and exact two-export coverage PASS.\n'+v.stdout+v.stderr)
assert v.returncode==0,v.stdout+v.stderr
(p/'verification/metadata-local-complete.json').write_text(json.dumps({'verdict':'PASS','exports':2,'official_schema':'pinned v0.4','validator_exit_code':0,'command':cmd},indent=2)+'\n')
files=active+['Challenge.lean','NUMERICAL_TARGETS.md','PROOF_PLAN.md','RESCALING_PROOF_NOTES.md','README.md','formalization.yaml','comparator.json','lean-toolchain','lakefile.toml','lake-manifest.json','LICENSE','verification/source-provenance.json','verification/solution-build-final.log','verification/AuthorExactAudit.lean','verification/author-exact-audit.log','verification/Author1Audit.lean','verification/author-1-audit.log','verification/author-1-completion.json','verification/metadata-local-complete.log','verification/metadata-local-complete.json','verification/finish_local_proof.py']
hashes={f:sha(f) for f in files}
(p/'reviews/proof-source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
receipt={'verdict':'PASS','phase':'complete local proof; independent final reviews and actual Linux pending','build_exit_code':0,'build_jobs':int(m.group(1)),'audit_exit_code':0,'execution_provenance':'Coordinator /root ran full Solution build; author /root/iv06_statement_referee_1 ran separate literal two-signature consumer. Neither is an independent MI04 final referee.','exports':names,'actual_axioms':['propext','Classical.choice','Quot.sound'],'active_proof_holes':0,'frozen_statement_inputs_preserved':preserved,'proof_snapshot_sha256':sha('reviews/proof-source-hashes.json'),'hashes':hashes,'independent_final_reviews':'pending','isolated_linux_comparator':'pending'}
(p/'verification/local-proof-20260922.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'verdict':'PASS','inputs':len(files),'preserved_statement_inputs':len(statement),'proof_snapshot_sha256':sha('reviews/proof-source-hashes.json'),'local_receipt_sha256':sha('verification/local-proof-20260922.json')}))
