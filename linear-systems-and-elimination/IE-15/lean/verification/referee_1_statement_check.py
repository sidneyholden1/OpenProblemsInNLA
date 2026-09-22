"""Independent exact padded row/column path diagnostic; not a Lean proof."""
from fractions import Fraction as F
from itertools import permutations
from math import prod

def det(A):
 n=len(A)
 return sum((-1)**sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))*prod(A[i][p[i]] for i in range(n)) for p in permutations(range(n)))
def step(A,k,r,c):
 n=len(A);rs=lambda i:r if i==k else k if i==r else i;cs=lambda j:c if j==k else k if j==c else j
 return [[A[rs(i)][cs(j)]-A[rs(i)][c]*A[r][cs(j)]/A[r][c] if i>k and j>k else F(0) for j in range(n)] for i in range(n)]
def paths(A,k=0,peak=F(0)):
 n=len(A);peak=max(peak,max(abs(v) for row in A for v in row))
 for r in range(k,n):
  for c in range(k,n):
   p=abs(A[r][c])
   if p and all(abs(A[i][c])<=p for i in range(k,n)) and all(abs(A[r][j])<=p for j in range(k,n)):
    if k==n-1:yield peak
    else:yield from paths(step(A,k,r,c),k+1,peak)
examples=[([[1,0,-1],[0,1,-1],[1,1,1]],F(3),F(3)),([[1,0,1,1],[0,1,F(1,3),-1],[F(-1,3),-1,1,-1],[-1,1,1,1]],F(70,9),F(14,3))]
for A,D,G in examples:
 A=[[F(x) for x in row] for row in A];n=len(A);assert det(A)==D
 initial=max(abs(x) for row in A for x in row);assert initial==1
 S=A;maxima=[];pivots=[]
 for k in range(n):
  p=S[k][k];assert p and all(abs(S[i][k])<=abs(p) for i in range(k,n)) and all(abs(S[k][j])<=abs(p) for j in range(k,n))
  pivots.append(p);maxima.append(max(abs(x) for row in S for x in row));S=step(S,k,k,k)
 assert max(maxima)/initial==G and all(x==0 for row in S for x in row)
 gs=list(paths(A));assert gs and max(gs)/initial==G
 print(f'n={n}: det={D}, diagonal pivots={list(map(str,pivots))}, stage maxima={list(map(str,maxima))}, growth={G}; all {len(gs)} admissible witness paths also enumerated, maximum={max(gs)}; PASS.')
print('Rational diagnostics only. Universal arbitrary-input bounds are NOT established by this script.')
