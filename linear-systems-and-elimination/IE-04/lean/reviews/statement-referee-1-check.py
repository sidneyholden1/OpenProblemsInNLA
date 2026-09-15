from fractions import Fraction as Q
from pathlib import Path
import hashlib,json,subprocess
H=lambda b:hashlib.sha256(b).hexdigest()
receipt=json.loads(Path('verification/statement-source-hashes.json').read_text())
assert all(H(Path(p).read_bytes())==h for p,h in receipt['files_sha256'].items())
prov=json.loads(Path('SOURCE_PROVENANCE.json').read_text())
for x in prov['sources']:
 b=subprocess.check_output(['git','-C','/private/tmp/nla-lean-sp04','show',prov['base']+':'+x['path']])
 assert H(b)==x['sha256']==H((Path('sources')/Path(x['path']).name).read_bytes())
auth=json.loads(subprocess.check_output(['python3','verification/exact-precheck.py']))
assert auth==json.loads(Path('verification/exact-precheck.json').read_text())

def initial(n):return [[Q(1) if j==n-1 or i==j else -Q(1,2) if j<i else Q(0) for j in range(n)] for i in range(n)]
def mx(a):return max(abs(v) for row in a for v in row)
def actual_step(a,k,r):
 n=len(a);b=[row[:] for row in a];b[k],b[r]=b[r],b[k]
 return [[b[i][j]-b[i][k]*b[k][j]/b[k][k] if i>k and j>k else Q(0) for j in range(n)] for i in range(n)]
def encoded_step(a,k,r):
 n=len(a)
 def swap(i):return r if i==k else k if i==r else i
 return [[a[swap(i)][j]-a[swap(i)][k]/a[r][k]*a[r][j] if i>k and j>k else Q(0) for j in range(n)] for i in range(n)]
for n in [3,4]:
 a=[[Q(1+(i+1)*(j+2)+(i==j)) for j in range(n)] for i in range(n)]
 for k in range(n):
  for r in range(k,n):assert actual_step(a,k,r)==encoded_step(a,k,r)
records=[]
for n in range(2,9):
 w=initial(n);radius=Q(1,2**(n*n+n+1));B=2**(n+2);K=n*n*(n*n+n+5)
 assert B**(n-1)*radius==Q(1,8)
 assert K<=3*n**4 and (radius/16)**(n*n)==Q(1,2**K)
 for pattern in range(4):
  a=[[w[i][j]+radius*(1 if (i*(pattern+1)+j+pattern)%3 else -1) for j in range(n)] for i in range(n)]
  assert all(abs(a[i][j]-w[i][j])<=radius for i in range(n) for j in range(n))
  m0=mx(a);peak=m0;s=[row[:] for row in w];t=[row[:] for row in a]
  for k in range(n):
   assert t[k][k]>0 and all(abs(t[i][k])<abs(t[k][k]) for i in range(k+1,n))
   assert mx([[t[i][j]-s[i][j] for j in range(n)] for i in range(n)])<=B**k*radius
   peak=max(peak,mx(t));s=actual_step(s,k,k);t=actual_step(t,k,k)
  assert peak/m0>Q(3,2)**(n-1)/2
 records.append({'n':n,'four_exact_perturbation_diagnostics':'PASS'})
# Endpoint consequences used in the source's uniform scalar induction.
e=Q(1,8)
assert (Q(1,2)+e)/(1-e)==Q(5,7)<1
assert Q(3,2)/(1-e)<2
assert Q(7,9)>Q(1,2)
libs=['Probability/Distributions/Gaussian/Real.lean','Probability/Independence/Basic.lean','MeasureTheory/Constructions/Pi.lean','MeasureTheory/Measure/MeasureSpaceDef.lean','Analysis/CStarAlgebra/Matrix.lean']
libhash={x:H((Path('.lake/packages/mathlib/Mathlib')/x).read_bytes()) for x in libs}
example=Path('/private/tmp/nla-lean-ie05/linear-systems-and-elimination/IE-05/lean/NLA/IE05/Definitions.lean')
evidence={'phase':'statement review only','reviewer':'/root/iv06_statement_referee_1 independent nonauthor AI','verdict':'APPROVE','read_source_hashes':receipt['files_sha256'],'library_hashes':libhash,'example_hashes':{str(example):H(example.read_bytes())},'fresh_author_precheck_replay':'PASS equals saved JSON','own_exact_diagnostics':records,'actual_swap_encoding_checks':'n=3,4 every active k,r agrees with independent swap-then-update implementation','scope_limits':'Finite rational perturbations are diagnostics, not whole-box proof, probability computation, universal asymptotics, or formal verification. No proof bodies present/read.','typecheck':'Author-run macOS Lean4.33.1 Challenge3106 PASS, twelve placeholders, exact receipt/source hashes independently checked'}
Path('reviews/statement-referee-1-evidence.json').write_text(json.dumps(evidence,indent=2)+'\n')
print('PASS: exact source/receipt hashes; fresh author-precheck replay; independent swaps and 28 exact perturbation diagnostics. No universal proof claim.')
