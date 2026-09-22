from fractions import Fraction as Q
from pathlib import Path
import hashlib,json
p=Path(__file__).resolve().parents[1]
snapshot=json.loads((p/'reviews/statement-source-hashes.json').read_text())
assert all(hashlib.sha256((p/f).read_bytes()).hexdigest()==h for f,h in snapshot.items())
rows=[]
for a in range(5):
 for b in range(6):
  n=2*a+b+1;t=a+b
  L=[[Q(int(i==j)-int(0<i-j<=a)) for j in range(n)] for i in range(n)]
  A=[[Q(0) for j in range(n)] for i in range(n)]
  for j in range(n):
   for i in range(n):
    if a==0:A[i][j]=Q(i==j);continue
    if j<t:
     u=[Q(1) if k==0 and j<=a else Q(2**(k-1)) if 1<=k<=j<=a else Q(1) if k==j and a+1<=j else Q(0) for k in range(n)]
     f=0 if i==a else i+1 if i<a else i
     A[i][j]=sum(L[f][k]*u[k] for k in range(n))/2**a
    elif j==t:A[i][j]=Q(i>=a)
    else:A[i][j]=Q(i==j)
  assert max(map(abs,sum(A,[])))==1
  assert all(A[i][j]==0 for i in range(n) for j in range(n) if j+a<i or i+b<j)
  S=[r[:] for r in A];peak=Q(1);piv=[]
  for k in range(n):
   r=a if k<=a else k
   z=S[r][k];assert z and abs(z)==max(abs(S[i][k]) for i in range(k,n))
   piv.append(str(z));S[k],S[r]=S[r],S[k]
   T=[[Q(0)]*n for _ in range(n)]
   for i in range(k+1,n):
    for j in range(k+1,n):T[i][j]=S[i][j]-S[i][k]/z*S[k][j]
   peak=max(peak,max(map(abs,sum(S,[]))));S=T
  h=[0]
  for k in range(t):h.append(1+sum(h[max(0,k-r)] for r in range(a)))
  target=1 if a==0 else h[t]
  assert peak==target
  rows.append(dict(p=a,q=b,n=n,growth=str(peak),pivots=piv))
result={'verdict':'PASS','scope':'Independent exact rational transcription and full selected-path checks, not universal proof','source_hashes':snapshot,'pairs':rows}
(p/'verification/referee-2-diagnostics.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS: all20 frozen hashes;30 pairs including p=0,q=0; all structural zeros, initial maximum1, every full-path pivot, nonsingularity via nonzero elimination pivots, sharp recurrence growth.')
