"""Independent statement diagnostics; exact arithmetic, not Lean proof evidence."""
from fractions import Fraction as F
from itertools import permutations,combinations,product
from math import prod,factorial
import json,sys
Q=lambda A:[[F(x) for x in r] for r in A]
I=lambda n:[[F(i==j) for j in range(n)] for i in range(n)]
def add(A,B):return [[a+b for a,b in zip(r,s)] for r,s in zip(A,B)]
def scale(c,A):return [[c*a for a in r] for r in A]
def mul(A,B):return [[sum(a*b for a,b in zip(r,c)) for c in zip(*B)] for r in A]
def power(A,n):
 B=I(len(A))
 for _ in range(n):B=mul(B,A)
 return B
def det(A):
 n=len(A)
 return sum((-1)**sum(s[i]>s[j] for i in range(n) for j in range(i+1,n))*prod(A[i][s[i]] for i in range(n)) for s in permutations(range(n)))
def inv2(A):
 d=det(A);assert d
 return scale(1/d,[[A[1][1],-A[0][1]],[-A[1][0],A[0][0]]])
def pd2(A):return A[0][1]==A[1][0] and A[0][0]>0 and det(A)>0
def pmul(a,b):
 c=[F(0)]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):c[i+j]+=x*y
 return c
def padd(a,b):return [(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))]
def pscale(c,a):return [c*x for x in a]
def pdet(A):
 n=len(A);out=[F(0)]
 for s in permutations(range(n)):
  p=[F((-1)**sum(s[i]>s[j] for i in range(n) for j in range(i+1,n)))]
  for i in range(n):p=pmul(p,A[i][s[i]])
  out=padd(out,p)
 return out
def elementary(xs,j):return sum(prod(xs[i] for i in s) for s in combinations(range(len(xs)),j))
def poly(xs):
 c=[F(1)]
 for x in xs:c=pmul(c,[F(1),x])
 return c
def deriv(c):return [F(i)*c[i] for i in range(1,len(c))] or [F(0)]
def pv(c,j):return c[j] if j<len(c) else F(0)
def check_mi19():
 X=Q([[13,0,13,13],[1,1,-2,1]]);A=mul(list(map(list,zip(*X))),X)
 assert A==Q([[170,1,167,170],[1,1,-2,1],[167,-2,173,167],[170,1,167,170]])
 full=[0]*7;restricted=[0]*7;count=0
 for s in permutations(range(4)):
  inv=sum(s[i]>s[j] for i in range(4) for j in range(i+1,4));term=prod(A[i][s[i]] for i in range(4));full[inv]+=term
  if {s[i] for i in {1}}=={1}:restricted[inv]+=term;count+=1
 assert count==6
 assert full==[4999700,4886140,-199231,4712758,9568969,4886140,115600]
 assert restricted==[4999700,4741130,0,4741130,9482260,4999700,0]
 gap=sum((a-b)*F(7,8)**i for i,(a,b) in enumerate(zip(full,restricted)))
 assert gap==F(-3235575,16384)<0
 assert [a-b for a,b in zip(full,restricted)]==pmul([0,1,1],[145010,-344241,315869,-229160,115600])
 return dict(permutations=24,setwise_preserving=count,full_coefficients=full,restricted_coefficients=restricted,gap=gap,gram_identity=True)
def check_mi21():
 C=Q([[F(12,37),0],[0,F(21,29)]]);E=Q([[F(35,37),0],[0,F(20,29)]]);S=scale(F(1,17),Q([[15,8],[8,-15]]));D=mul(mul(S,E),S);D2=mul(mul(S,C),S)
 assert pd2(C) and pd2(E) and pd2(D) and pd2(D2)
 assert power(S,2)==I(2) and add(power(C,2),power(E,2))==I(2)
 means=[];records=[]
 for X,Y,delta in [(C,D,F(5,3)),(E,D2,F(3,5))]:
  assert delta**2==det(Y)/det(X)
  V=add(Y,scale(delta,X));h=sum(mul(inv2(X),Y)[i][i] for i in range(2))+2*delta
  assert h>0 and pd2(V)
  assert mul(mul(V,inv2(X)),V)==scale(h,Y)
  means.append(scale(1/h,power(V,2)));records.append(dict(delta=delta,h=h,V=V,riccati=True))
 assert records[0]['h']==F(61697295,8682716)
 assert records[0]['V']==scale(F(1,310097),Q([[443355,33000],[33000,605715]]))
 assert means[0]==scale(F(1,12158163),Q([[3516940,616000],[616000,6547660]]))
 assert means[1]==mul(mul(S,means[0]),S)
 L=add(*means);assert L==scale(F(1,12158163),Q([[8216600,-985600],[-985600,11912600]]))
 lam=F(1351000,1350907);w=Q([[1],[-4]])
 assert mul(L,w)==scale(lam,w) and lam-1==F(93,1350907)>0
 return dict(two_independent_Riccati_certificates=records,left=L,eigenvalue=lam,strict_gap=lam-1,scalar_square_roots_cancel_only_after_analytic_bridge=True)
def check_mi29():
 A=Q([[2,0,0],[0,1,0],[0,0,F(1,2)]]);M=Q([[-1,2,0],[2,1,2],[0,2,1]]);B=scale(F(1,5),M)
 assert det(B)==F(-1,125) and B[0][0]<0<B[1][1]
 D=power(A,6);H=power(mul(mul(M,power(A,2)),M),4);J=power(mul(mul(A,power(M,2)),A),4)
 z=F(1,5**8);left=det(add(D,scale(z,H)));right=det(add(D,scale(z,J)))
 assert left==F(136990346414301954149,61035156250000000000)
 assert right==F(4537743716162890657,1907348632812500000)
 assert right-left==F(21036678407451,156250000000000)>0
 assert det(H)==det(J)
 dpoly=padd(pdet([[[D[i][j],J[i][j]] for j in range(3)] for i in range(3)]),pscale(-1,pdet([[[D[i][j],H[i][j]] for j in range(3)] for i in range(3)])))
 assert dpoly==[0,F(2089017,16),F(-31188746592549,1024),0]
 return dict(det_B=det(B),left=left,right=right,gap=right-left,polynomial_gap=dpoly,modulus_order_preserved=True)
def frob(A):return sum(x*x for r in A for x in r)
def transition(A,p):
 z=all(x==0 for r in A for x in r)
 if p is None:return F(z),scale(0,A)
 i,j=p
 if z:return F(0),A
 w=A[i][j]**2/frob(A)
 if A[i][j]==0:return w,A
 return w,[[A[a][b]-A[a][j]*A[i][b]/A[i][j] for b in range(len(A[0]))] for a in range(len(A))]
def histories(A,k):
 if k==0:return [(F(1),A)]
 out=[]
 for p in [None]+list(product(range(len(A)),range(len(A[0])))):
  w,B=transition(A,p)
  for v,C in histories(B,k-1):out.append((w*v,C))
 return out
def check_ra03():
 A=Q([[2,1],[1,2]]);assert frob(A)==10
 gram=mul(list(map(list,zip(*A))),A);assert gram==Q([[5,4],[4,5]])
 assert pdet([[[gram[i][j],-F(i==j)] for j in range(2)] for i in range(2)])==[9,-10,1]
 assert [sum(c*x**i for i,c in enumerate([9,-10,1])) for x in [9,1]]==[0,0]
 rows=[]
 for ij in product(range(2),repeat=2):
  w,B=transition(A,ij);i,j=ij
  assert w==([[F(2,5),F(1,10)],[F(1,10),F(2,5)]][i][j])
  assert frob(B)==([[F(9,4),F(9)],[F(9),F(9,4)]][i][j]);rows.append(dict(pivot=ij,mass=w,residual=B,error=frob(B)))
 expectation=sum(w*frob(B) for w,B in histories(A,1));assert expectation==F(18,5)>2
 cases=[A,Q([[0,0],[0,0]]),Q([[1,2],[2,4]]),Q([[0,1,0],[0,0,2]])]
 norms=[]
 for C in cases:
  for k in range(4):
   hs=histories(C,k);assert all(w>=0 for w,_ in hs) and sum(w for w,_ in hs)==1
   norms.append(dict(input=C,k=k,mass=sum(w for w,_ in hs),error=sum(w*frob(B) for w,B in hs)))
 assert sum(w*frob(B) for w,B in histories(A,2))==0
 return dict(pivot_table=rows,gram=gram,gram_characteristic=[9,-10,1],expectation=expectation,tail=1,gap=expectation-2,full_history_diagnostics=norms)
def check_ra07():
 # Exact formal numerator cancellation in Q[s1,s2,s3] using sparse polynomials.
 def plus(a,b):
  out=a.copy()
  for k,v in b.items():out[k]=out.get(k,F(0))+v
  return {k:v for k,v in out.items() if v}
 def sm(c,a):return {k:c*v for k,v in a.items() if c*v}
 def mult(a,b):
  out={}
  for i,x in a.items():
   for j,y in b.items():
    k=tuple(u+v for u,v in zip(i,j));out[k]=out.get(k,F(0))+x*y
  return {k:v for k,v in out.items() if v}
 a={(1,0,0):F(1)};b={(0,1,0):F(1)};c={(0,0,1):F(1)};a2=mult(a,a);u=plus(a2,sm(-1,b));v=plus(plus(mult(a2,a),sm(-3,mult(a,b))),sm(2,c))
 numerator=plus(plus(mult(a2,u),sm(-2,mult(u,u))),mult(a,v));target=sm(2,plus(mult(a,c),sm(-1,mult(b,b))));assert numerator==target
 cases=[]
 for xs0 in [[1,1,1],[1,2,3],[1,1,1,1,1],[F(1,10),2,2,9],[1,2,4,8,16]]:
  xs=list(map(F,xs0));n=len(xs);P=poly(xs);es=[elementary(xs,j) for j in range(n+2)]
  assert es[0]==1 and es[-1]==0 and all(x>0 for x in es[:-1]) and P==es[:-1]
  Fvals=[F(j+1)*es[j+1]/es[j] for j in range(n+1)]
  Q=P
  for d in range(n+1):
   assert Q[0]==factorial(d)*es[d] and len(Q)-1==n-d
   if len(set(xs))==1:assert Q==pscale(Q[0],poly([xs[0]]*(n-d)))
   Q=deriv(Q)
  diffs=[]
  for j in range(2,n):
   Q=P
   for _ in range(j-1):Q=deriv(Q)
   s1=pv(Q,1)/Q[0];q2=2*pv(Q,2)/Q[0];q3=6*pv(Q,3)/Q[0];s2=s1*s1-q2;s3=(q3-s1**3+3*s1*s2)/2;den=s1*(s1*s1-s2)
   dif=Fvals[j-1]-2*Fvals[j]+Fvals[j+1]
   assert den>0 and dif==2*(s1*s3-s2*s2)/den>=0
   if j==n-1:assert len(Q)==3 and q3==0 and Fvals[n]==0
   diffs.append(dict(index=j,derivative_order=j-1,degree=len(Q)-1,gap=dif,denominator=den))
  cases.append(dict(tuple=xs,second_differences=diffs))
 for mu in [[F(1),F(1)],[F(1),F(2)],[F(1,3),F(2),F(9)],[F(3)]*4]:
  sums={r:sum(x**r for x in mu) for r in [1,2,3]};pair=sum(x*y*(x-y)**2 for x,y in combinations(mu,2))
  assert sums[1]*sums[3]-sums[2]**2==pair>=0
  assert sums[1]**2-sums[2]==2*sum(x*y for x,y in combinations(mu,2))>0
 return dict(symbolic_cleared_numerator={str(k):v for k,v in numerator.items()},endpoint_and_repeated_root_diagnostics=cases,scope='Exact symbolic identity plus bounded diagnostics; no universal root-factorization proof claimed.')
checks={'MI-19':check_mi19,'MI-21':check_mi21,'MI-29':check_mi29,'RA-03':check_ra03,'RA-07':check_ra07}
id=sys.argv[1];print(json.dumps({'id':id,'verdict':'PASS','method':'Independent Python exact Fraction arithmetic; not a Lean proof','checks':checks[id]()},indent=2,default=str))
