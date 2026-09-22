"""Exact diagnostic of column/row Kronecker conventions; not a Lean proof."""
from fractions import Fraction as Q
import json
A=[[Q(2),Q(1)],[Q(1),Q(2)]]
B=[[Q(3),Q(0)],[Q(0),Q(1)]]
def mul(a,b): return [[sum(a[i][k]*b[k][j] for k in range(len(b))) for j in range(len(b[0]))] for i in range(len(a))]
def add(a,b): return [[x+y for x,y in zip(ar,br)] for ar,br in zip(a,b)]
def transpose(a): return list(map(list,zip(*a)))
def vec(x): return [x[r][c] for c in range(2) for r in range(2)]
def kron(a,b): return [[a[c][d]*b[r][s] for d in range(2) for s in range(2)] for c in range(2) for r in range(2)]
def mv(k,v): return [sum(a*b for a,b in zip(row,v)) for row in k]
def ray(k,v): return sum(a*b for a,b in zip(v,mv(k,v)))/sum(a*a for a in v)
K=kron(A,B); J=add(K,kron(B,A)); T=[[Q(c==s and r==d) for d in range(2) for s in range(2)] for c in range(2) for r in range(2)]
for X in [[[Q(1),Q(2)],[Q(3),Q(4)]],[[Q(1),Q(2)],[Q(2),Q(3)]],[[Q(0),Q(1)],[Q(-1),Q(0)]]]:
 assert mv(T,vec(X))==vec(transpose(X))
 assert mv(J,vec(X))==vec(add(mul(mul(A,X),B),mul(mul(B,X),A)))
for X,sign in [([[Q(1),Q(2)],[Q(2),Q(3)]],1),([[Q(0),Q(1)],[Q(-1),Q(0)]],-1)]:
 v=vec(X); assert mv(T,v)==[sign*x for x in v];assert ray(J,v)==2*ray(K,v)
print(json.dumps({'verdict':'PASS','scope':'Exact coordinate and factor-two diagnostics on a noncommuting SPD pair, not a universal certificate','A':[[str(x) for x in r]for r in A],'B':[[str(x)for x in r]for r in B],'column_vec_general':[str(x)for x in vec([[Q(1),Q(2)],[Q(3),Q(4)]])]},indent=2))
