from fractions import Fraction as F
import json

def add(p,q):
 r=[F(0)]*max(len(p),len(q))
 for i,a in enumerate(p):r[i]+=a
 for i,a in enumerate(q):r[i]+=a
 return r

def scale(c,p):return [c*a for a in p]
def mul(p,q):
 r=[F(0)]*(len(p)+len(q)-1)
 for i,a in enumerate(p):
  for j,b in enumerate(q):r[i+j]+=a*b
 return r

def powp(p,n):
 r=[F(1)]
 for _ in range(n):r=mul(r,p)
 return r

def comp(p,q):
 r=[F(0)]
 for a in reversed(p):r=add(mul(r,q),[a])
 return r

def trim(p):
 while len(p)>1 and p[-1]==0:p.pop()
 return p
lhs=add(scale(27,mul(powp([1,1],2),powp([1,0,1],2))),scale(-16,powp([1,1,1],3)))
rhs=mul(powp([1,-1],2),[11,28,30,28,11]);assert lhs==rhs
# Literal two-stage list recurrence must give q2(q1(x)).
q1=[0,F(2),0,F(-1)];q2=[0,F(-3),0,F(2)]
recurrence=comp(comp([0,1],q2),q1);direct=add(scale(-3,q1),scale(2,powp(q1,3)))
assert trim(recurrence)==trim(direct) and trim(recurrence)!=trim(comp(q1,q2))
# Endpoint rational identities are exact. Finite checks are diagnostics only.
for d in [F(1,100),F(1,7),F(1,2),F(99,100)]:
 r=(1-d)/(1+d); assert 0<r<1 and r*r<r<1-d
 v=2*d/(1+d*d); assert (1-v)/(1+v)==r*r
for m in range(2,101):assert F(m//2)>=F(m+1,4) and 2*(m//2)<=m
print(json.dumps({'verdict':'PASS','exact_polynomial_identity_coefficients':[str(x) for x in lhs],'composition_order':'q2 after q1 confirmed, reverse differs','rational_gaps_tested':4,'integer_endpoint_budgets_tested':99,'limits':'Finite diagnostics and exact polynomial identity only; no universal approximation or stage bound proof claimed.'},indent=2))
