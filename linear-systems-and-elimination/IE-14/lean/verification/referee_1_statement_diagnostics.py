#!/usr/bin/env python3
"""Independent exact transcription diagnostics, not universal proof."""
from fractions import Fraction as Q
import json, hashlib
from pathlib import Path

def fib(n):
 a,b=0,1
 for _ in range(n):a,b=b,a+b
 return a

def witness(n):
 L=[[Q(1 if i==j else -1 if i in (j+1,j+2) else 0) for j in range(n)] for i in range(n)]
 U=[[Q(fib(i+2)+(i==n-1)) if j==n-1 else Q(1,2) if j==1 and i in (0,1) else Q(i==j) for j in range(n)] for i in range(n)]
 C=[[sum(L[i][k]*U[k][j] for k in range(n)) for j in range(n)] for i in range(n)]
 perm=[0]+list(range(2,n))+[1]
 return [C[i] for i in perm],U,perm

def maximum(A):return max(abs(v) for row in A for v in row)
def padded_step(S,k,r):
 n=len(S);swap=lambda i:r if i==k else k if i==r else i
 return [[S[swap(i)][j]-S[swap(i)][k]/S[r][k]*S[r][j] if k<i and k<j else Q(0) for j in range(n)] for i in range(n)]
def compact_step(S,r):
 S=[row[:] for row in S];S[0],S[r]=S[r],S[0]
 return [[S[i][j]-S[i][0]/S[0][0]*S[0][j] for j in range(1,len(S))] for i in range(1,len(S))]
rows=[]
for n in range(4,25):
 A,U,perm=witness(n);assert A[0][-1]==1 and A[-1][0]==-1 and maximum(A)==1
 for i in range(n):
  for j in range(n):
   if not(abs(i-j)<=1 or (i,j) in [(0,n-1),(n-1,0)]):assert A[i][j]==0
 S=A;compact=A;g=maximum(A);det=Q(1);labels=list(range(n));selected=[]
 for k in range(n):
  r=0 if k==0 else n-1;selected.append(labels[r]);assert S[r][k]!=0
  assert abs(S[r][k])==max(abs(S[i][k]) for i in range(k,n))
  det*=S[r][k]*(-1 if r!=k else 1)
  assert [[S[i][j] for j in range(k,n)] for i in range(k,n)]==compact
  if k<n-1:
   compact=compact_step(compact,r-k);S=padded_step(S,k,r);g=max(g,maximum(S))
   labels[k],labels[r]=labels[r],labels[k]
 assert selected==[0,n-1]+list(range(1,n-1))
 assert det == (-1)**(n-2)*Q(fib(n+1)+1,2)
 assert det!=0 and g==fib(n+1)+1 and S[n-1][n-1]==g
 rows.append({'n':n,'growth':str(g),'det':str(det),'all_padding_matches_compact':True})
counts={}
for n in range(4,7):
 A,_,_=witness(n);complete=[]
 def visit(S,g):
  if len(S)==1:
   assert S[0][0]!=0;complete.append(max(g,maximum(S)));return
  m=max(abs(row[0]) for row in S);assert m>0
  for r in range(len(S)):
   if abs(S[r][0])==m:
    T=compact_step(S,r);visit(T,max(g,maximum(T)))
 visit(A,maximum(A));assert max(complete)==fib(n+1)+1
 counts[n]={'all_tie_paths':len(complete),'maximum_growth':str(max(complete))}
p=Path(__file__).parent
out={'verdict':'PASS','scope':'Finite exact witness/padding and tie-path diagnostics only; not proof for arbitrary inputs or all dimensions.','witness_cases':rows,'exhaustive_witness_ties':counts,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(p/'referee-1-statement-diagnostics.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'verdict':'PASS','witness_dimensions':len(rows),'tie_paths':counts}))
