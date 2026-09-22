"""Independent stdlib-only statement diagnostics; not Lean proof evidence."""
from itertools import combinations, permutations
from collections import defaultdict, Counter
from fractions import Fraction as F
from pathlib import Path
import json
edges=list(combinations(range(4),2));zero=(0,)*6

def add(a,b):
 r=defaultdict(int,a)
 for k,v in b.items():r[k]+=v
 return {k:v for k,v in r.items() if v}
def neg(a):return {k:-v for k,v in a.items()}
def mul(a,b):
 r=defaultdict(int)
 for u,v in a.items():
  for w,z in b.items():r[tuple(x+y for x,y in zip(u,w))]+=v*z
 return {k:v for k,v in r.items() if v}
def sign(p):return (-1)**sum(p[i]>p[j] for i in range(len(p)) for j in range(i+1,len(p)))
def det(M):
 r={}
 for p in permutations(range(len(M))):
  t={zero:sign(p)}
  for i,j in enumerate(p):t=mul(t,M[i][j])
  r=add(r,t)
 return r
L=[[{} for j in range(4)] for i in range(4)]
for k,(i,j) in enumerate(edges):
 e=tuple(int(l==k) for l in range(6));v={e:1}
 L[i][i]=add(L[i][i],v);L[j][j]=add(L[j][j],v)
 L[i][j]=neg(v);L[j][i]=neg(v)
# d/dx det(xI-B) at x=1 is sum of diagonal cofactors of I-B=L.
deriv={}
for k in range(4):deriv=add(deriv,det([[L[i][j] for j in range(4) if j!=k] for i in range(4) if i!=k]))
def components(support):
 parts=[{i} for i in range(4)]
 for k in support:
  i,j=edges[k];a=next(p for p in parts if i in p);b=next(p for p in parts if j in p)
  if a is not b:a.update(b);parts.remove(b)
 return sorted(map(len,parts))
trees=[t for t in combinations(range(6),3) if components(t)==[4]]
expected={tuple(int(k in t) for k in range(6)):4 for t in trees}
assert deriv==expected and len(trees)==16
counts=Counter()
for mask in range(64):
 s=[k for k in range(6) if mask&(1<<k)];c=components(s)
 if c==[4]:counts['connected']+=1
 elif 1 in c:counts['isolated']+=1
 else:assert c==[2,2] and len(s)==2;counts['two_pairs']+=1
assert dict(counts)=={'isolated':23,'two_pairs':3,'connected':38}
def rational_det(M):
 return sum(sign(p)*__import__('functools').reduce(lambda a,b:a*b,(M[i][j] for i,j in enumerate(p)),F(1)) for p in permutations(range(len(M))))
A=[[0,1,0,0],[1,0,0,0],[0,0,F(1,2),F(1,2)],[0,0,F(1,2),F(1,2)]]
# Monic degree4 equality checked at five distinct exact points.
for x in range(-2,3):assert rational_det([[F(x*(i==j))-A[i][j] for j in range(4)] for i in range(4)])==x*(x-1)**2*(x+1)
assert sum(A[i][i] for i in range(4))==1
assert all(sum(row)==1 and min(row)>=0 for row in A)
assert all(A[i][j]==A[j][i] for i in range(4) for j in range(4))
I=[[F(int(i==j)) for j in range(4)] for i in range(4)]
left=[row[:] for row in I];left[0]=[0,1,0,0];left[1]=[1,0,0,0]
right=[row[:] for row in left];right[2]=[0,0,0,1];right[3]=[0,0,1,0]
assert left!=right and all(A[i][j]==F(left[i][j]+right[i][j])/2 for i in range(4) for j in range(4))
for M in [left,right]:
 assert all(sum(row)==1 and min(row)>=0 for row in M)
 assert all(M[i][j]==M[j][i] for i in range(4) for j in range(4))
iso=[[F(1) if i==j==0 else F(1,2) if i>0 and j>0 and i!=j else F(0) for j in range(4)] for i in range(4)]
assert rational_det(iso)==F(1,4)
print('PASS: p\'(1) cofactor polynomial equals exactly four times 16 spanning-tree monomials.')
print('PASS: 64 independent connectivity support cases:',dict(counts))
print('PASS: witness symmetry/nonnegativity/row sums/trace and degree4 characteristic polynomial.')
print('PASS: distinct admissible midpoint endpoints; isolated-vertex forced matrix determinant=1/4.')
print('All calculations exact; diagnostic statement evidence only, not Lean proof.')
