from fractions import Fraction as F
from itertools import permutations,product
from pathlib import Path
import json,hashlib,shutil,re
entries=json.load(open('/private/tmp/nla-sixth-five/projects.json'))
def prod(xs):
 r=F(1)
 for x in xs:r*=x
 return r
def mat(rows):return [[F(x) for x in row] for row in rows]
def trans(A):return list(map(list,zip(*A)))
def scale(A,c):return [[c*x for x in row] for row in A]
def mul(A,B):return [[sum(a*b for a,b in zip(row,col)) for col in trans(B)] for row in A]
def eye(n):return mat([[i==j for j in range(n)] for i in range(n)])
def diag(xs):return mat([[x if i==j else 0 for j in range(len(xs))] for i,x in enumerate(xs)])
def power(A,k):
 R=eye(len(A))
 for _ in range(k):R=mul(R,A)
 return R
def det(A):return sum((-1)**sum(s[i]>s[j] for i in range(len(s)) for j in range(i+1,len(s)))*prod(A[i][s[i]] for i in range(len(s))) for s in permutations(range(len(A))))
def fsq(A):return sum(x*x for row in A for x in row)
# Independently written sparse polynomial arithmetic, exact rational coefficients.
class P:
 def __init__(self,v=0):self.d=v if isinstance(v,dict) else {(0,)*9:F(v)}
 def __add__(a,b):
  b=b if isinstance(b,P) else P(b);d=a.d.copy()
  for k,v in b.d.items():d[k]=d.get(k,0)+v
  return P({k:v for k,v in d.items() if v})
 __radd__=__add__
 def __neg__(a):return P({k:-v for k,v in a.d.items()})
 def __sub__(a,b):return a+-P(b) if not isinstance(b,P) else a+-b
 def __rsub__(a,b):return P(b)+-a
 def __mul__(a,b):
  b=b if isinstance(b,P) else P(b);d={}
  for i,x in a.d.items():
   for j,y in b.d.items():k=tuple(u+v for u,v in zip(i,j));d[k]=d.get(k,0)+x*y
  return P({k:v for k,v in d.items() if v})
 __rmul__=__mul__
 def __pow__(a,n):
  r=P(1)
  for _ in range(n):r=r*a
  return r
 def diff(a,j):return P({tuple(v-(i==j) for i,v in enumerate(k)):c*k[j] for k,c in a.d.items() if k[j]})
 def eq(a,b):return not (a-b).d
 def enc(a):return {','.join(map(str,k)):str(v) for k,v in a.d.items()}
x=[P({tuple(int(i==j) for i in range(9)):F(1)}) for j in range(9)]
checks={}
# IE23 exact all-complex identities via real/imaginary polynomial coordinates.
A=mat([[1,1,0],[1,0,1]]);B=scale(mat([[1,1],[2,-1],[-1,2]]),F(1,3));X=mat([[0,0],[1,0],[0,1]]);G=mul(A,trans(A));Gi=scale(mat([[2,-1],[-1,2]]),F(1,3))
assert G==mat([[2,1],[1,2]]) and det(G)==3 and mul(G,Gi)==eye(2) and mul(Gi,G)==eye(2)
assert mul(trans(A),Gi)==B and mul(A,B)==mul(A,X)==eye(2) and B!=X and mul(trans(B),B)==Gi and mul(trans(X),X)==eye(2)
def norm2(z):return sum(v*v for v in z)
u,v=x[:2];assert ((u*u+v*v)**2+(u*u-v*v)**2).eq(2*(u**4+v**4))
u,ui,v,vi=x[:4];byre=[(u+v)*F(1,3),(2*u-v)*F(1,3),(-u+2*v)*F(1,3)];byim=[(ui+vi)*F(1,3),(2*ui-vi)*F(1,3),(-ui+2*vi)*F(1,3)]
assert (norm2(byre)+norm2(byim)+((u+v)**2+(ui+vi)**2)*F(1,3)).eq(u*u+ui*ui+v*v+vi*vi)
t,ti=x[:2];assert (t*t+ti*ti+(1-t)**2+ti*ti+(-1-t)**2+ti*ti).eq(2+3*(t*t+ti*ti))
z=[[F(1)],[F(-1)]];assert mul(B,z)==mul(X,z)==[[F(0)],[F(1)],[F(-1)]]
checks['IE-23']={'matrix_certificates':True,'Gram':G,'Gram_inverse':Gi,'rank_two_minor':det([A[0][:2],A[1][:2]]),'complex_action_polynomial_identity':True,'every_competitor_norm_polynomial_identity':True,'norm_comparison_SOS_identity':True,'attaining_actions':mul(B,z),'limitation':'Real roots/powers, all-vector bounds, generic bounded actual suprema and full complex competitor quantifiers remain Lean obligations.'}
# MI22 adapted rational witness, nearest rounding checked against original TeX values.
D=diag([16,F(1,16),1]);A=power(D,2);T=scale(mat([[4616,-39,-1250],[-39,55069,-1519],[-1250,-1519,6499]]),F(1,8192));L=mat([[1,0,0],[F(-39,4616),1,0],[F(-625,2308),F(-7060454,254196983),1]]);piv=diag([F(577,1024),F(254196983,37814272),F(1555181999141,2082381684736)])
assert mul(mul(L,piv),trans(L))==T and det(L)==1 and all(piv[i][i]>0 for i in range(3))
B=mul(mul(D,power(T,8)),D);N=mul(mul(mul(diag([32,F(1,32),1]),T),D),B);AB=mul(A,B);v=[[F(0)],[F(4,5)],[F(-3,5)]];value=mul(N,v)[0][0];trace=sum(B[i][i] for i in range(3));assert fsq(v)==1 and trace<4**8 and value>44000 and fsq(AB)<10500**2
source=Path('/private/tmp/nla-reverify-mi22/matrix-inequalities-and-norms/MI-22/solution.tex').read_text();rs=re.search(r'R=10\^\{-15\}\\begin\{pmatrix\}(.*?)\\end\{pmatrix\}',source,re.S)[1];nums=list(map(int,re.findall(r'-?\d+',rs)));assert len(nums)==9
for r,t in zip(nums,sum(T,[])):
 a=F(r,10**15)*8192;nearest=(a+F(1,2)).numerator//(a+F(1,2)).denominator;assert t==F(nearest,8192)
checks['MI-22']={'exact_LDL':True,'rounding_from_original_R':True,'source_tex_sha256':hashlib.sha256(source.encode()).hexdigest(),'T2':power(T,2),'T4':power(T,4),'T8':power(T,8),'adaptedB':B,'N':N,'AB':AB,'trace':trace,'trace_margin':4**8-trace,'test_coordinate':value,'test_margin':value-44000,'frobenius_squared':fsq(AB),'frobenius_margin':10500**2-fsq(AB),'limitation':'Adapted B differs from source integer B; actual CFC roots, norm bridges and singular-value semantics remain Lean obligations.'}
# MI23 source matrix, natural powers, exact positivity and full Frobenius sum.
D=diag([16,F(1,12),1]);T=mat([[2,1,2],[1,25,-10],[2,-10,10]]);L=mat([[1,0,0],[F(1,2),1,0],[1,F(-22,49),1]]);piv=diag([2,F(49,2),F(150,49)]);assert mul(mul(L,piv),trans(L))==T and det(T)==150
A=power(D,2);B=mul(mul(D,power(T,8)),D);G=mul(mul(D,T),D);H=mul(mul(D,power(T,7)),D);GH=mul(G,H);AB=mul(A,B);gap=GH[0][2]**2-fsq(AB)
assert GH[0][2]==F(1260589125202,9) and fsq(AB)==F(2009446159144992718181231562721,107495424) and gap==F(99434824489435745411095588895,107495424)>0
checks['MI-23']={'exact_LDL':True,'T_leading_minors':[T[0][0],det([r[:2] for r in T[:2]]),det(T)],'B':B,'G':G,'H':H,'GH':GH,'AB':AB,'entry_02':GH[0][2],'frobenius_squared':fsq(AB),'squared_gap':gap,'limitation':'Generic eigenvalue reality/order/multiplicity and CFC/norm identities remain Lean obligations; no numerical spectrum used.'}
# RA20 polynomial determinant and full metric; chart Hessians exact.
a,b,c,alpha,beta,gamma,d0,d1,d2=x
hollow=lambda a,b,c:[[0,a,b],[a,0,c],[b,c,0]]
Q=hollow(a,b,c);detp=2*a*b*c
# independently use Leibniz polynomial determinant
def pd(A):
 r=P(0)
 for s in permutations(range(len(A))):
  q=P((-1)**sum(s[i]>s[j] for i in range(len(s)) for j in range(i+1,len(s))))
  for i in range(len(s)):q=q*A[i][s[i]]
  r=r+q
 return r
assert pd(Q).eq(detp)
U=[[d0,alpha,beta],[alpha,d1,gamma],[beta,gamma,d2]];dist=sum((Q[i][j]-U[i][j])**2 for i in range(3) for j in range(3));assert dist.eq(d0*d0+d1*d1+d2*d2+2*((a-alpha)**2+(b-beta)**2+(c-gamma)**2))
assert all(dist.diff(i).eq(4*(x[i]-x[i+3])) for i in range(3));assert all(dist.diff(i).diff(j).eq(4 if i==j else 0) for i in range(3) for j in range(3))
U=mat([[1,1,2],[1,2,3],[2,3,3]]);cs=[hollow(0,2,3),hollow(1,0,3),hollow(1,2,0)];ds=[sum((Q[i][j]-U[i][j])**2 for i in range(3) for j in range(3)) for Q in cs];assert ds==[16,22,32]
checks['RA-20']={'determinant_polynomial':pd(hollow(a,b,c)).enc(),'gradient_abc':[ (a*b*c).diff(i).enc() for i in range(3)],'full_metric_polynomial_identity':True,'gradient_coefficients':4,'Hessian':'4 I_2 on each of the three plane charts','Hessian_det':16,'example_candidates':cs,'example_distances':ds,'predicted_3_3':4,'actual_candidate_count':3,'limitation':'Reduced whole vanishing ideal, genuine smooth locus/tangents and generic-open intersection/exhaustion/cardinality require universal Lean proof. Optional rational data is not genericity evidence.'}
# IV06 determinant as a polynomial in independent parameters; all corners and eigenpairs.
a,b,lam=x[:3];Q=[[lam-25,-a,-b],[-1,lam+1,0],[-1,0,lam-1]];formula=(lam-25)*(lam*lam-1)-a*(lam-1)-b*(lam+1);assert pd(Q).eq(formula)
def fam(a,b):return mat([[25,a,b],[1,-1,0],[1,0,1]])
data=[(-3,-21,154,[-4,2,1]),(0,-16,9,[-1,-1,1]),(3,-146,29,[4,1,2]),(25,-91,84,[312,12,13])]
for lam,a,b,v in data:
 assert -166<=a<=-16 and 9<=b<=159 and any(v);assert mul(fam(a,b),[[F(t)] for t in v])==[[F(lam*t)] for t in v]
intervals=[]
for lam,wanted in zip([-1,1,12],[(-332,-32),(-318,-18),(-3750,-150)]):
 vals=[det([[F(lam*(i==j))-fam(a,b)[i][j] for j in range(3)] for i in range(3)]) for a,b in product([-166,-16],[9,159])];assert (min(vals),max(vals))==wanted;intervals.append({'lambda':lam,'corners':vals,'min':min(vals),'max':max(vals)})
for i,j in permutations(range(4),2):
 if i<j:assert any(data[i][0]<s<data[j][0] for s in [-1,1,12])
checks['IV-06']={'actual_determinant_polynomial':formula.enc(),'four_admissible_nonzero_eigenpairs':data,'separator_corner_ranges':intervals,'all_six_pairwise_separations':True,'universal_affinity':'Polynomial has no parameter product or higher parameter powers, so endpoint bounds extend over the complete box. This algebraic argument must be proved in Lean.','limitation':'Exact diagnostics do not prove actual connected-component injection/cardinality or generic determinant-eigenvector equivalence.'}
for e in entries:
 audit=Path(e['root'])/'docs/lean/reverification-2026-09-14'/e['id'];out={'verdict':'PASS','independent_diagnostic_not_Lean_proof':True,**checks[e['id']]};(audit/'referee-2-numerical-checks.json').write_text(json.dumps(out,default=str,indent=2)+'\n');shutil.copy2(__file__,audit/'referee2_numerics.py');(audit/'referee-2-numerical.log').write_text(e['id']+' independent exact reconstruction PASS\n');print(e['id'],'PASS')
