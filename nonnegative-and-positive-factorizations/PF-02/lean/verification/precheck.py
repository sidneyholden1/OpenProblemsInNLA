"""Author-side exact diagnostics, not a Lean proof or independent referee review."""
import json,itertools,functools
from fractions import Fraction as Q

def trans(A): return [list(x) for x in zip(*A)]
def mul(A,B): return [[sum(x*y for x,y in zip(r,c)) for c in trans(B)] for r in A]
def det(A):
 A=[list(map(Q,r)) for r in A];n=len(A);d=Q(1)
 for i in range(n):
  pivot=next((j for j in range(i,n) if A[j][i]),None)
  if pivot is None:return Q(0)
  if pivot!=i:A[i],A[pivot]=A[pivot],A[i];d=-d
  a=A[i][i];d*=a
  for j in range(i+1,n):
   c=A[j][i]/a
   for k in range(i,n):A[j][k]-=c*A[i][k]
 return d

def coord(A):return [A[0][0],A[1][1],A[2][2],A[0][1],A[0][2],A[1][2]]
def gram(F):return [[sum(mul(A,B)[i][i] for i in range(3)) for B in F] for A in F]
F=[[[4,0,0],[0,2,0],[0,0,2]],[[2,0,0],[0,4,0],[0,0,2]],[[2,0,0],[0,2,0],[0,0,4]],[[2,1,0],[1,2,0],[0,0,2]],[[2,0,1],[0,2,0],[1,0,2]],[[2,0,0],[0,2,1],[0,1,2]]]
H=[[r[:] for r in A] for A in F];H[3]=[[2,-1,0],[-1,2,0],[0,0,2]]
M=[[24,20,20,16,16,16],[20,24,20,16,16,16],[20,20,24,16,16,16],[16,16,16,14,12,12],[16,16,16,12,14,12],[16,16,16,12,12,14]]
assert gram(F)==M==gram(H)
minors=[[str(det([r[:k] for r in A[:k]])) for k in [1,2,3]] for A in F+H]
assert all(Q(x)>0 for row in minors for x in row)
assert det(M)==8192 and det(list(map(coord,F)))==32 and det(list(map(coord,H)))==-32
G=[[([1,1,1,2,2,2][i] if i==j else 0) for j in range(6)] for i in range(6)]
assert mul(mul(list(map(coord,F)),G),trans(list(map(coord,F))))==M

# Exact sparse integer polynomials in all nine entries of an arbitrary real S.
z=(0,)*9
one={z:1}
def add(a,b):
 c=a.copy()
 for m,v in b.items():
  c[m]=c.get(m,0)+v
  if c[m]==0:del c[m]
 return c
def scale(a,k):return {m:v*k for m,v in a.items() if v*k}
def pmul(a,b):
 c={}
 for m,v in a.items():
  for n,w in b.items():
   t=tuple(x+y for x,y in zip(m,n));c[t]=c.get(t,0)+v*w
 return {m:v for m,v in c.items() if v}
def var(i):
 m=list(z);m[i]=1;return {tuple(m):1}
S=[[var(3*i+j) for j in range(3)] for i in range(3)]
pairs=[(0,0),(1,1),(2,2),(0,1),(0,2),(1,2)]
C=[]
for i,j in pairs:
 row=[]
 for a,b in pairs:
  row.append(pmul(S[i][a],S[i][b]) if i==j else add(pmul(S[i][a],S[j][b]),pmul(S[j][a],S[i][b])))
 C.append(row)
def pdet(A):
 n=len(A)
 @functools.lru_cache(None)
 def rec(cols):
  i=n-len(cols)
  if not cols:return one
  s={}
  for j,c in enumerate(cols):s=add(s,scale(pmul(A[i][c],rec(cols[:j]+cols[j+1:])),(-1)**j))
  return s
 return rec(tuple(range(n)))
d=pdet(S);d4=pmul(pmul(d,d),pmul(d,d));cd=pdet(C)
assert cd==d4
print(json.dumps({'status':'PASS','scope':'author-side exact arithmetic diagnostics, not Lean or independent review','matrix_determinant':str(det(M)),'orientation_determinants':[str(det(list(map(coord,F)))),str(det(list(map(coord,H))))],'leading_principal_minors_original_then_reflected':minors,'two_trace_grams_equal_witness':True,'trace_metric_factorization':True,'all_entries_strictly_positive':all(x>0 for r in M for x in r),'generic_congruence_determinant_identity':{'variables':9,'degree':12,'coefficientwise_equal':True,'nonzero_terms':len(cd)},'limits':'Does not prove PSD-rank minimality, every-factorization orientation nonvanishing, quotient relation/topology, continuity, disconnectedness or the universal negation.'},indent=2))
