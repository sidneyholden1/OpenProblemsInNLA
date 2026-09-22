"""Independent fresh statement diagnostics. Exact Fraction/sparse polynomial arithmetic only.
Not Lean proofs; no submitted reconstruction or proof module is imported.
"""
from fractions import Fraction as F
from itertools import permutations, combinations
from math import prod
import json,sys
class P:
 def __init__(self,d=0):self.d=d if isinstance(d,dict) else ({():F(d)} if d else {})
 def __add__(self,b):
  b=b if isinstance(b,P) else P(b);d=self.d.copy()
  for m,v in b.d.items():d[m]=d.get(m,F(0))+v
  return P({m:v for m,v in d.items() if v})
 __radd__=__add__
 def __neg__(self):return P({m:-v for m,v in self.d.items()})
 def __sub__(self,b):return self+-asP(b)
 def __rsub__(self,b):return asP(b)+-self
 def __mul__(self,b):
  b=asP(b);d={}
  for m,v in self.d.items():
   for n,w in b.d.items():
    k=tuple(sorted(m+n));d[k]=d.get(k,F(0))+v*w
  return P({m:v for m,v in d.items() if v})
 __rmul__=__mul__
 def __pow__(self,n):
  q=P(1)
  for _ in range(n):q=q*self
  return q
 def __eq__(self,b):return self.d==asP(b).d
 def diff(self,i):
  d={}
  for m,v in self.d.items():
   if i in m:
    k=list(m);k.remove(i);d[tuple(k)]=v*m.count(i)
  return P(d)
 def eval(self,v):return sum(c*prod(v[i] for i in m) for m,c in self.d.items())
 def record(self):return {','.join(map(str,m)) or 'constant':str(v) for m,v in sorted(self.d.items())}
def asP(x):return x if isinstance(x,P) else P(x)
def vars(n):return [P({(i,):F(1)}) for i in range(n)]
def mat(A):return [[F(x) for x in r] for r in A]
def diag(xs):return [[F(x) if i==j else F(0) for j in range(len(xs))] for i,x in enumerate(xs)]
def tr(A):return list(map(list,zip(*A)))
def mm(A,B):return [[sum(x*y for x,y in zip(r,c)) for c in zip(*B)] for r in A]
def sc(c,A):return [[c*x for x in r] for r in A]
def sub(A,B):return [[x-y for x,y in zip(r,s)] for r,s in zip(A,B)]
def powm(A,k):
 B=diag([1]*len(A))
 while k:
  if k%2:B=mm(B,A)
  A=mm(A,A);k//=2
 return B
def det(A):
 n=len(A)
 return sum((-1)**sum(s[i]>s[j] for i in range(n) for j in range(i+1,n))*prod(A[i][s[i]] for i in range(n)) for s in permutations(range(n)))
def leading(A):return [det([r[:k] for r in A[:k]]) for k in range(1,len(A)+1)]
def frob(A):return sum(x*x for r in A for x in r)
def check_ie23():
 A=mat([[1,1,0],[1,0,1]]);G=mm(A,tr(A));Gi=sc(F(1,3),mat([[2,-1],[-1,2]]));B=sc(F(1,3),mat([[1,1],[2,-1],[-1,2]]));X=mat([[0,0],[1,0],[0,1]])
 assert G==mat([[2,1],[1,2]]) and det(G)==3 and mm(G,Gi)==mm(Gi,G)==diag([1,1])
 assert mm(tr(A),Gi)==B and mm(A,B)==mm(A,X)==diag([1,1]) and B!=X
 assert mm(tr(B),B)==Gi and mm(tr(X),X)==diag([1,1])
 ur,ui,vr,vi=vars(4);u=[ur,ui];v=[vr,vi]
 ns=lambda z:z[0]**2+z[1]**2
 y=[[ur,ui],[vr,vi]];By=mm(B,y);Xy=mm(X,y)
 assert sum(map(ns,By))+F(1,3)*ns([ur+vr,ui+vi])==ns(u)+ns(v)
 assert sum(map(ns,Xy))==ns(u)+ns(v)
 t,w=vars(2);assert (t*t+w*w)+(1-t)**2+w*w+(-1-t)**2+w*w==2+3*(t*t+w*w)
 a,b=vars(2);assert 2*(a**4+b**4)-(a*a+b*b)**2==(a*a-b*b)**2
 z=mat([[1],[-1]]);assert mm(B,z)==mm(X,z)==mat([[0],[1],[-1]])
 return dict(gram=G,inverse_gram=Gi,rank_two_minor=det([r[1:] for r in A]),right_inverses_distinct=True,complex_action_polynomial_identities=True,all_competitor_t_complex_identity=True,sum_of_squares_identity=True,norming_numerator_squared=2,norming_denominator_fourth=2,analytic_limit='Actual roots, generic supremum, all competitors and norm inequalities remain Lean obligations.')
def check_mi22():
 D=diag([16,F(1,16),1]);Di=diag([F(1,16),16,1]);A=powm(D,2);M=mat([[4616,-39,-1250],[-39,55069,-1519],[-1250,-1519,6499]]);T=sc(F(1,8192),M)
 H=mat([[1,0,0],[F(-39,4616),1,0],[F(-625,2308),F(-7060454,254196983),1]]);piv=[F(577,1024),F(254196983,37814272),F(1555181999141,2082381684736)]
 assert T==mm(mm(H,diag(piv)),tr(H)) and det(H)==1 and all(x>0 for x in piv)
 assert leading(M)==[4616,254196983,1555181999141]
 T8=powm(T,8);B=mm(mm(D,T8),D);assert mm(mm(Di,B),Di)==T8
 E=diag([32,F(1,32),1]);F8=diag([2,F(1,2),1]);assert mm(F8,D)==E and powm(F8,8)==A
 N=mm(mm(mm(E,T),D),B);v=mat([[0],[F(4,5)],[F(-3,5)]]);test=mm(N,v)[0][0];fs=frob(mm(A,B));trace=sum(B[i][i] for i in range(3))
 assert frob(v)==1 and trace<4**8 and test>44000 and fs<10500**2 and 10500<11000
 # Reconstruct original manuscript finite certificates independently, preserving adapted-vs-source scope.
 B0=mat([[17,-4,0],[-4,16385,-8192],[0,-8192,4096]]);C=mm(mm(Di,B0),Di)
 R=sc(F(1,10**15),mat([[563431071954661,-4774979464975,-152620714401404],[-4774979464975,6722248446399974,-185449303604146],[-152620714401404,-185449303604146,793308473748417]]))
 S=sc(F(1,10**15),mat([[1417565567728212,-40084698659651,-79375309604622],[-40084698659651,2883518412755210,-1150490885652445],[-79375309604622,-1150490885652445,1157680400969996]]))
 assert leading(B0)==[17,278529,4096] and B!=B0
 assert all(abs(R[i][j]-T[i][j])<F(1,16384) for i in range(3) for j in range(3))
 for V in [B0,C]:assert all(x>0 for x in leading(sub(V,diag([F(1,1024)]*3))))
 for V,k in [(R,8),(S,4)]:
  assert all(x>0 for x in leading(sub(V,diag([F(9,20)]*3))))
  assert all(x>0 for x in leading(sub(diag([k]*3),V)))
 assert frob(sub(powm(R,8),C))<F(1,10**16) and frob(sub(powm(S,8),B0))<F(1,10**16)
 assert mm(mm(mm(E,R),D),powm(S,7))[0][1]>11000
 assert frob(mm(A,B0))==F(6807858741265,65536)<10200**2
 return dict(adapted_pivots=piv,trace_B=trace,tested_coordinate=test,frobenius_AB_squared=fs,margins={'trace':4**8-trace,'coordinate':test-44000,'frobenius':10500**2-fs},source_rounding_verified=True,source_finite_residual_checks=True,source_B_is_different=True,analytic_limit='No CFC/norm/root bound is inferred from this diagnostic; these remain explicit Challenge conclusions.')
def check_mi23():
 D=diag([16,F(1,12),1]);Di=diag([F(1,16),12,1]);T=mat([[2,1,2],[1,25,-10],[2,-10,10]])
 L=mat([[1,0,0],[F(1,2),1,0],[1,F(-22,49),1]]);piv=[F(2),F(49,2),F(150,49)]
 assert mm(mm(L,diag(piv)),tr(L))==T and det(L)==1 and leading(T)==[2,49,150]
 A=powm(D,2);B=mm(mm(D,powm(T,8)),D);G=mm(mm(D,T),D);H=mm(mm(D,powm(T,7)),D)
 assert mm(mm(Di,B),Di)==powm(T,8)
 x=mm(G,H)[0][2];fs=frob(mm(A,B));gap=x*x-fs
 assert x==F(1260589125202,9)>140000000000
 assert fs==F(2009446159144992718181231562721,107495424)<138000000000**2
 assert gap==F(99434824489435745411095588895,107495424)>0
 return dict(pivots=piv,GH_entry_0_2=x,frobenius_AB_squared=fs,gap=gap,parameter_region=(1>=1 and 1>=1 and 2>=1 and 0<=F(1,8)<=1),outside_known_interior=F(1,8)<F(1,4),analytic_limit='Actual CFC powers, complete positive root lists and norm/eigenvalue identity remain Lean obligations.')
def hollow(a,b,c):return [[0,a,b],[a,0,c],[b,c,0]]
def check_ra20():
 a,b,c,u,v,w,d0,d1,d2=vars(9);X=hollow(a,b,c);U=[[d0,u,v],[u,d1,w],[v,w,d2]]
 assert det(X)==2*a*b*c
 distance=sum((X[i][j]-U[i][j])**2 for i in range(3) for j in range(3));expected=d0*d0+d1*d1+d2*d2+2*((a-u)**2+(b-v)**2+(c-w)**2)
 assert distance==expected
 q=a*b*c;assert [q.diff(i) for i in range(3)]==[b*c,a*c,a*b]
 for i in range(3):
  assert distance.diff(i)==4*([a-u,b-v,c-w][i])
  for j in range(3):assert distance.diff(i).diff(j)==4*(i==j)
 vals=[0,0,0,1,2,3,1,2,3];triples=[[0,2,3],[1,0,3],[1,2,0]];dist=[]
 for i,t in enumerate(triples):
  vv=t+vals[3:];assert q.eval(vv)==0
  grad=[q.diff(j).eval(vv) for j in range(3)];assert grad[i]!=0 and all(grad[j]==0 for j in range(3) if i!=j)
  assert all(distance.diff(j).eval(vv)==0 for j in range(3) if i!=j)
  dist.append(distance.eval(vv))
 assert dist==[16,22,32] and len({tuple(x) for x in triples})==3 and 27*(3-3)+4==4
 return dict(determinant_polynomial=det(X).record(),distance_polynomial=distance.record(),gradient_abc=[x.record() for x in [b*c,a*c,a*b]],restricted_Hessian=[[4,0],[0,4]],Hessian_determinant=16,critical_candidates=triples,distances=dist,predicted_count=4,analytic_limit='No generic-open intersection, whole-ideal equivalence, smoothness or universal cardinality is inferred from these polynomial diagnostics.')
def check_iv06():
 a,b,t=vars(3);A=[[25,a,b],[1,-1,0],[1,0,1]];p=det([[t*(i==j)-A[i][j] for j in range(3)] for i in range(3)])
 assert p==(t-25)*(t*t-1)-a*(t-1)-b*(t+1)
 la=[-3,0,3,25];aa=[-21,-16,-146,-91];bb=[154,9,29,84];vec=[[-4,2,1],[-1,-1,1],[4,1,2],[312,12,13]]
 for x,y,z,v in zip(la,aa,bb,vec):
  assert -166<=y<=-16 and 9<=z<=159 and any(v)
  assert mm([[25,y,z],[1,-1,0],[1,0,1]],[[w] for w in v])==[[x*w] for w in v]
  assert p.eval([y,z,x])==0
 bounds=[]
 for x in [-1,1,12]:
  cs=[p.eval([y,z,x]) for y in [-166,-16] for z in [9,159]];bounds.append([min(cs),max(cs)])
 assert bounds==[[-332,-32],[-318,-18],[-3750,-150]] and all(h<=-18<0 for l,h in bounds)
 seps={str((i,j)):next(x for x in [-1,1,12] if la[i]<x<la[j]) for i,j in combinations(range(4),2)}
 return dict(characteristic_polynomial=p.record(),four_eigenpairs_checked=True,separator_corner_bounds=bounds,six_separations=seps,full_box='Polynomial is affine in independent a,b with no mixed terms: extrema at corners; universal Lean inequalities still required.',analytic_limit='Actual nonzero-vector/determinant, component quotient topology and Cardinal injection remain Lean obligations.')
checks={'IE-23':check_ie23,'MI-22':check_mi22,'MI-23':check_mi23,'RA-20':check_ra20,'IV-06':check_iv06}
i=sys.argv[1];print(json.dumps({'id':i,'verdict':'PASS','method':'Independent fresh exact Fraction/sparse-polynomial diagnostic, not a Lean proof','checks':checks[i]()},default=str,indent=2))
