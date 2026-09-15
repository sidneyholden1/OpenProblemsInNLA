"""Independent rational diagnostics; these are not Lean proofs."""
from fractions import Fraction as Q
import json

def trans(a): return list(map(list, zip(*a)))
def mul(a, b): return [[sum(x*y for x,y in zip(row,col)) for col in zip(*b)] for row in a]
def det(a):
    a = [[Q(x) for x in r] for r in a]
    d = Q(1)
    for i in range(len(a)):
        j = next((j for j in range(i,len(a)) if a[j][i]), None)
        if j is None: return Q(0)
        if j != i: a[i],a[j],d = a[j],a[i],-d
        p = a[i][i]; d *= p
        for j in range(i+1,len(a)):
            t = a[j][i]/p
            a[j] = [x-t*y for x,y in zip(a[j],a[i])]
    return d
def coord(a): return [a[0][0],a[1][1],a[2][2],a[0][1],a[0][2],a[1][2]]
def sym(x): return [[x[0],x[3],x[4]],[x[3],x[1],x[5]],[x[4],x[5],x[2]]]
def gram(a): return [[sum(mul(x,y)[i][i] for i in range(3)) for y in a] for x in a]
f = [[[4,0,0],[0,2,0],[0,0,2]],[[2,0,0],[0,4,0],[0,0,2]],[[2,0,0],[0,2,0],[0,0,4]],[[2,1,0],[1,2,0],[0,0,2]],[[2,0,1],[0,2,0],[1,0,2]],[[2,0,0],[0,2,1],[0,1,2]]]
g = [[r[:] for r in a] for a in f]; g[3][0][1]=g[3][1][0]=-1
m = [[24,20,20,16,16,16],[20,24,20,16,16,16],[20,20,24,16,16,16],[16,16,16,14,12,12],[16,16,16,12,14,12],[16,16,16,12,12,14]]
assert gram(f)==gram(g)==m
assert det(m)==8192 and det(list(map(coord,f)))==32 and det(list(map(coord,g)))==-32
minors = [[det([r[:k] for r in a[:k]]) for k in [1,2,3]] for a in f+g]
assert all(x>0 for row in minors for x in row)
basis = [sym([int(i==j) for j in range(6)]) for i in range(6)]
tests = [[[1,2,3],[0,1,4],[5,6,0]],[[-1,0,0],[0,1,0],[0,0,1]],[[1,2,3],[2,4,6],[0,1,0]]]
checks=[]
for s in tests:
    c = [coord(mul(mul(trans(s),b),s)) for b in basis]
    assert det(c)==det(s)**4
    for a in f+g:
        assert coord(mul(mul(trans(s),a),s))==mul([coord(a)],c)[0]
    checks.append({'S':s,'detS':str(det(s)),'detCongruence':str(det(c))})
print(json.dumps({'verdict':'PASS','detM':str(det(m)),'orientations':['32','-32'],'positive_leading_principal_minors':[[str(x) for x in row] for row in minors],'congruence_samples':checks,'limitation':'Exact finite diagnostics only; universal polynomial identity, PSD, minima and quotient topology remain Lean obligations.'},indent=2))
