"""Independent exact finite diagnostics, not a Lean proof."""
import json,itertools
from pathlib import Path
j=json.loads(Path('verification/numerical-precheck.json').read_text())
# Derive the quadratic residues, rather than use the author's hardcoded set.
residues={x*x%11 for x in range(1,11)}
assert residues=={1,3,4,5,9}
H=[[1 if i==0 or k==0 else -1 if i==k else (1 if (i+11-k)%11 in residues else -1) for k in range(12)] for i in range(12)]
assert H==j['matrix']
assert all(x in (-1,1) for row in H for x in row)
G=[[sum(H[r][i]*H[r][k] for r in range(12)) for k in range(12)] for i in range(12)]
assert G==j['gram']==[[12*int(i==k) for k in range(12)] for i in range(12)]
for d in range(9,13):
 for i in range(d):
  for k in range(d):
   # Diagonal sign conjugations on E_ik multiply only its own entry.
   assert sum(H[r][i]*H[r][k] for r in range(12))==12*int(i==k)
 assert not any(q>=d and q%4==0 for q in range(1,12))
for a,b,c in itertools.product([-1,1],repeat=3):
 v=(1+a*b)*(1+a*c)
 assert v%4==0 and v==1+a*b+a*c+b*c
print('PASS: residues derived by squaring; exact encoded 12×12 matrix matches precheck.')
print('PASS: actual integer column Gram equals 12 I; all 144 entries are signs.')
print('PASS: all matrix-unit pinching coefficients for each 9≤d≤12 equal the target.')
print('PASS: all 8 triple-sign divisibility identities; no q<12 meets d≤q and 4|q for d≥9.')
print('Diagnostics only; universal equivalence, rank, divisibility, and leastness still need Lean proofs.')
