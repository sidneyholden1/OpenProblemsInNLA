"""Exact, non-authoritative pre-proof optimization of IE-17 certificates."""
from fractions import Fraction as F
from pathlib import Path
import json
root=Path(__file__).resolve().parents[4]
d=json.loads((root/'references/colbrook-recovered-2026-09-11/verification/fresh-results.json').read_text())['results']['IE-17']
E=[[F(v) for v in row] for row in d['explicit_upper_E']]
P=[[F(1979,2000)*(i==j)-sum(E[k][i]*E[k][j] for k in range(4)) for j in range(3)] for i in range(3)]
L=[[F(i==j) for j in range(3)] for i in range(3)];D=[]
for j in range(3):
 D.append(P[j][j]-sum(L[j][r]**2*D[r] for r in range(j)))
 for i in range(j+1,3): L[i][j]=(P[i][j]-sum(L[i][r]*L[j][r]*D[r] for r in range(j)))/D[j]
assert all(v>0 for v in D)
assert all(sum(L[i][r]*D[r]*L[j][r] for r in range(3))==P[i][j] for i in range(3) for j in range(3))
K=[[F(v) for v in row] for row in d['lower_integer_matrix']];w=list(map(F,[2000,2,37,258]))
slack=[K[i][i]*w[i]-sum(abs(K[i][j])*w[j] for j in range(4) if i!=j) for i in range(4)]
assert all(s>0 for s in slack)
out=dict(scope='Rational prechecks only, not Lean proofs',upper_E=E,upper_L=L,upper_D=D,lower_weights=w,lower_weighted_row_slacks=slack)
Path('verification/numerical-precheck.json').write_text(json.dumps(out,default=str,indent=2)+'\n')
print('Upper exact LDL positive; lower four weighted row slacks positive:',list(map(str,slack)))
