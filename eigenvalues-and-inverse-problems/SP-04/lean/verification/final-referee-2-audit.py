import hashlib,json,re,subprocess,pathlib
P=pathlib.Path(__file__).resolve().parent.parent
sha=lambda f:hashlib.sha256(f.read_bytes()).hexdigest()
frozen=json.loads((P/'verification/statement-freeze.json').read_text())
for section in ['sha256','reports']:
 for f,h in frozen[section].items(): assert sha(P/f)==h, f
sources=json.loads((P/'SOURCE_PROVENANCE.json').read_text())
root=P.parents[2]
for row in sources['source_files']:
 f=root/row['repository_path']
 assert sha(f)==row['sha256'],str(f)
 blob=subprocess.check_output(['git','show',sources['source_commit']+':'+row['repository_path']],cwd=root)
 assert blob==f.read_bytes()
config=json.loads((P/'comparator.json').read_text())
assert config['definition_names']==[]
assert set(config['permitted_axioms'])=={'propext','Classical.choice','Quot.sound'}
def signatures(path):
 t=path.read_text(); out={}
 for m in re.finditer(r'\btheorem (\w+)\s*(.*?)\s*:=\s*by',t,re.S):out[m.group(1)]=re.sub(r'\s+','',m.group(2))
 return out
assert signatures(P/'Challenge.lean')==signatures(P/'Solution.lean')
assert {'NLA.SP04.'+n for n in signatures(P/'Solution.lean')}==set(config['theorem_names'])
files=list(sorted(P.glob('NLA/SP04/*.lean')))+[P/f for f in ['Solution.lean','Challenge.lean','NUMERICAL_TARGETS.md','formalization.yaml','comparator.json','lakefile.toml','lake-manifest.json','lean-toolchain','SOURCE_PROVENANCE.json','README.md']]
for f in list(P.glob('NLA/SP04/*.lean'))+[P/'Solution.lean']:
 assert not re.search(r'\b(sorry|admit|axiom)\b',re.sub(r'/\-.*?\-/|--[^\n]*','',f.read_text(),flags=re.S)),str(f)
 assert not re.search(r'^import\s+Challenge\b',f.read_text(),re.M)
out={'reviewer':'/root/sp04_final_referee_2','independence':'Fresh AI nonauthor of SP04 statements and proof','frozen_hashes_match':True,'source_git_bytes_match':True,'nine_normalized_signatures_match':True,'files_sha256':{str(f.relative_to(P)):sha(f) for f in files},'source_sha256':{r['repository_path']:r['sha256'] for r in sources['source_files']},'limitations':'Local review and elaboration only; actual isolated Linux Comparator not performed by this reviewer.'}
(P/'verification/final-referee-2-audit.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS frozen boundary, source Git correspondence, nine signatures, configuration, no proof holes')
