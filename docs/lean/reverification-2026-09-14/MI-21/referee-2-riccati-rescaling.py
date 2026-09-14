from fractions import Fraction as F
from pathlib import Path
import json,hashlib
p=Path(__file__).parent
old=json.loads((p/'referee-2-numerical-checks.json').read_text())
a,b=old['both_exact_scaled_Riccati_certificates']
Q=[[F(x) for x in row] for row in b['Q']]
actual=[[F(506715,310097),F(-85800,310097)],[F(-85800,310097),F(542355,310097)]]
assert actual==[[F(5,3)*x for x in row] for row in Q]
assert F(a['h'])==F(25,9)*F(b['h'])
assert F(5,3)**2/F(a['h'])==1/F(b['h'])
out={'verdict':'PASS','diagnostic_not_Lean_proof':True,'actual_second_numerator':actual,'actual_shared_scale':a['h'],'diagnostic_second_scale':b['h'],'numerator_multiplier':'5/3','scale_multiplier':'25/9','squared_mean_unchanged':True,'input_sha256':hashlib.sha256((p/'referee-2-numerical-checks.json').read_bytes()).hexdigest(),'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(p/'referee-2-riccati-rescaling.json').write_text(json.dumps(out,default=str,indent=2)+'\n')
print('MI-21 exact actual/diagnostic Riccati rescaling PASS')
