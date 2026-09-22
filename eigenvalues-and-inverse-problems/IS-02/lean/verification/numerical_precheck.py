import sympy as s,itertools,json
from pathlib import Path
x=s.symbols('x');a,b,c,d,e,f=s.symbols('a b c d e f');vs=[a,b,c,d,e,f];edges=list(itertools.combinations(range(4),2))
B=s.Matrix([[1-a-b-c,a,b,c],[a,1-a-d-e,d,e],[b,d,1-b-d-f,f],[c,e,f,1-c-e-f]])
p=s.factor(B.charpoly(x).as_expr());trees=[];counts={'connected':0,'isolated':0,'two_pairs':0}
for es in itertools.combinations(range(6),3):
 comp={0}
 for _ in range(3):
  for k in es:
   i,j=edges[k]
   if i in comp or j in comp:comp|={i,j}
 if len(comp)==4:trees.append(es)
treepoly=sum(s.prod(vs[i] for i in es) for es in trees)
assert s.expand(s.diff(p,x).subs(x,1)-4*treepoly)==0
for mask in range(64):
 support={i for i in range(6) if mask>>i&1}
 if any(set(t)<=support for t in trees): counts['connected']+=1
 elif any(all(i not in edges[k] for k in support) for i in range(4)):counts['isolated']+=1
 else:
  assert len(support)==2 and len(set(sum((list(edges[k]) for k in support),[])))==4
  counts['two_pairs']+=1
A=s.Matrix([[0,1,0,0],[1,0,0,0],[0,0,s.Rational(1,2),s.Rational(1,2)],[0,0,s.Rational(1,2),s.Rational(1,2)]])
assert s.expand(A.charpoly(x).as_expr()-x*(x-1)**2*(x+1))==0
out={'characteristic_polynomial':str(p),'tree_identity':'p\'(1) = 4 times the sum of the 16 spanning-tree edge products','tree_polynomial':str(treepoly),'tree_edge_indices':trees,'edge_order':edges,'support_cases':counts,'witness_charpoly':str(A.charpoly(x).as_expr()),'witness_trace':str(s.trace(A)),'proof_status':'Exact symbolic precheck only; not a Lean proof.'}
Path(__file__).with_name('numerical-precheck.json').write_text(json.dumps(out,indent=2)+'\n')
print(out)
