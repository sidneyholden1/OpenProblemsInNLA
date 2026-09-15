"""Finite rational diagnostics only; no universal or probability proof."""
from fractions import Fraction as Q
import json

def matrix(n):
    return [[Q(1) if j==n-1 or i==j else Q(-1,2) if i>j else Q(0) for j in range(n)] for i in range(n)]
def entrymax(a): return max(abs(x) for r in a for x in r)
def step(a,k,r):
    b=[row[:] for row in a]; b[k],b[r]=b[r],b[k]
    n=len(a)
    return [[b[i][j]-b[i][k]/b[k][k]*b[k][j] if i>k and j>k else Q(0) for j in range(n)] for i in range(n)]
def ref(n,k):
    return [
        [Q(0) if i<k or j<k else Q(3,2)**k if j==n-1 else Q(1) if i==j else Q(-1,2) if j<i else Q(0) for j in range(n)] for i in range(n)]
records=[]
for n in range(2,13):
    a=matrix(n); states=[a]; pivots=[]
    for k in range(n):
        assert states[-1]==ref(n,k)
        p=states[-1][k][k];assert p>0
        assert all(abs(states[-1][i][k])<abs(p) for i in range(k+1,n))
        pivots.append(p);states.append(step(states[-1],k,k))
    assert states[-1]==ref(n,n)
    growth=max(map(entrymax,states[:-1]))/entrymax(a)
    c=Q(3,2)**(n-1);radius=Q(1,2**(n*n+n+1));B=2**(n+2);K=n*n*(n*n+n+5)
    assert growth==c and B**(n-1)*radius==Q(1,8) and K<=3*n**4
    assert (radius/16)**(n*n)==Q(1,2**K)
    records.append({'n':n,'growth':str(growth),'radius':str(radius),'K':K,'all_strict_pivots':True,'exact_states':True})
print(json.dumps({'verdict':'PASS','scope':'n=2,...,12 exact unperturbed recurrence and scalar identities only','records':records,'limits':'No whole-box robustness, Gaussian law/null sets, measurable-event bound, asymptotic universal statement, or Lean theorem proved.'},indent=2))
