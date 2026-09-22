from itertools import permutations,combinations
from fractions import Fraction as F
from pathlib import Path
import hashlib,json,subprocess
# Independent sparse exact polynomial arithmetic (x,a,b,c,d,e,f).
z=(0,)*7
def C(v):return {} if v==0 else {z:F(v)}
def V(i):
 e=list(z);e[i]=1;return {tuple(e):F(1)}
def add(*ps):
 o={}
 for p in ps:
  for e,v in p.items():o[e]=o.get(e,0)+v
 return {e:v for e,v in o.items() if v}
def scale(p,c):return {e:v*c for e,v in p.items() if v*c}
def mul(p,q):
 o={}
 for e,v in p.items():
  for f,w in q.items():
   k=tuple(a+b for a,b in zip(e,f));o[k]=o.get(k,0)+v*w
 return {e:v for e,v in o.items() if v}
def det(M):
 out={}
 for p in permutations(range(len(M))):
  t=C((-1)**sum(p[i]>p[j] for i in range(len(p)) for j in range(i+1,len(p))))
  for i,j in enumerate(p):t=mul(t,M[i][j])
  out=add(out,t)
 return out
edges=list(combinations(range(4),2));L=[[{} for j in range(4)] for i in range(4)]
for k,(i,j) in enumerate(edges,1):
 L[i][j]=L[j][i]=scale(V(k),-1);L[i][i]=add(L[i][i],V(k));L[j][j]=add(L[j][j],V(k))
cof=add(*(det([[L[i][j] for j in range(4) if j!=r] for i in range(4) if i!=r]) for r in range(4)))
trees=[]
for es in combinations(range(6),3):
 reach={0}
 while True:
  old=reach.copy()
  for k in es:
   i,j=edges[k]
   if i in reach or j in reach:reach.update((i,j))
  if old==reach:break
 if len(reach)==4:trees.append(es)
tp={}
for es in trees:
 t=C(1)
 for k in es:t=mul(t,V(k+1))
 tp=add(tp,t)
assert cof==scale(tp,4)
counts=[0,0,0]
for mask in range(64):
 es={k for k in range(6) if mask&(1<<k)}
 if any(set(t)<=es for t in trees):counts[0]+=1
 elif any(not any(i in edges[k] for k in es) for i in range(4)):counts[1]+=1
 else:
  assert len(es)==2 and len({i for k in es for i in edges[k]})==4
  counts[2]+=1
A=[[0,1,0,0],[1,0,0,0],[0,0,F(1,2),F(1,2)],[0,0,F(1,2),F(1,2)]]
P=det([[add(V(0) if i==j else {},C(-A[i][j])) for j in range(4)] for i in range(4)])
wanted=mul(mul(V(0),mul(add(V(0),C(-1)),add(V(0),C(-1)))),add(V(0),C(1)))
assert P==wanted
iso=[[1,0,0,0],[0,0,F(1,2),F(1,2)],[0,F(1,2),0,F(1,2)],[0,F(1,2),F(1,2),0]]
assert det([[C(v) for v in r] for r in iso])==C(F(1,4))
root=Path.cwd().parents[2];snap=json.loads(Path('reviews/statement-source-hashes.json').read_text());hashes={}
for f,h in snap.items():
 got=hashlib.sha256(Path(f).read_bytes()).hexdigest();assert got==h;hashes[f]=got
for f in ['README.md','solution.md']:
 rel='eigenvalues-and-inverse-problems/IS-02/'+f
 b=subprocess.check_output(['git','show','9777c86853b40206f70438c92a47a7dec9bc66ae:'+rel],cwd=root)
 assert b==Path('../'+f).read_bytes();hashes['../'+f]=hashlib.sha256(b).hexdigest()
out={'all_hashes_match':True,'sha256':hashes,'tree_count':len(trees),'support_counts':counts,'derivative_identity':'sum of four principal minors of I-B equals 4 times 16-tree sum; hence p derivative at 1','witness_charpoly_correct':True,'isolated_case_determinant':'1/4','status':'independent exact diagnostic algebra, not Lean proof'}
Path('verification/referee-2-independent-precheck.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS: all hashes/base bytes, 16-tree derivative identity, 38/23/3 supports, witness charpoly, isolated determinant.')
