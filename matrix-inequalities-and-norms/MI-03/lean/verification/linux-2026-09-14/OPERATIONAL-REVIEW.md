# MI-03 independent Linux operational review

Verdict: **PASS** for the four configured declarations at immutable commit `4602650e944c7221952554f495ff76c39c8b0708`. This is an operational audit of the original Linux artifact, supplementing the retained mathematical reviews; it does not replace them.

Reviewer: independent AI referee 1. Date: 2026-09-14. No proof build was rerun, and no mathematical or publication file was modified.

## Run and immutable evidence

GitHub run [34862171380](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34862171380), attempt 1, completed successfully for this commit. I independently queried the current GitHub run and artifact APIs and compared their identities with the saved metadata. The run is a push of `codex/lean-mi03`; artifact `10355511804`, `lean-MI-03`, is unexpired and bound to the same run and commit. I recomputed the original ZIP SHA-256, matching both the saved and fresh API digest:

`dc9194a3ef7c1ae3910c9c34810c5286bf277ea8ef73fb9404fd56af34ac725f`.

ZIP CRC validation passes. All 13 archive members have safe relative paths, and each retained extracted member exactly matches its original ZIP bytes. All 29 input snapshots were independently hashed and compared byte-for-byte with `git show` at the immutable commit, not merely checked against the supplied matching boolean. They match all 29 entries in `result.json`; the committed project tree also contains exactly 29 files. The receipt's source-lock digest independently matches that commit's `tools/lean/source-lock.json` (`b3833b07916e5db77579b9cc53ca582282f6a841f36d6a60d693e5b02d342b6b`).

## Theorem identity and kernel gate

`comparator.log` shows fresh Challenge and Solution compilation, export and comparison of exactly `NLA.MI03.upper_bound`, `NLA.MI03.sharpness`, `NLA.MI03.sharp_constant`, and `NLA.MI03.odd_sharp_constant`. Both exports list the same four names. The configuration has no definition replacement allowances and permits only `propext`, `Classical.choice`, and `Quot.sound`. It then explicitly runs the Lean default kernel, records “Lean default kernel accepts the solution” and “Your solution is okay!”, and exits zero. The retained axiom audit for all four exports lists exactly those three standard axioms.

The four Challenge placeholder warnings are intentional at the statement boundary; the verified Solution is independently exported and kernel-replayed. A Solution build style warning about an unnecessary tactic focus is nonblocking. The receipt identifies Lean 4.33.1, x86_64 Linux, and the workflow uses Ubuntu 24.04. This Linux result is actual run evidence, not an inference from the earlier macOS checks.

## Negative controls and sandbox

All recorded controls pass. Kernel replay accepts the honest inductive/quotient fixture, rejects the malformed raw proof, and rejects a quotient mismatch in its postcheck. Comparator regression fixtures accept the matching case and reject the constant/axiom/type failures. The fixture named `simple_kind_mismatch` was rejected for the logged unexpected `helper` axiom; I do not claim that this separately demonstrates every possible constant-kind mutation. Additional Solution fixtures explicitly reject `sorryAx` and `checked._native.native_decide.ax_1_1`, with the expected nonzero exits. These are successful negative tests.

The build/export sandbox probes demonstrate denied outside writes, truncation, symlink escape and file creation; build-only permission for the designated `.lake` write; and denied export writes. They demonstrate private user/PID/mount/network/IPC/UTS namespaces, unavailable host-parent process signalling, denied host-loopback access, denied AF_UNIX creation, no effective capabilities, and `no_new_privs`. A nested namespace write attempt fails. Unknown/unrestricted/extra/relative writable-option probes are rejected. The original fixtures remain unchanged except for the explicitly allowed build write.

I inspected the committed workflow and verification harness: controls precede project verification; the project is snapshotted from clean committed regular files; dependency/cache/comparator steps are followed by unchanged-input checks; the systemd wrapper denies AF_UNIX; tool receipt hashes are validated; and success requires both Comparator acceptance and default-kernel acceptance. These are evidence of the exercised controls, not a claim of exhaustive sandbox-security assurance.

## Scope and limitations

The mathematical scope remains the original odd `k >= 3` sharp constant `k/4`, with the proved stronger all-`k >= 2` result, arbitrary positive matrix dimension and complex contractions, actual L2 operator norms, CFC absolute value, PSD order, and a genuine infimum over a nonempty set bounded below. The exact 2-by-2 extremizers are covered. The optional Hermitian 3-by-3 strengthening is not claimed. LeanCert supplies kernel-trust audits here; no numerical interval certificate is claimed for this algebraic argument.

`result.json` correctly says the command itself does not perform semantic review; the frozen statement and proof reviews supply that separate scrutiny. Executable hashes and the pinned Forsythe/probe identity are recorded and runtime-checked by the harness; executable files are not in this artifact, so I did not independently recompute binary hashes from retained binaries. GitHub and its hosted runner remain infrastructure trust assumptions. This report binds the original tested commit, not later README/metadata edits. Other projects are outside this verdict.

## Retained log hashes

- `RUN.json`: `8123735d66b2cd542a391f8d90001c0ba4d14b44c8320c0b9c9202ba701f5665`
- `github-run.json`: `b9e20f49989c400fa8351d93953c5d8293b16d89090df4b4a024388b2c2e97d6`
- `github-artifact.json`: `fd12290025e6f7ef2e8671e634ec4a3d059c5cf6529739868ca5f0bf6284e596`
- `artifact/verify-20260914T152927Z-3956/comparator-controls.log`: `ba5fb0a6bef1e394c4159f2bb25580485474a9e742002e16c30ed953ced8ddec`
- `artifact/verify-20260914T152927Z-3956/comparator.log`: `c82de8e35b49cf806d0d5ad89eefa8c1bc0448634be77857cd503f2386dfe2dd`
- `artifact/verify-20260914T152927Z-3956/dependencies.log`: `740fcb700c777ae28e11ddf7c40e50a87ba79bbe97b1a1e1d21a314fea802b4d`
- `artifact/verify-20260914T152927Z-3956/kernel-controls.log`: `ac5884a6a9aab533b23369a1a9a4e453f745264bbaeb2e13d60d94569c45a361`
- `artifact/verify-20260914T152927Z-3956/mathlib-cache.log`: `4bdbc7da67f44f09b17846ed6821556fd32df5b0eb0f193a851f4ab205f1848d`
- `artifact/verify-20260914T152927Z-3956/negative-native.log`: `5e68c2659720636d2d3c78ef973fbf05dc0eeae0fefeacd0dcdba3f166758d36`
- `artifact/verify-20260914T152927Z-3956/negative-sorry.log`: `2822251217bb59261c59a5568d099db4b834a7f7bc60bb4ad8064b780a921dcc`
- `artifact/verify-20260914T152927Z-3956/sandbox.log`: `fec1fdee346853040e1d44e9bd6e15643288cef69cdfc94309a200c6ce037fc5`
- `artifact/verify-20260914T152927Z-3956/user-service.log`: `4700d2ea9f713793f38154d753a4e1aa1ff05342dc9d3ac4cfd5ffde7d53851a`
- `artifact/verify-20260914T152927Z-3956/result.json`: `017b5642b660566c60f0278466c2500d7fd0383ead0003a28229640c940d2c02`
