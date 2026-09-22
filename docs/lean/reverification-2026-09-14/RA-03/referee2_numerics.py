from fractions import Fraction as F
from itertools import permutations,combinations,product
from math import factorial
from pathlib import Path
import json,shutil
entries=json.load(open('/private/tmp/nla-fifth-five/projects.json'))
def mat(rows):return [[F(x) for x in r] for r in rows]
def eye(n):return [[F(i==j) for j in range(n)] for i in range(n)]
def mul(A,B):return [[sum(A[i][k]*B[k][j] for k in range(len(B))) for j in range(len(B[0]))] for i in range(len(A))]
def add(A,B):return [[a+b for a,b in zip(x,y)] for x,y in zip(A,B)]
def scale(A,c):return [[c*x for x in r] for r in A]
def trans(A):return list(map(list,zip(*A)))
def power(A,k):
 R=eye(len(A))
 for _ in range(k):R=mul(R,A)
 return R
def sign(s):return (-1)**sum(s[i]>s[j] for i in range(len(s)) for j in range(i+1,len(s)))
def det(A):return sum(sign(s)*prod(A[i][s[i]] for i in range(len(A))) for s in permutations(range(len(A))))
def prod(xs):
 r=F(1)
 for x in xs:r*=x
 return r
def inv2(A):return scale([[A[1][1],-A[0][1]],[-A[1][0],A[0][0]]],1/det(A))
def conv(a,b):
 out=[F(0)]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  for j,y in enumerate(b):out[i+j]+=x*y
 return out
def detpoly(A,B):
 out=[F(0)]*(len(A)+1)
 for s in permutations(range(len(A))):
  q=[F(sign(s))]
  for i in range(len(A)):q=conv(q,[A[i][s[i]],B[i][s[i]]])
  out=[x+y for x,y in zip(out,q)]
 return out
checks={}
A=mat([[170,1,167,170],[1,1,-2,1],[167,-2,173,167],[170,1,167,170]]);X=mat([[13,0,13,13],[1,1,-2,1]]);assert mul(trans(X),X)==A
full=[0]*7;restricted=[0]*7;count=0
for s in permutations(range(4)):
 inv=sum(s[i]>s[j] for i in range(4) for j in range(i+1,4));term=prod(A[i][s[i]] for i in range(4));full[inv]+=term
 if s[1]==1:restricted[inv]+=term;count+=1
assert count==6 and full==[4999700,4886140,-199231,4712758,9568969,4886140,115600] and restricted==[4999700,4741130,0,4741130,9482260,4999700,0]
q=F(7,8);gap=sum((a-b)*q**i for i,(a,b) in enumerate(zip(full,restricted)));assert gap==F(-3235575,16384)
checks['MI-19']={'permutations':24,'setwise_preserving_interior_singleton':count,'gram_identity':True,'full_coefficients_ascending':full,'restricted_coefficients_ascending':restricted,'full_minus_restricted':gap,'complex_reality':'all exact rational products have zero imaginary part'}
C=mat([[F(12,37),0],[0,F(21,29)]]);E=mat([[F(35,37),0],[0,F(20,29)]]);S=scale(mat([[15,8],[8,-15]]),F(1,17));assert mul(S,S)==eye(2) and add(power(C,2),power(E,2))==eye(2)
Ds=[mul(mul(S,E),S),mul(mul(S,C),S)];squares=[];certs=[]
for base,D,delta in zip([C,E],Ds,[F(5,3),F(3,5)]):
 assert delta**2==det(D)/det(base);h=sum(mul(inv2(base),D)[i][i] for i in range(2))+2*delta;Q=add(D,scale(base,delta));assert h>0 and Q[0][0]>0 and det(Q)>0
 assert mul(mul(Q,inv2(base)),Q)==scale(D,h);squares.append(scale(power(Q,2),1/h));certs.append({'delta':delta,'h':h,'Q':Q,'scaled_Riccati':True})
assert certs[0]['h']==F(61697295,8682716);assert certs[0]['Q']==scale(mat([[443355,33000],[33000,605715]]),F(1,310097));assert squares[0]==scale(mat([[3516940,616000],[616000,6547660]]),F(1,12158163));assert squares[1]==mul(mul(S,squares[0]),S)
L=add(*squares);assert L==scale(mat([[8216600,-985600],[-985600,11912600]]),F(1,12158163));w=[[F(1)],[F(-4)]];lam=F(1351000,1350907);assert mul(L,w)==scale(w,lam) and lam-1==F(93,1350907)
inputs=[power(C,2),power(E,2)]+[mul(mul(S,power(T,2)),S) for T in [E,C]];assert all(T[0][0]>0 and det(T)>0 for T in inputs);assert add(inputs[2],inputs[3])==eye(2)
checks['MI-21']={'involution_and_both_aggregate_identities':True,'all_input_leading_minors_positive':True,'both_exact_scaled_Riccati_certificates':certs,'actual_candidate_left':L,'nonzero_eigenvector':[1,-4],'eigenvalue':lam,'strict_gap':lam-1,'limitation':'Riccati-to-CFC and norm admissibility remain Lean proof obligations'}
A=mat([[2,0,0],[0,1,0],[0,0,F(1,2)]]);M=mat([[-1,2,0],[2,1,2],[0,2,1]]);B=scale(M,F(1,5));D=power(A,6);H=power(mul(mul(M,power(A,2)),M),4);J=power(mul(mul(A,power(M,2)),A),4);z=F(1,5**8);left=det(add(D,scale(H,z)));right=det(add(D,scale(J,z)));coeff=[x-y for x,y in zip(detpoly(D,J),detpoly(D,H))];assert det(B)==F(-1,125);assert coeff==[0,F(2089017,16),F(-31188746592549,1024),0];assert left==F(136990346414301954149,61035156250000000000) and right==F(4537743716162890657,1907348632812500000);assert right-left==F(21036678407451,156250000000000)
checks['MI-29']={'detB':det(B),'indefiniteness_diagonal_witnesses':[B[0][0],B[1][1]],'left_determinant_after_required_CFC_reduction':left,'right_determinant_after_required_CFC_reduction':right,'right_minus_left':right-left,'polynomial_gap_coefficients_ascending':coeff,'limitation':'actual CFC and positive-real determinant bridges remain Lean proof obligations'}
A=mat([[2,1],[1,2]]);G=mul(trans(A),A);assert G==mat([[5,4],[4,5]]) and det(G)==9 and sum(G[i][i] for i in range(2))==10
assert mul(G,[[F(1)],[F(1)]])==[[F(9)],[F(9)]] and mul(G,[[F(1)],[F(-1)]])==[[F(1)],[F(-1)]]
def fsq(A):return sum(x*x for r in A for x in r)
def outcomes(A):
 norm=fsq(A)
 if norm==0:return [(F(1),A,None)]
 out=[]
 for i,j in product(range(len(A)),range(len(A[0]))):
  if A[i][j]:out.append((A[i][j]**2/norm,[[A[a][b]-A[a][j]*A[i][b]/A[i][j] for b in range(len(A[0]))] for a in range(len(A))],(i,j)))
 return out
tab=[{'pivot':ij,'mass':mass,'residual':R,'error':fsq(R)} for mass,R,ij in outcomes(A)];expected=sum(t['mass']*t['error'] for t in tab);assert expected==F(18,5) and [t['mass'] for t in tab]==[F(2,5),F(1,10),F(1,10),F(2,5)] and [t['error'] for t in tab]==[F(9,4),F(9),F(9),F(9,4)]
normal=[]
for sample in [A,mat([[0,0],[0,0]]),mat([[1,0],[0,0]]),mat([[1,2,0]])]:
 histories=[(F(1),sample)]
 for k in range(4):
  assert sum(m for m,R in histories)==1 and all(m>=0 for m,R in histories);normal.append({'shape':[len(sample),len(sample[0])],'k':k,'mass':sum(m for m,R in histories),'expected':sum(m*fsq(R) for m,R in histories)});histories=[(m*w,R2) for m,R in histories for w,R2,ij in outcomes(R)]
checks['RA-03']={'gram':G,'ordered_squared_singular_value_candidate':[9,1],'singular_values_candidate':[3,1],'all_four_updates':tab,'expected_error':expected,'tail':1,'strict_gap':expected-2,'independent_history_diagnostics':normal,'limitation':'generic normalization and actual sorted singular-value identification still require Lean proofs'}
num=0;examples=[]
for n in range(0,7):
 for lam in product([F(1,2),F(1),F(3)],repeat=n):
  es=[sum(prod(lam[i] for i in s) for s in combinations(range(n),j)) for j in range(n+2)];poly=[F(1)]
  for x in lam:poly=conv(poly,[1,x])
  assert poly==es[:n+1] and es[0]==1 and es[-1]==0 and all(x>0 for x in es[:-1]);seq=[F(j+1)*es[j+1]/es[j] for j in range(n+1)]
  for j in range(2,n):assert seq[j-1]-2*seq[j]+seq[j+1]>=0;num+=1
  if n>=2:
   s1,s2,s3=[sum(x**k for x in lam) for k in [1,2,3]];gap=sum(x*y*(x-y)**2 for x,y in combinations(lam,2));den=s1*(s1*s1-s2);assert den>0 and gap>=0 and s1*s3-s2*s2==gap;assert s1-2*(s1*s1-s2)/s1+(s1**3-3*s1*s2+2*s3)/(s1*s1-s2)==2*gap/den
  if n in [0,2,3] and (not lam or len(set(lam))==1):examples.append({'lam':lam,'elementary':es,'sequence':seq})
checks['RA-07']={'exact_grid_values':[F(1,2),F(1),F(3)],'dimensions_checked':'0 through 6','canonical_second_differences_checked':num,'generic_certificate_samples':'positive denominator and exact s1*s3-s2^2 unordered pair identity at every sampled tuple of length >=2','endpoint_and_equal_tuple_examples':examples,'limitation':'finite diagnostics are not universal proofs or evidence for derivative splitting; the full actual factorization is an unconditional Challenge obligation'}
for e in entries:
 a=Path(e['root'])/'docs/lean/reverification-2026-09-14'/e['id'];a.mkdir(parents=True,exist_ok=True);(a/'referee-2-numerical-checks.json').write_text(json.dumps({'verdict':'PASS','independent_diagnostic_not_Lean_proof':True,**checks[e['id']]},default=str,indent=2)+'\n');shutil.copy2(__file__,a/'referee2_numerics.py');print(e['id'],'numerical PASS',flush=True)
