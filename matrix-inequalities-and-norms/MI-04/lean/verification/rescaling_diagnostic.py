"""Author diagnostic only: exact rational-complex identities, not a proof."""
from fractions import Fraction as F
from pathlib import Path
import json
Z=(F(0),F(0)); O=(F(1),F(0))
def c(a,b=0): return (F(a),F(b))
def add(x,y): return (x[0]+y[0],x[1]+y[1])
def neg(x):return (-x[0],-x[1])
def mul(x,y):return (x[0]*y[0]-x[1]*y[1],x[0]*y[1]+x[1]*y[0])
def conj(x):return (x[0],-x[1])
def ns(x):return x[0]**2+x[1]**2
def sm(a,x):return (a*x[0],a*x[1])
def diag(v):return [[c(v[i]) if i==j else Z for j in range(len(v))] for i in range(len(v))]
def adj(A):return [[conj(A[j][i]) for j in range(len(A))] for i in range(len(A[0]))]
def mm(A,B):return [[sumg([mul(A[i][k],B[k][j]) for k in range(len(B))]) for j in range(len(B[0]))] for i in range(len(A))]
def sumg(v):
 r=Z
 for x in v:r=add(r,x)
 return r
def sub(A,B):return [[add(a,neg(b)) for a,b in zip(ar,br)] for ar,br in zip(A,B)]
def blocks(A,B,D):return [a+b for a,b in zip(A,B)]+[a+b for a,b in zip(adj(B),D)]
def Q(X,i,e,s,t):
 n=len(X);A=diag([1 if k==i else 2-e[k] for k in range(n)]);E=diag([2-t*t if k==i else e[k] for k in range(n)])
 B=[[sm(s if k==i else t*s,x) for x in row] for k,row in enumerate(X)]
 return blocks(A,B,E),A,B,E
counts={'congruence':0,'reflected_congruence':0,'arrow_schur':0,'weight_extraction':0}
for n in range(1,5):
 for seed in range(3):
  X=[[c((a+2*b+seed)%5-2,(2*a-b+seed)%3-1) if seed else Z for b in range(n)] for a in range(n)]
  for i in range(n):
   es=[[F(2) if k==i else F(1) for k in range(n)]]
   for j in range(n):
    if j!=i:
     e=es[0].copy();e[j]=F(1,2);es.append(e)
   def diff(e):return sum((ns(X[i][j])-ns(X[j][i]))/e[j] for j in range(n))
   for j in range(n):
    if j!=i:
     e=es[0].copy();e[j]=F(1,2)
     assert diff(e)-diff(es[0])==ns(X[i][j])-ns(X[j][i]);counts['weight_extraction']+=1
   for e in es:
    for s in [F(1,2),F(2)]:
     for t in [F(0),F(1,3),F(-1,2)]:
      Qt,A,B,E=Q(X,i,e,s,t);S=diag([t if k==i else 1 for k in range(n)]+[1]*n)
      D=diag([t*t if k==i else 2-e[k] for k in range(n)])
      P=blocks(D,[[sm(t*s,x) for x in row] for row in X],E)
      assert mm(mm(S,Qt),S)==P;counts['congruence']+=1
      Qr,*_=Q(adj(X),i,e,s,t)
      Pr=blocks(D,[[sm(t*s,x) for x in row] for row in adj(X)],E)
      assert mm(mm(S,Qr),S)==Pr;counts['reflected_congruence']+=1
     _,A,B,E=Q(X,i,e,s,F(0));Einv=diag([1/x for x in e]);R=sum(ns(X[i][j])/e[j] for j in range(n))
     assert sub(A,mm(mm(B,Einv),adj(B)))==diag([1-s*s*R if k==i else 2-e[k] for k in range(n)])
     counts['arrow_schur']+=1
result={'verdict':'PASS','arithmetic':'exact Fraction pairs representing complex rationals','dimensions':[1,2,3,4],'includes_zero_matrix':True,'checks':counts,'total_checks':sum(counts.values()),'limitations':'Finite author diagnostic of exact identities only; no all-dimensional positivity, limit, geometry or Lean proof claim.'}
Path('verification/rescaling-diagnostic.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
