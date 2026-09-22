from pathlib import Path
import json, hashlib, shutil
import yaml
p=Path('.'); sha=lambda f:hashlib.sha256(Path(f).read_bytes()).hexdigest()
snapshot=json.loads(Path('reviews/statement-source-hashes.json').read_text())
assert all(sha(k)==v for k,v in snapshot.items())
backup=Path('reviews/statement-review-snapshot');backup.mkdir(exist_ok=True)
for name in ['README.md','formalization.yaml']:
 shutil.copy2(name,backup/name)
d=yaml.safe_load(Path('formalization.yaml').read_text())
d['project']['description']='Full finite-family all-word two-sided polynomial growth at every positive length and actual joint spectral radius one for every real nonnegative exponent; complete local kernel proof.'
d['automation']['methods'][0]['tool_setup']='Lean 4.33.1, pinned Mathlib and LeanCert. Separate trusted Challenge and complete Solution; LeanCert kernel trust audits, exact HTTPS dependency pins, shared local cache.'
d['status']['scope']='Complete original canonical target. Four Solution exports locally built and checked with LeanCert kernel trust; no sorry in active proof closure. Two independent statement approvals frozen before proof. Independent final reviews and actual isolated Linux Comparator pending; canonical status unchanged.'
d['status']['sorry_count']=0
for x in d['status']['main_results']: x['file']='Solution.lean';x['sorry_count']=0
d['fidelity']['divergences']+=' Integer extension uses repeated fixed two-dimensional Jordan tensor factors instead of a single optimal-size Jordan block. This changes only unadvertised dimension efficiency; all real exponents, all lengths and actual L2 norms remain. Exact entrywise norm comparisons avoid an unnecessary spectral tensor-norm equality. LeanCert supplies kernel trust audits; no artificial interval calculation.'
d['review']['status']='local-proof-complete-final-review-pending'
d['review']['notes']='Two nonauthor statement approvals bound to the frozen source snapshot and successful Challenge build. Complete local Solution build and standard-three axiom checks pass. Independent final reviews and fresh isolated Linux Comparator remain pending. Statement-time metadata wrappers retained in reviews/statement-review-snapshot.'
Path('formalization.yaml').write_text('# yaml-language-server: $schema=https://raw.githubusercontent.com/mathlib-initiative/formalization.yaml/99c678e569c7c4c0772db297c5ddd5e4c9b6322e/schema/v0.4.schema.json\n'+yaml.safe_dump(d,sort_keys=False,allow_unicode=True,width=100))
s=Path('README.md').read_text().replace('# MF-12 Lean statement boundary','# MF-12 complete local Lean proof')
a=s.index('Status:');b=s.index('See NUMERICAL_TARGETS',a)
s=s[:a]+'''Status: complete local Solution build (3,110 jobs), all four exports checked
with LeanCert kernel trust and only the standard `propext`, `Classical.choice`,
and `Quot.sound` axioms. Independent final reviews and actual isolated Linux
Comparator checks are pending. Canonical target, ID, path and status remain unchanged.
The four intentional placeholders remain only in the trusted Challenge module,
which Solution does not import. Statement approvals and original metadata wrappers
are retained under reviews/.

Proof route: exact source compression, finite Hölder and telescoping bounds for
every reset word, logarithmic-gap witnesses padded to every positive length,
genuine finite maxima and the actual root limit. Repeated fixed 2×2 Jordan tensor
factors cover integer parts of arbitrary real exponents. Their larger dimensions
are permitted by the canonical target; no optimal-dimension claim is made.
Entrywise comparisons retain the actual L2 operator norm. LeanCert provides
kernel trust audits; this exact argument needs no interval certificate.

'''+s[b:]
Path('README.md').write_text(s)
print('All 15 frozen statement inputs checked before preserving/updating documentation wrappers.')
