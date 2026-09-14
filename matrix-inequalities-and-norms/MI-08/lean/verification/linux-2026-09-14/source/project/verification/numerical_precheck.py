"""Supporting exact integer check; never imported or trusted by Lean."""
import json
from pathlib import Path
H=[[1 if i==0 or j==0 else -1 if i==j else 1 if (i-j)%11 in {1,3,4,5,9} else -1 for j in range(12)] for i in range(12)]
G=[[sum(H[r][i]*H[r][j] for r in range(12)) for j in range(12)] for i in range(12)]
assert G==[[12 if i==j else 0 for j in range(12)] for i in range(12)]
assert all(x in (-1,1) for row in H for x in row)
Path('verification/numerical-precheck.json').write_text(json.dumps({'matrix':H,'gram':G,'dimensions':[9,10,11,12],'status':'exact integer precheck PASS; not a Lean proof'},indent=2)+'\n')
