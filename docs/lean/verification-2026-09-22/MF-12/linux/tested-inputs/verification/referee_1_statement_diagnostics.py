from fractions import Fraction as F
from itertools import product
from pathlib import Path
import json,hashlib,subprocess
R=Path(__file__).resolve().parent
def M(rows):return [[F(x) for x in r] for r in rows]
def eye(n):return M([[int(i==j) for j in range(n)]for i in range(n)])
def mul(A,B):return [[sum(a*b for a,b in zip(row,col)) for col in zip(*B)]for row in A]
def power(A,n):
 B=eye(len(A))
 for _ in range(n):B=mul(B,A)
 return B
l=F(1,4);u=F(1,2)
A=M([[1,0,0,0,0,0],[0,l,l,0,0,0],[0,0,l,0,0,0],[0,0,0,u,u,0],[0,0,0,0,u,0],[0,0,0,0,0,1]])
V=M([[1,0],[0,0],[1,0],[0,0],[0,1],[0,1]])
U=M([[1,-1,0,1,0,0],[0,0,0,0,0,1]])
P=mul(V,U);assert mul(U,V)==eye(2);assert mul(P,P)==P
T=lambda q:M([[1-q*l**q,q*u**q],[0,1]])
for q in range(13):assert mul(mul(U,power(A,q)),V)==T(q)
count=0
for k in range(5):
 for qs in product(range(6),repeat=k):
  W=eye(2)
  for q in qs:W=mul(T(q),W)
  assert 0<=W[0][0]<=1 and W[1]==[0,1] and W[0][1]>=0
  assert W[0][1]**2<=sum(qs)
  weights=[__import__('functools').reduce(lambda a,q:a*(1-q*l**q),qs[i+1:],F(1))for i in range(k)]
  assert sum(q*l**q*w for q,w in zip(qs,weights))==1-W[0][0]
  count+=1
lower=[]
for n in range(4,65):
 q=0
 while 4**(q+1)<=n:q+=1
 k=n//(q+1);r=n-k*(q+1);ell=q*l**q;b=q*u**q
 assert q>=1 and k*(q+1)+r==n and 0<=r<q+1
 assert k*ell>=F(1,4)
 Tk=power(T(q),k);assert Tk[0][1]==b/ell*(1-(1-ell)**k)
 assert 1-(1-ell)**k>=F(1,8)
 W=mul(power(A,r),power(mul(P,power(A,q)),k))
 assert mul(W,V)==mul(mul(power(A,r),V),Tk)
 assert mul(W,V)[0][1]==Tk[0][1]
 lower.append({'n':n,'q':q,'k':k,'r':r})
source=subprocess.check_output(['git','show','736845bc:references/colbrook-jsr-growth-2026-09-11/manuscripts/arbitrary_growth_exponents.tex'],cwd=Path.cwd())
d={'verdict':'PASS','role':'independent exact finite diagnostics, not a proof of the universal target','parameters':{'lambda':'1/4','mu':'1/2','alpha':'1/2'},'source_sha256':hashlib.sha256(source).hexdigest(),'compressed_powers':13,'gap_lists_checked':count,'lower_lengths_checked':61,'lower_decompositions':lower,'scope_limits':'No finite enumeration proves arbitrary real exponents, all switching words, tensor closure, operator norms or the actual joint spectral radius limit. These remain mandatory formal obligations.'}
(R/'diagnostics.json').write_text(json.dumps(d,indent=2)+'\n');print(json.dumps({k:d[k] for k in ['verdict','compressed_powers','gap_lists_checked','lower_lengths_checked','source_sha256']}))
