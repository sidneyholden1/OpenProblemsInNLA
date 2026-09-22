"""Exact integer precheck, not a Lean proof. Source: Stepaniants IE-05 solution.md."""
from fractions import Fraction as F
from pathlib import Path
import json
H1=[[1,-1,-3,-21,-41,-101,-325,63],[-1,3,1,17,71,291,1179,31],[-1,-1,13,-19,-56,-196,-752,16],[-1,-1,-3,189,-28,-98,-376,8],[-1,-1,-3,-51,581,-49,-188,4],[-1,-1,-3,-51,-213,1507,-94,2],[-1,-1,-3,-51,-213,-873,2589,1],[-1,1,-5,-55,-183,-683,-2683,1]]
H0=[[1,-5,-8,-12,-16,-16,0,64],[-1,13,-4,-6,-8,-8,0,32],[-1,-3,51,-3,-4,-4,0,16],[-1,-3,-11,169,-2,-2,0,8],[-1,-3,-11,-43,511,-1,0,4],[-1,-3,-11,-43,-171,1365,0,2],[-1,-3,-11,-43,-171,-683,1,1],[-1,-3,-11,-43,-171,-683,-1,1]]
D0=[8,248,3286,36146,349184,2796544,2,5462]
D1=[8,16,240,47640,472430,3644970,16148136,5272]
def cert(H,D,modified):
 L=[[1 if i==j else (-1 if j<i else 0) for j in range(8)] for i in range(8)]
 if modified:L[7][1]=0
 T=[[0]*8 for _ in range(8)]
 for i in range(8):
  for j in range(8):T[i][j]=H[i][j]-sum(L[i][k]*T[k][j] for k in range(i))
 assert all(T[i][j]==0 for i in range(8) for j in range(i))
 assert all(T[i][i]>0 for i in range(8))
 assert all(sum(H[k][i]*H[k][j] for k in range(8))==(D[i] if i==j else 0) for i in range(8) for j in range(8))
 B=[[sum(H[k][i]*L[k][j] for k in range(8)) for j in range(8)] for i in range(8)]
 assert all(B[i][j]==0 for i in range(8) for j in range(i))
 assert all(B[i][i]>0 for i in range(8))
 S=[[[sum(L[i][ell]*T[ell][j] for ell in range(k,8)) if k<=i and k<=j else 0 for j in range(8)] for i in range(8)] for k in range(8)]
 assert S[0]==H
 for k in range(8):
  assert S[k][k][k]>0
  assert all(S[k][i][k]==L[i][k]*S[k][k][k] for i in range(k,8))
  if k<7:
   assert all(S[k+1][i][j]==(S[k][i][j]-L[i][k]*S[k][k][j] if k<i and k<j else 0) for i in range(8) for j in range(8))
 initial=max(F(H[i][j]**2,D[j]) for i in range(8) for j in range(8))
 peak=max(F(S[k][i][j]**2,D[j]) for k in range(8) for i in range(8) for j in range(8))
 return dict(H=H,D=D,L=L,T=T,HTL=B,initial_squared=str(initial),peak_squared=str(peak),growth_squared=str(peak/initial),active_column_integer_max=[max(abs(S[k][i][j]) for k in range(8) for i in range(8)) for j in range(8)])
c0=cert(H0,D0,False);c1=cert(H1,D1,True)
assert F(c0['growth_squared'])<F(167,2)**2<F(c1['growth_squared'])
Path(__file__).with_name('numerical-precheck.json').write_text(json.dumps(dict(scope='Integer/Fraction precheck only, not proof evidence',candidate=c0,witness=c1,separator='167/2'),indent=2)+'\n')
print('Exact QR, pivot recurrence, active-entry bounds and strict gap: PASS')
