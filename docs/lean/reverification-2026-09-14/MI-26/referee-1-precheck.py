from fractions import Fraction as F
from itertools import combinations,permutations
import json,pathlib,subprocess,hashlib
ps=json.loads(pathlib.Path('/private/tmp/nla-third-five/projects.json').read_text())
def mat(x):return [[F(v) for v in r] for r in x]
def T(a):return list(map(list,zip(*a)))
def mul(a,b):return [[sum(x*y for x,y in zip(r,c)) for c in T(b)] for r in a]
def add(a,b):return [[x+y for x,y in zip(r,s)]for r,s in zip(a,b)]
def sub(a,b):return add(a,scale(-1,b))
def scale(t,a):return [[t*x for x in r]for r in a]
def diag(*x):return [[F(x[i]) if i==j else F(0)for j in range(len(x))]for i in range(len(x))]
def det(a):
 return sum((-1)**sum(p[i]>p[j]for i in range(len(p))for j in range(i+1,len(p)))*prod(a[i][p[i]]for i in range(len(p)))for p in permutations(range(len(a))))
def prod(x):
 r=F(1)
 for a in x:r*=a
 return r
def psd(a):
 assert a==T(a)
 assert all(det([[a[i][j]for j in s]for i in s])>=0 for r in range(1,len(a)+1)for s in combinations(range(len(a)),r))
A=mat([[1,'3/4',0],[0,0,0],[0,0,0]]);B=mat([[-1,0,0],[0,0,0],['-3/4',0,0]])
R=mat([['4/5','3/5',0],['3/5','9/20',0],[0,0,0]]);L=diag('5/4',0,0);R2=mat([['4/5',0,'3/5'],[0,0,0],['3/5',0,'9/20']]);S=add(A,B)
for X,Y in [(A,R),(T(A),L),(B,L),(T(B),R2),(S,diag('3/4','3/4',0)),(T(S),diag('3/4',0,'3/4'))]:assert mul(Y,Y)==mul(T(X),X);psd(Y)
u=mat([[3],[1],[0]]);v=mat([[3],[0],[1]])
assert scale(F(1,2),add(R,L))==sub(add(scale(F(1,8),diag(1,1,1)),scale(F(1,10),mul(u,T(u)))),scale(F(1,8),diag(0,0,1)))
assert scale(F(1,2),add(R2,L))==sub(add(scale(F(1,8),diag(1,1,1)),scale(F(1,10),mul(v,T(v)))),scale(F(1,8),diag(0,1,0)))
assert F(2)<F(9,4)
print('MI-06: all six PSD square-root tables, two rank-one decompositions and exact rational gap PASS')
P=diag(1,0);B=mat([[0,'5/12'],[0,0]]);Q=mat([['144/169','60/169'],['60/169','25/169']]);I=diag(1,1);X=add(P,B)
assert mul(P,P)==P and mul(Q,Q)==Q;psd(P);psd(Q);assert det(add(P,Q))==F(25,169)>0
for X0,Y in [(P,P),(T(P),P),(B,scale(F(5,12),sub(I,P))),(T(B),scale(F(5,12),P)),(X,scale(F(13,12),Q)),(T(X),scale(F(13,12),P))]:assert mul(Y,Y)==mul(T(X0),X0);psd(Y)
assert F(13,6)-F(11,6)==F(1,3)>0
print('MI-07: all six PSD square-root tables, projection identities, positive determinant and trace gap PASS; no convergence computation claimed')
Q=mat([['9/25','12/25'],['12/25','16/25']]);psd(Q);assert mul(Q,Q)==Q
X=add(P,Q);R=mat([['-18/25','-12/25'],['-12/25',0]]);w=mat([[1],[-2]])
assert sub(X,mul(X,X))==R;assert mul(T(w),mul(R,w))==[[F(6,5)]]
print('MI-26: source projection, actual quadratic polynomial matrix and 6/5 quadratic value PASS')
p=next(p for p in ps if p['id']=='NR-03');path='references/holden-nr03-2026-09-13/data/factors_n7.json';raw=subprocess.check_output(['git','show',p['base']+':'+path],cwd=p['root']);assert hashlib.sha256(raw).hexdigest()=='fa515775f9c77e5dfe85109125d3f730c4b36684894730096247cd67fcc60bb9';c=json.loads(raw);W,V,d=c['W'],c['H_scaled'],c['denominators']
assert c['n']==7 and c['r']==127 and len(W)==128 and all(len(x)==127 for x in W) and len(V)==127 and all(len(x)==128 for x in V)
assert len(d)==128 and all(type(x)is int and x>0 for x in d) and all(type(x)is int and x>=0 for row in W+V for x in row)
for a in range(128):
 for b in range(128):assert sum(W[a][k]*V[k][b]for k in range(127))==d[b]*(1-bin(a&b).count('1'))**2
print('NR-03: source JSON digest, full 128-by-127-by-128 integer factors, every positive denominator and all 16384 entry identities PASS')
print('RA-09: exact symbolic SOS manually expanded: (2d+2)z^2-(2d+1)z+d; unbounded analytic/matrix obligations remain Lean proof obligations')
