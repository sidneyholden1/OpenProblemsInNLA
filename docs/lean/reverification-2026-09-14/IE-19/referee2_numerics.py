from pathlib import Path
from fractions import Fraction as F
from itertools import product,permutations
from math import factorial
import json
out={}
def mul(a,b):return [[sum(x*y for x,y in zip(r,c)) for c in zip(*b)] for r in a]
def mpow(a,n):
 v=[[int(i==j) for j in range(len(a))] for i in range(len(a))]
 for _ in range(n):v=mul(v,a)
 return v
def det(a):return sum((-1)**sum(p[i]>p[j] for i in range(len(p)) for j in range(i+1,len(p)))*prod(a[i][p[i]] for i in range(len(p))) for p in permutations(range(len(a))))
def prod(xs):
 r=1
 for x in xs:r*=x
 return r
# IE19 exact inverses and every row maximum.
J=[[F(2) if i==j else F(1,2) for j in range(3)] for i in range(3)];S=[[F(2) if i==j else F(1) for j in range(3)] for i in range(3)];K=[[F(5,9) if i==j else F(-1,9) for j in range(3)] for i in range(3)];T=[[F(3,4) if i==j else F(-1,4) for j in range(3)] for i in range(3)];I=mpow(J,0)
assert mul(J,K)==mul(K,J)==mul(S,T)==mul(T,S)==I
assert all(0<J[i][j]<=S[i][j] for i in range(3) for j in range(3));assert all(sum(J[i][j] for j in range(3) if j!=i)<=J[i][i] for i in range(3));assert max(sum(map(abs,r)) for r in K)==F(7,9)<F(5,4)==max(sum(map(abs,r)) for r in T)
out['IE-19']={'det_J':str(det(J)),'det_S':str(det(S)),'both_two_sided_inverse_products':True,'all_entry_and_weak_dominance_assumptions':True,'all_row_sums_K':[str(sum(map(abs,r))) for r in K],'all_row_sums_T':[str(sum(map(abs,r))) for r in T],'strict_gap':str(F(5,4)-F(7,9))}
# IE18 literal two map executions, exact denominators, coefficients and full pair maximum.
mu=[F(1,10),F(1,2),F(3,5)];v=[F(1)]*3
sq=lambda v:sum(x*x for x in v)
def R(v):
 a=[(1-m)*x for m,x in zip(mu,v)];d=sq(a);c=sum(x*y for x,y in zip(v,a))/d;return [m*(x-c*y) for m,x,y in zip(mu,v,a)],d,c
w,d,c=R(v);u,d2,c2=R(w);assert w==[F(-2,61),F(8,61),F(15,61)];assert u==[F(289,84241),F(-756,84241),F(1125,84241)];assert (d,c,d2,c2)==(F(61,50),F(90,61),F(1381,93025),F(3140,1381))
pairs=[(a*b*(b-a)/(abs(a*(a-1))+abs(b*(b-1))))**2 for i,a in enumerate(mu) for j,b in enumerate(mu) if i!=j];ratio=sq(u)/sq(v);assert ratio==F(1920682,21289638243)>max(pairs)**2==F(1,14641)
out['IE-18']={'all_six_ordered_pair_values':list(map(str,pairs)),'pair_maximum':str(max(pairs)),'squared_norm_ratio':str(ratio),'both_denominators_positive':d>0 and d2>0,'first_coefficient':str(c),'second_coefficient':str(c2),'integer_crossproduct':1920682*14641,'strict_squared_gap':str(ratio-max(pairs)**2)}
# FR12 exhaustively enumerate all labeled signs at orders1,2 and actual restricted outputs.
small={}
for m in [1,2]:
 H=[]
 for flat in product([-1,1],repeat=m*m):
  A=[flat[i*m:(i+1)*m] for i in range(m)]
  if mul(A,list(zip(*A)))==[[m*int(i==j) for j in range(m)] for i in range(m)]:H.append(A)
 outputs=set();count=0
 for A in H:
  for B in H:
   for sig in permutations(range(m)):
    C=[tuple(A[i])+tuple(B[i]) for i in range(m)]+[tuple(A[sig[i]])+tuple(-x for x in B[sig[i]]) for i in range(m)];assert mul(C,list(zip(*C)))==[[2*m*int(i==j) for j in range(2*m)] for i in range(2*m)];outputs.add(tuple(C));count+=1
 assert len(outputs)==count==factorial(m)*len(H)**2;small[str(m)]={'H_m':len(H),'restricted_domain_size':count,'distinct_outputs':len(outputs)}
for k in range(10):assert F(2**(k+2)*k*(k+1),8)>=0
out['FR-12']={'complete_small_enumerations':small,'universal_growth':'Not established by these finite diagnostics; symbolic injection/Archimedean proof required.'}
# TR15 exact all-ordered-tuple contraction polynomials, represented by exponent triples.
h=[2,0,1,0,2,0,-1];polys=[]
for i in range(3):
 q={}
 for j,k in product(range(3),repeat=2):
  exp=tuple(int(t==j)+int(t==k) for t in range(3));q[exp]=q.get(exp,0)+h[i+j+k]
 polys.append({e:c for e,c in q.items() if c})
assert polys==[{(2,0,0):2,(0,2,0):1,(1,0,1):2,(0,0,2):2},{(1,1,0):2,(0,1,1):4},{(2,0,0):1,(0,2,0):2,(1,0,1):4,(0,0,2):-1}]
upper=[sum(h[i+sum(js)]*prod(js) for js in product(range(2),repeat=5)) for i in range(2)];assert upper==[0,-1]
poly=lambda t:2*t**4+2*t**3+3*t*t-4*t-1;assert poly(0)==-1 and poly(1)==2
out['TR-15']={'lower_polynomial_coefficients':[{str(e):c for e,c in p.items()} for p in polys],'all_upper_ordered_summands':64,'upper_contraction':upper,'nonvacuity_polynomial_endpoints':[-1,2],'nonvacuity':'IVT still required; no assumed approximate root.'}
# MF16 exact interval forward AD independently rebuilt from displayed polynomial AST.
class Q:
 def __init__(self,a,b=None):self.lo=F(a);self.hi=F(a if b is None else b)
 def __add__(a,b):b=b if isinstance(b,Q) else Q(b);return Q(a.lo+b.lo,a.hi+b.hi)
 __radd__=__add__
 def __neg__(a):return Q(-a.hi,-a.lo)
 def __sub__(a,b):return a+-toQ(b)
 def __rsub__(a,b):return toQ(b)+-a
 def __mul__(a,b):b=toQ(b);xs=[a.lo*b.lo,a.lo*b.hi,a.hi*b.lo,a.hi*b.hi];return Q(min(xs),max(xs))
 __rmul__=__mul__
 def absbound(a):return max(abs(a.lo),abs(a.hi))
def toQ(a):return a if isinstance(a,Q) else Q(a)
class D:
 def __init__(a,v,g=None):a.v=toQ(v);a.g=[Q(0) for _ in range(3)] if g is None else g
 def __add__(a,b):b=toD(b);return D(a.v+b.v,[x+y for x,y in zip(a.g,b.g)])
 __radd__=__add__
 def __neg__(a):return D(-a.v,[-x for x in a.g])
 def __sub__(a,b):return a+-toD(b)
 def __rsub__(a,b):return toD(b)+-a
 def __mul__(a,b):b=toD(b);return D(a.v*b.v,[x*b.v+a.v*y for x,y in zip(a.g,b.g)])
 __rmul__=__mul__
def toD(x):return x if isinstance(x,D) else D(x)
def system(x,y,z):
 s=x+z;t=s*s;u=s*(t*(t*(t*(t*(t-30)+324)-1512)+2835)-1458);v=3*(t*(t*(t*(t*(t-27)+252)-945)+1215)-243);a=x+4*y;b=4*x+17*y;c=y+4*z;d=4*y+17*z
 return [x*z-y*y-3,u*((x*(a*a)+2*(y*(a*b)))+z*(b*b))-v*(a*a+b*b)-4783113,u*((x*(a*c)+y*(a*d+b*c))+z*(b*d))-v*(a*c+b*d)-6377496]
center=[F(17471725533,5000000000),F(-51638297,156250000),F(2224465749,2500000000)];rho=F(1,10000000);box=[Q(c-rho,c+rho) for c in center];C=[[F(17591641083,500000000),F(20183,10000000000),F(-17029,10000000000)], [F(-11575092327,500000000),F(-2477,2000000000),F(10667,10000000000)], [F(-21469001731,5000000000),F(-2797,10000000000),F(2319,10000000000)]]
j=[x.g for x in system(*[D(box[i],[Q(int(i==k)) for k in range(3)]) for i in range(3)])];Bnd=[[Q(int(i==k))-sum(C[i][t]*j[t][k] for t in range(3)) for k in range(3)] for i in range(3)];q=max(sum(x.absbound() for x in row) for row in Bnd);fc=system(*center);disp=[sum(C[i][j]*fc[j] for j in range(3)) for i in range(3)];margins=[rho-abs(d)-q*rho for d in disp];assert det(C)==F(790668616748253,62500000000000000000000000000)!=0;assert q<F(27,1000) and min(margins)>rho/2 and max(map(abs,disp))<F(4,10**11);assert box[0].lo>3
B=[[1,4],[4,17]];X0=[[3,0],[0,1]];P=[[4783113,6377496],[6377496,8503345]];assert mul(mul(mul(mul(X0,B),mpow(X0,12)),B),X0)==P;assert det(B)==1 and det(P)==3**14
out['MF-16']={'rational_preconditioner_det':str(det(C)),'whole_box_contraction':str(q),'contraction_decimal_diagnostic':float(q),'center_displacement':list(map(str,disp)),'strict_inclusion_margins':list(map(str,margins)),'minimum_inclusion_margin_decimal':float(min(margins)),'radius':str(rho),'leading_box_coordinate_above_three':True,'source_word_exact_matrix_equality':True,'source_P_det':det(P),'note':'Independent rational diagnostic only; actual Lean checker evaluation is separately recorded and neither is a kernel proof at statement phase.'}
for p in json.load(open('/private/tmp/nla-fourth-five/projects.json')):
 a=Path(p['root'])/'docs/lean/reverification-2026-09-14'/p['id'];a.mkdir(parents=True,exist_ok=True);(a/'referee-2-numerical-checks.json').write_text(json.dumps(out[p['id']],indent=2)+'\n')
print({k:'PASS' for k in out});print('MF16 q=',float(q),'margin=',float(min(margins)))
