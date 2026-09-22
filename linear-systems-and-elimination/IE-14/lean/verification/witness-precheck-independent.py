"""Independent exact rational transcription diagnostic; not a universal proof."""
from fractions import Fraction as Q
from pathlib import Path
import json

def fib(k):
    a,b=0,1
    for _ in range(k): a,b=b,a+b
    return a
checks=[]
for n in range(4,41):
    L=[[Q(i==j)-Q(i==j+1 or i==j+2) for j in range(n)] for i in range(n)]
    U=[[Q(fib(i+2)+(i==n-1)) if j==n-1 else Q(1,2) if j==1 and i in [0,1] else Q(i==j) for j in range(n)] for i in range(n)]
    C=[[sum(L[i][k]*U[k][j] for k in range(n)) for j in range(n)] for i in range(n)]
    sigma=[0,n-1]+list(range(1,n-1)); A=[[Q(0)]*n for _ in range(n)]
    for i in range(n): A[sigma[i]]=C[i][:]
    assert all(A[i][j]==0 for i in range(n) for j in range(n) if abs(i-j)>1 and (i,j) not in [(0,n-1),(n-1,0)])
    assert A[0][-1]==1 and A[-1][0]==-1
    assert max(abs(x) for row in A for x in row)==1
    S=[row[:] for row in A]; growth=Q(1)
    for k in range(n):
        r=0 if k==0 else n-1
        assert S[r][k]!=0 and all(abs(S[i][k])<=abs(S[r][k]) for i in range(k,n))
        S[k],S[r]=S[r],S[k]
        if k==n-1: assert S[k][k]==fib(n+1)+1
        for i in range(k+1,n):
            fac=S[i][k]/S[k][k]
            for j in range(k+1,n): S[i][j]-=fac*S[k][j]
            S[i][k]=0
        growth=max(growth,max(abs(S[i][j]) for i in range(k,n) for j in range(k,n)))
    assert growth==fib(n+1)+1
    checks.append({'n':n,'growth':int(growth),'verdict':'PASS'})
Path(__file__).with_suffix('.json').write_text(json.dumps({'scope':'Exact finite diagnostics only; not universal formal proof','author':'OpenAI Codex /root/new_target_screen','checks':checks},indent=2)+'\n')
print('PASS37 exact rational witness diagnostics, n=4..40')
