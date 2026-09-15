from pathlib import Path
import subprocess,json,hashlib,re
r=Path('/private/tmp/nla-lean-ke05');p=r/'randomized-and-low-rank-approximation/KE-05/lean';base='9acd5d5c9ab91c5c0c07603b6b48c0cb7ede54e6'
def blob(path):return subprocess.check_output(['git','show',base+':'+str(path)],cwd=r)
active=list(p.glob('NLA/KE05/*.lean'))+[p/'Solution.lean',p/'Challenge.lean',p/'NUMERICAL_TARGETS.md',p/'comparator.json',p/'lakefile.toml',p/'lake-manifest.json',p/'lean-toolchain']
for f in active: assert f.read_bytes()==blob(f.relative_to(r)),f
f=p.parent/'README.md';marker='## Original statement (retained)'
assert f.read_text().split(marker,1)[1]==blob(f.relative_to(r)).decode().split(marker,1)[1]
assert '**Status:** Lean verified' in f.read_text()
for n in ['solution.md','solution.tex','solution.pdf']:
 f=p.parent/n
 assert f.read_bytes()==blob(f.relative_to(r)),f
assert (r/'problem_ids.json').read_bytes()==blob(Path('problem_ids.json'))
assert len(json.loads((r/'problem_ids.json').read_text()))==217
for path in ['README.md','CATALOG.md','randomized-and-low-rank-approximation/README.md']:
 assert 'KE-05' in (r/path).read_text() or path=='README.md'
e=r/'docs/lean/verification-2026-09-15/KE-05'
assert json.loads((e/'ROOT-LINUX-CHECKS.json').read_text())['verdict']=='PASS'
print(f'PASS: all {len(active)} proof/boundary/configuration files byte-identical to tested commit; full original canonical target and informal source retained; permanent registry unchanged; Linux audit PASS.')
