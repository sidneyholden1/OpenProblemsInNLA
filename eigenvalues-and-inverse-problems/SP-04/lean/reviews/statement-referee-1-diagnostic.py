from fractions import Fraction as F
from math import isqrt
import json, hashlib
from pathlib import Path

def sqrt_box(x):
    scale=10**12
    k=isqrt(x.numerator*scale*scale//x.denominator)
    lo,hi=F(k,scale),F(k+1,scale)
    assert lo*lo<=x<hi*hi
    return lo,hi

def a_box(s,t):
    l,h=sqrt_box(s*s+4*t)
    return (s+l)/2,(s+h)/2

s=[F(1751,1000),F(1755,1000),F(1759,1000)]
assert F(7,4)<s[0]<s[1]<s[2]<F(44,25)
rad=F(7,4)**2-4*F(13,25)
assert rad==F(393,400) and rad>F(99,100)**2
assert (F(7,4)+sqrt_box(rad)[0])/2>1
assert (1+(2*F(44,25))/(2*F(99,100)))/2<2
small=F(13,25)*F(44,25)*F(51,50)
assert small==F(29172,31250)<1
assert 4-2*F(7,4)-F(13,25)<0
assert F(1,4)**2+F(44,25)/4<F(13,25)

def product_box(t):
    aa=[a_box(x,t) for x in s]
    return t/aa[0][1]*aa[1][0]*aa[2][0],t/aa[0][0]*aa[1][1]*aa[2][1]
lo,hi=F(4974,10000),F(4975,10000)
assert product_box(lo)[1]<1<product_box(hi)[0]
assert sum((x-1)**2 for x in s)==F(1710107,1000000)
paths=['../README.md','../solution.md','../solution.tex','NUMERICAL_TARGETS.md','NLA/SP04/Definitions.lean','Challenge.lean','formalization.yaml','SOURCE_PROVENANCE.json','verification/statement-typecheck.json','verification/statement-typecheck.log','../../../docs/lean/REVIEW.md','lean-toolchain','lakefile.toml']
paths += ['.lake/packages/mathlib/Mathlib/'+p for p in ['Topology/Instances/Matrix.lean','LinearAlgebra/Matrix/Determinant/Basic.lean','Algebra/MvPolynomial/Eval.lean','Topology/Algebra/MvPolynomial.lean']]
hashes={p:hashlib.sha256(Path(p).read_bytes()).hexdigest() for p in paths}
receipt=json.loads(Path('verification/statement-typecheck.json').read_text())
assert all(hashes[p]==v for p,v in receipt['files'].items())
source=json.loads(Path('SOURCE_PROVENANCE.json').read_text())
assert all(hashes['../'+Path(x['repository_path']).name]==x['sha256'] for x in source['source_files'])
assert Path('Challenge.lean').read_text().count('by sorry')==9
assert not Path('Solution.lean').exists()
json.dump({'phase':'independent statement diagnostics only; not proofs','reviewer':'/root/iv06_statement_referee_1','result':'PASS','exact_checks':['strict nonempty rational parameter witness','radicand and square-root difference margin','full-region small-root rational upper bound','negative-root endpoint inequalities','rational sqrt enclosures bracket selected sample t in (4974/10000,4975/10000)','exact identity distance to I = 1710107/1000000','current source hashes equal supplied typecheck receipt and source provenance','nine deliberate placeholders; no Solution'], 'limitations':'Sample root bracket is diagnostic only, not universal existence/uniqueness, all-pattern comparison or full matrix/open-set proof. No proof bodies inspected or implemented.', 'read_hashes':hashes},open('reviews/statement-referee-1-evidence.json','w'),indent=2)
print('PASS: exact rational diagnostics, source/receipt correspondence, nine proposed exports; no proof claim.')
