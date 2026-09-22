from pathlib import Path
import json,hashlib,subprocess
p=Path('/private/tmp/nla-20260922/mf12-linux');r=Path('/private/tmp/nla-20260922-mf12');sha=lambda b:hashlib.sha256(b).hexdigest()
a=json.loads((p/'AUDIT-RESULTS.json').read_text());x=a['projects'][0];c=x['repository_commit'];head=a['head_sha'];proj=x['project']
def git(*args):return subprocess.check_output(['git',*args],cwd=r)
f=next((p/'lean-MF-12/artifact').rglob('result.json'));v=json.loads(f.read_text())
inputs={}
for name,digest in v['input_sha256'].items():
 b=git('show',c+':'+proj+'/'+name);assert sha(b)==digest
 out=p/'tested-inputs'/name;out.parent.mkdir(parents=True,exist_ok=True);out.write_bytes(b);inputs[name]=digest
(p/'tested-inputs-sha256.json').write_text(json.dumps(inputs,indent=2)+'\n')
for name in ['tools/lean/harness.py','tools/lean/source-lock.json','.github/workflows/lean-verification.yml']:
 assert git('show',c+':'+name)==git('show',head+':'+name)
api=json.loads((p/'github-attempt-2.json').read_text());jobs=json.loads((p/'github-attempt-2-jobs.json').read_text())
assert api['run_attempt']==2 and api['conclusion']=='success' and api['head_sha']==head
assert all(j['conclusion'] in ['success','skipped'] for j in jobs['jobs'])
manifest=json.loads((p/'tested-inputs/reviews/proof-source-hashes.json').read_text())
assert all(inputs[k]==h for k,h in manifest.items())
review=json.loads((p/'tested-inputs/reviews/referee-1-proof-evidence-20260922.json').read_text())
assert all(inputs[k]==h for k,h in review['active_closure'].items())
for k in ['reviews/final-referee-1.md','reviews/final-referee-root.md']:
 if k in inputs: print(k,inputs[k])
text=f'''# MF-12 independent Linux operational audit — PASS

Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_1`, nonauthor of MF-12 proofs. Date: 2026-09-22. This is an independent audit of the actual collected Linux evidence, separate from the two mathematical final reviews.

Run [35696246513, attempt 2](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35696246513/attempts/2) completed successfully. API event/proof head: `{head}`. Actual tested PR merge commit: `{c}`. Both are recorded, not conflated. The entire MF-12 project tree and the reviewed harness, source lock and workflow match between these commits. Attempt 1 was cancelled; its original API response remains in `github-attempt-1-cancelled.json`. The later success does not erase that cancellation.

The original GitHub artifact `lean-MF-12` (ID {x['artifact']['artifact_id']}) is retained unchanged as `lean-MF-12/lean-MF-12.zip`; its {x['artifact']['bytes']:,} bytes hash to `{x['artifact']['sha256']}`, exactly matching the GitHub API digest. ZIP CRC and contained paths passed checks. All **84** tracked project input names and SHA-256 values matched exact Git blobs at the tested immutable commit; all actual input bytes are additionally retained in `tested-inputs/` with `tested-inputs-sha256.json`. There are 83 distinct Git blobs. The candidate manifest and previously reviewed twelve-file active closure match the tested inputs exactly. The initially absent PR merge object was fetched read-only from the public repository before comparison.

I inspected `result.json`, the actual Comparator output and all kernel/rejection/isolation logs. On **Linux x86_64, Lean 4.33.1**, Comparator freshly built Challenge and Solution, exported exactly the four configured MF-12 declarations, checked statement identity and the standard permitted-axiom restriction, and reported **“Lean default kernel accepts the solution”** and **“Your solution is okay!”**, exit 0. The accepted declarations are `compressed_powers`, `fractional_growth`, `arbitrary_pair`, and `original_target` in `NLA.MF12`. The Solution build completed 3,110 jobs. The deliberate Challenge placeholders are trusted statement boundaries, not Solution proof evidence. The complete exported proof was replayed by the actual default kernel; this result is not inferred from the macOS build or a success label alone.

The actual kernel probe accepted its honest inductive/quotient fixture, rejected a raw invalid proof, and rejected a quotient post-check mismatch even after kernel acceptance. All five Comparator regression fixtures behaved as required; the dedicated theorem-type mismatch was rejected. Separate actual Comparator runs rejected `sorryAx` and the fresh native-decide auxiliary axiom. No extra axiom is permitted beyond `propext`, `Classical.choice`, and `Quot.sound`. The pinned source-lock digest agrees with both the tested repository and tool receipt; the receipt identifies the expected Comparator/exporter/sandbox binaries and Linux toolchain.

Both build and export sandbox probes ran successfully. They denied outside-tree writes/truncation/creation, read-only truncate-open and symlink escape; only the build-mode `.lake` write was permitted, and export `.lake` writes/truncation were denied. Both modes used private user/PID/mount/network/IPC/UTS namespaces, hid the host parent process, denied host-parent signalling and host-loopback access, denied AF_UNIX sockets, had no effective capabilities, set `no_new_privs`, and rejected nested-namespace write attempts. Sandbox UID was nonroot 1001. All four unsupported-option/path fixtures exited 2, and outside/export fixtures remained unchanged. The separate workflow checker-controls job was skipped, but these controls demonstrably executed inside this project's successful verification job.

Scope: this gate establishes the actual frozen four-export full MF-12 candidate, including arbitrary real nonnegative exponents, every positive word length and the genuine root limit, in conjunction with its separate source reviews. It does not add the excluded optimal-dimension or rational-entry refinements. It does not certify future publication edits or a future branch head. No proof, metadata, canonical page or remote branch was modified during this audit.

Machine evidence: `AUDIT-RESULTS.json`, original run/attempt/job/artifact API responses, `downloads.json`, original ZIP, extracted logs, exact input snapshots and `audit_run.py`. Relevant hashes:

- `AUDIT-RESULTS.json`: `{sha((p/'AUDIT-RESULTS.json').read_bytes())}`
- original `result.json`: `{x['result_sha256']}`
- Comparator log: `{x['log_sha256']['comparator.log']}`
- input hash manifest: `{sha((p/'tested-inputs-sha256.json').read_bytes())}`

No unresolved operational finding remains. This is an AI operational audit, not external human review or a claim of running GitHub's Linux execution locally.
'''
(p/'OPERATIONAL-REFEREE-1.md').write_text(text)
print('PASS',sha((p/'OPERATIONAL-REFEREE-1.md').read_bytes()))
