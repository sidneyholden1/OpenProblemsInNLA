import json
u0,u1=[0],[1]
for k in range(2,13):
 z=[0]*max(len(u1)+1,len(u0))
 for j,c in enumerate(u1):z[j+1]+=c
 for j,c in enumerate(u0):z[j]-=3*c
 u0,u1=u1,z
assert u1==[0,-1458,0,2835,0,-1512,0,324,0,-30,0,1]
assert [3*c for c in u0]==[-729,0,3645,0,-2835,0,756,0,-81,0,3]
print(json.dumps({'verdict':'PASS','recurrence':'u0=0,u1=1,uk=s*u(k-1)-3*u(k-2)','linearCoefficient_ascending':u1,'identityCoefficient_ascending':[3*c for c in u0]},indent=2))
