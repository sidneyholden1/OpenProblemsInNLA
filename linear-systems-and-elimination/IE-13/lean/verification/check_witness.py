"""Exact finite checks of the literal draft; not a universal proof."""
from fractions import Fraction as Q
from pathlib import Path
import json,hashlib

def h(p,t):
 a=[0]
 for k in range(t):a.append(1+sum(a[max(k-r,0)] for r in range(p)))
 return a[t]

def witness(p,q):
 n=2*p+q+1;t=p+q
 if p==0:return [[Q(i==j) for j in range(n)] for i in range(n)]
 def L(i,j):return Q(1 if i==j else -1 if j<i<=j+p else 0)
 def U(k,i):return Q(1 if i==0 and k<=p else 2**(i-1) if 1<=i<=k<=p else 1 if i==k and p+1<=k else 0)
 def row(i):return 0 if i==p else i+1 if i<p else i
 return [[sum(L(row(i),a)*U(j,a) for a in range(n))/2**p if j<t else Q(i>=p) if j==t else Q(i==j) for j in range(n)] for i in range(n)]
results=[]
for p in range(5):
 for q in range(6):
  A=witness(p,q);n=len(A);assert n>=1+max(p,q)
  assert max(abs(x) for row in A for x in row)==1
  assert all(A[i][j]==0 for i in range(n) for j in range(n) if j+p<i or i+q<j)
  S=A;peak=Q(1);det=Q(1);labels=list(range(n));chosen=[]
  for k in range(n):
   r=p if k<=p else k;chosen.append(labels[r]);pivot=S[r][k]
   assert pivot and all(abs(S[i][k])<=abs(pivot) for i in range(k,n))
   det*=pivot*(-1 if r!=k else 1)
   T=[row[:] for row in S];T[k],T[r]=T[r],T[k]
   S=[[T[i][j]-T[i][k]/pivot*T[k][j] if k<i and k<j else Q(0) for j in range(n)] for i in range(n)]
   labels[k],labels[r]=labels[r],labels[k]
   if k+1<n:peak=max(peak,max(abs(x) for row in S for x in row))
  assert chosen==[p]+list(range(p))+list(range(p+1,n))
  bound=1 if p==0 else h(p,p+q)
  assert peak==bound and det!=0
  results.append({'p':p,'q':q,'n':n,'sharp':bound,'det':str(det)})
out={'verdict':'PASS','scope':'30 finite exact rational draft-witness checks including all prescribed pivots; not universal proof.','script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'results':results}
Path('verification/witness-precheck.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS 30 literal draft witnesses, full paths, support, determinant and growth')
