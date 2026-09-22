from fractions import Fraction as F
import json
mul=lambda a,b:[[sum((a[i][k]*b[k][j] for k in range(len(b))),F(0)) for j in range(len(b[0]))]for i in range(len(a))]
def identity(n):return [[F(i==j) for j in range(n)]for i in range(n)]
def power(a,q):
 r=identity(len(a))
 for _ in range(q):r=mul(r,a)
 return r
U=[[F(x) for x in r]for r in [[1,-1,0,1,0,0],[0,0,0,0,0,1]]]
V=[[F(x) for x in r]for r in [[1,0],[0,0],[1,0],[0,0],[0,1],[0,1]]]
P=mul(V,U)
assert mul(U,V)==identity(2) and mul(P,P)==P
checks=[]
for mu in [F(1,2),F(3,4),F(0),F(-2)]:
 A=[[F(x)for x in r]for r in [[1,0,0,0,0,0],[0,F(1,4),F(1,4),0,0,0],[0,0,F(1,4),0,0,0],[0,0,0,mu,mu,0],[0,0,0,0,mu,0],[0,0,0,0,0,1]]]
 for q in range(9):
  assert mul(mul(U,power(A,q)),V)==[[1-q*F(1,4)**q,q*mu**q],[0,1]]
  checks.append([str(mu),q])
print(json.dumps({'verdict':'PASS','exact_rational_compressed_cases':checks,'UV_identity':True,'reset_idempotent':True,'scope':'diagnostics only; universal q and all real exponents require Lean proofs'},indent=2))
