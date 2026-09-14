"""Independent exact diagnostics from reviewed statements; not a Lean proof."""
from fractions import Fraction as Q
from itertools import product, permutations
import json,sys,math

def matmul(A,B):return [[sum((a*b for a,b in zip(row,col)),Q(0)) for col in zip(*B)] for row in A]
def eye(n):return [[Q(i==j) for j in range(n)] for i in range(n)]
def power(A,k):
 R=eye(len(A))
 for _ in range(k):R=matmul(R,A)
 return R
def det(A):
 if len(A)==1:return A[0][0]
 return sum(((-1)**j*A[0][j]*det([r[:j]+r[j+1:] for r in A[1:]]) for j in range(len(A))),Q(0))
def emit(x):print(json.dumps(x,indent=2,default=str))
def fr12():
 def had(A):return matmul(A,list(zip(*A)))==[[len(A)*(i==j) for j in range(len(A))] for i in range(len(A))]
 out={}
 for m in [1,2]:
  mats=[tuple(tuple(t[i*m:(i+1)*m]) for i in range(m)) for t in product([-1,1],repeat=m*m) if had([t[i*m:(i+1)*m] for i in range(m)])]
  seen=set();count=0
  for A,B,s in product(mats,mats,list(permutations(range(m)))):
   C=tuple(tuple(A[i]+B[i]) for i in range(m))+tuple(tuple(A[s[i]]+tuple(-b for b in B[s[i]])) for i in range(m))
   assert had(C) and C not in seen;seen.add(C);count+=1
  assert count==math.factorial(m)*len(mats)**2
  out[str(m)]={'all_input_Hadamards':len(mats),'actual_distinct_outputs':count,'all_Gram_checks':True,'injection_complete_small_domain':True}
 for r in range(1,31):assert math.factorial(2*r)>=r**r
 out['limit']='Only m=1,2 diagnostic injection and 30 factorial checks; universal asymptotic assertion requires proof.';emit(out)
def ie18():
 mu=list(map(Q,['1/10','1/2','3/5']));x=list(map(Q,[1,1,1]));a=[1-z for z in mu]
 def step(v):
  den=sum((z*w)**2 for z,w in zip(a,v));alpha=sum(z*w*w for z,w in zip(a,v))/den
  return den,alpha,[m*(w-alpha*z*w) for m,z,w in zip(mu,a,v)]
 d,c,y=step(x);d2,c2,z=step(y);ratio=sum(w*w for w in z)/3
 pairs={(i,j):(mu[i]*mu[j]*(mu[j]-mu[i])/(abs(mu[i]*(mu[i]-1))+abs(mu[j]*(mu[j]-1))))**2 for i in range(3) for j in range(3) if i!=j}
 assert (d,c,y)==(Q(61,50),Q(90,61),list(map(Q,['-2/61','8/61','15/61'])))
 assert (d2,c2,z)==(Q(1381,93025),Q(3140,1381),list(map(Q,['289/84241','-756/84241','1125/84241'])))
 assert ratio==Q(1920682,21289638243) and max(pairs.values())==Q(1,121) and ratio>max(pairs.values())**2
 assert all(0<m<1 for m in mu)
 emit({'denominators':[d,d2],'coefficients':[c,c2],'residuals':[y,z],'squared_ratio':ratio,'all_six_ordered_pairs':{str(k):v for k,v in pairs.items()},'squared_gap':ratio-Q(1,14641),'scope':'Exact diagonal witness only; genuine full eigenvalue-list bridge is a Lean obligation.'})
def ie19():
 J=[[Q(2) if i==j else Q(1,2) for j in range(3)] for i in range(3)];S=[[Q(2) if i==j else Q(1) for j in range(3)] for i in range(3)]
 K=[[Q(5,9) if i==j else Q(-1,9) for j in range(3)] for i in range(3)];T=[[Q(3,4) if i==j else Q(-1,4) for j in range(3)] for i in range(3)]
 assert matmul(J,K)==matmul(K,J)==matmul(S,T)==matmul(T,S)==eye(3)
 assert all(0<J[i][j]<=S[i][j] for i in range(3) for j in range(3))
 assert all(sum(J[i][j] for j in range(3) if j!=i)<=J[i][i] for i in range(3))
 norms=[max(sum(abs(x) for x in row) for row in A) for A in [K,T]];assert norms==[Q(7,9),Q(5,4)]
 emit({'determinants':[det(J),det(S)],'row_norms':norms,'gap':norms[1]-norms[0],'both_sided_inverse_identities':True,'all_nine_entry_bounds_and_dominance':True})
def tr15():
 h=[2,0,1,0,2,0,-1];coeffs=[]
 for i in range(3):
  d={}
  for j,k in product(range(3),repeat=2):
   mon=tuple((j==r)+(k==r) for r in range(3));d[mon]=d.get(mon,0)+h[i+j+k]
  coeffs.append({k:v for k,v in d.items() if v})
 assert coeffs==[{(2,0,0):2,(1,0,1):2,(0,2,0):1,(0,0,2):2},{(1,1,0):2,(0,1,1):4},{(2,0,0):1,(1,0,1):4,(0,2,0):2,(0,0,2):-1}]
 upper=[sum(h[i+sum(t)]*math.prod([0,1][j] for j in t) for t in product(range(2),repeat=5)) for i in range(2)];assert upper==[0,-1]
 F=lambda t:2*t**4+2*t**3+3*t**2-4*t-1
 assert (F(0),F(1))==(-1,2)
 # Polynomial third eigen-equation: lhs minus lambda*t^2 is -F.
 third=[sum(v for mon,v in coeffs[2].items() if mon[1]==0 and mon[2]==degree) for degree in range(5)]
 eigen_rhs=[0,0,2,2,2]
 assert [a-b for a,b in zip(third,eigen_rhs)]==[-v for v in [-1,-4,3,2,2]]
 emit({'all_lower_ordered_tuple_coefficients':[{str(k):v for k,v in d.items()} for d in coeffs],'upper_all_32_tuples_per_coordinate':upper,'IVT_endpoints':[F(0),F(1)],'limit':'Exact finite contraction and polynomial checks; universal eigenpair positivity and IVT existence remain proof obligations.'})
class I:
 def __init__(self,a,b=None):self.lo=Q(a);self.hi=Q(a if b is None else b)
 def __add__(self,b):
  b=asI(b);return I(self.lo+b.lo,self.hi+b.hi)
 __radd__=__add__
 def __neg__(self):return I(-self.hi,-self.lo)
 def __sub__(self,b):return self+-asI(b)
 def __rsub__(self,b):return asI(b)+-self
 def __mul__(self,b):
  b=asI(b);v=[x*y for x in [self.lo,self.hi] for y in [b.lo,b.hi]];return I(min(v),max(v))
 __rmul__=__mul__
 def absmax(self):return max(abs(self.lo),abs(self.hi))
def asI(b):return b if isinstance(b,I) else I(b)
class D:
 def __init__(self,v,d=None):self.v=asI(v);self.d=[I(0)]*3 if d is None else d
 def __add__(self,b):
  b=asD(b);return D(self.v+b.v,[a+c for a,c in zip(self.d,b.d)])
 __radd__=__add__
 def __neg__(self):return D(-self.v,[-a for a in self.d])
 def __sub__(self,b):return self+-asD(b)
 def __rsub__(self,b):return asD(b)+-self
 def __mul__(self,b):
  b=asD(b);return D(self.v*b.v,[a*b.v+self.v*c for a,c in zip(self.d,b.d)])
 __rmul__=__mul__
def asD(b):return b if isinstance(b,D) else D(b)
def system(x,y,z):
 s=x+z;t=s*s;u=s*(t*(t*(t*(t*(t-30)+324)-1512)+2835)-1458);v=3*(t*(t*(t*(t*(t-27)+252)-945)+1215)-243)
 a=x+4*y;b=4*x+17*y;c=y+4*z;d=4*y+17*z;aa=a*a;bb=b*b;ac=a*c;bd=b*d
 return [x*z-y*y-3,u*((x*aa+2*(y*(a*b)))+z*bb)-v*(aa+bb)-4783113,u*((x*ac+y*(a*d+b*c))+z*bd)-v*(ac+bd)-6377496]
def mf16():
 B=[[Q(1),Q(4)],[Q(4),Q(17)]];X=[[Q(3),Q(0)],[Q(0),Q(1)]];P=[[Q(4783113),Q(6377496)],[Q(6377496),Q(8503345)]]
 assert matmul(matmul(matmul(matmul(X,B),power(X,12)),B),X)==P
 assert [det(B),det(X),det(P)]==[1,3,3**14]
 m=list(map(Q,['17471725533/5000000000','-51638297/156250000','2224465749/2500000000']));r=Q(1,10**7)
 box=[I(a-r,a+r) for a in m]
 literal=[('17471725033/5000000000','17471726033/5000000000'),('-413106501/1250000000','-413106251/1250000000'),('2224465499/2500000000','2224465999/2500000000')]
 assert all((a.lo,a.hi)==tuple(map(Q,b)) for a,b in zip(box,literal)) and box[0].lo>3
 C=[list(map(Q,row)) for row in [['17591641083/500000000','20183/10000000000','-17029/10000000000'],['-11575092327/500000000','-2477/2000000000','10667/10000000000'],['-21469001731/5000000000','-2797/10000000000','2319/10000000000']]]
 dc=det(C);assert dc==Q(790668616748253,62500000000000000000000000000)
 args=[D(box[i],[I(i==j) for j in range(3)]) for i in range(3)];vals=system(*args);J=[v.d for v in vals]
 A=[[I(i==j)-sum((C[i][k]*J[k][j] for k in range(3)),I(0)) for j in range(3)] for i in range(3)]
 q=max(sum(a.absmax() for a in row) for row in A);assert q<Q(27,1000)
 g=system(*m);disp=[sum(C[i][j]*g[j] for j in range(3)) for i in range(3)];margin=min(r-abs(d)-q*r for d in disp);assert margin>r/2
 # Independently verify Cayley-Hamilton coefficients by recurrence over Q[s].
 def padd(a,b):return [(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(max(len(a),len(b))) ]
 u0=[0];u1=[1]
 for _ in range(1,12):u0,u1=u1,padd([0]+u1,[-3*c for c in u0])
 assert u1==[0,-1458,0,2835,0,-1512,0,324,0,-30,0,1]
 assert [3*c for c in u0]==[-729,0,3645,0,-2835,0,756,0,-81,0,3]
 emit({'source_determinants':[det(B),det(X),det(P)],'exact_source_word_product':True,'coefficient_recurrence_matches':True,'box_radius':r,'preconditioner_det':dc,'whole_box_contraction_exact':q,'whole_box_contraction_decimal_for_orientation':float(q),'center_displacement_max_exact':max(map(abs,disp)),'strict_self_map_minimum_margin_exact':margin,'margin_exceeds_half_radius':True,'limit':'Independent Fraction interval AD and Newton enclosure; no Lean theorem or actual root is inferred by this diagnostic script.'})
{'FR-12':fr12,'IE-18':ie18,'IE-19':ie19,'TR-15':tr15,'MF-16':mf16}[sys.argv[1]]()
