# IE-05 independent Linux operational review

Verdict: **PASS** for all four configured declarations at immutable commit `df2cf7a721843c0d674e8377d435eb5750f06fff`.

Reviewer: independent AI referee 1. Date: 2026-09-14. This audit checks original Linux operational evidence and supplements the retained statement and proof reviews. No proof build was rerun; no proof or publication file was modified.

## Original run and source identity

Run [34862178699](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34862178699), attempt 1, is an actual successful Linux push run at the commit above. I independently queried GitHub's current run and artifact APIs. Their run ID, attempt, completed/success status, commit and workflow identity match the saved metadata. Artifact `10356022360`, `lean-IE-05`, is unexpired, attached to this run on `codex/lean-ie05`, and has SHA-256:

`9df0dab0d55d61c323a145b87c5f98b4b66dcc62ceeff1cee3eaa4f33b960bc5`.

I independently recomputed this original ZIP digest, matching both current and saved API metadata; ZIP CRC checking passes. All 13 archive paths are safe relative paths, and all retained extracted bytes match their original archive members. All 40 project input snapshots independently match both the SHA-256 entries in `result.json` and exact `git show` bytes at the tested commit. The immutable project tree contains exactly 40 files. The source-lock receipt independently matches the committed source-lock bytes: `b3833b07916e5db77579b9cc53ca582282f6a841f36d6a60d693e5b02d342b6b`.

## Theorem comparison and kernel

The actual `comparator.log` records successful separate Challenge and Solution builds, with 2380 and 3581 jobs respectively. It exports these same four declarations from both environments:

- `NLA.IE05.qr_certificates`
- `NLA.IE05.pivot_certificates`
- `NLA.IE05.growth_separation`
- `NLA.IE05.counterexample`

The configuration has no definition holes, and permits only `propext`, `Classical.choice`, and `Quot.sound`. The transcript explicitly runs the Lean default kernel, records “Lean default kernel accepts the solution” and “Your solution is okay!”, and exits zero. The retained, input-hash-bound axiom log lists exactly those three standard axioms for every export. Challenge's four intentional placeholders are confined to the statement environment. Solution has only nonblocking tactic-style/deprecated-notation warnings, with no proof-placeholder warning.

The runtime receipt records Lean 4.33.1 on x86_64 Linux and the Ubuntu workflow is bound to the tested commit. This gate is established by the actual Linux run, independently of the earlier local macOS proof reviews.

## Rejection and isolation controls

I read this run's actual kernel, Comparator, negative-axiom, sandbox and user-service logs. All prescribed controls pass. The honest kernel fixture with inductives and quotients is accepted; an invalid raw proof is rejected by the default kernel; a quotient mismatch is rejected by the additional quotient postcheck. The five Comparator regressions accept the matching case and reject the constant-kind, added-axiom and theorem-type failures. The fixture named `simple_kind_mismatch` is specifically rejected for its unexpected `helper` axiom, so that fixture is not represented as independently testing every kind mutation. Separate negative fixtures explicitly reject `sorryAx` and `checked._native.native_decide.ax_1_1` with expected exit status 1.

Both build and export sandbox probes deny outside writes, file creation, truncation and symlink escape. The designated build `.lake` write succeeds, while export `.lake` writes and truncation fail. Private user/PID/mount/network/IPC/UTS namespaces, blocked host-parent process visibility/signalling, blocked host-loopback access, denied AF_UNIX sockets, empty effective capabilities and `no_new_privs` are observed. Nested namespace writing fails. Unsupported unrestricted-filesystem and unexpected/relative writable-option requests are rejected. Outer and export fixtures remain unchanged, apart from the explicitly allowed build write. The systemd user-service smoke check succeeds.

The committed workflow, bootstrap and harness were independently compared byte-for-byte with the MI-03 immutable versions reviewed in this same audit session and are identical. Those inspected controls validate pinned tools, run all rejection/isolation probes before project verification, construct fresh committed-file snapshots, check unchanged inputs after dependency/cache/comparator operations, and require explicit Comparator and default-kernel acceptance. This is bounded evidence for the exercised controls, not a claim of exhaustive sandbox security.

## Mathematical publication scope

I reread the tested Challenge, complete numerical boundary, retained final referee report, README and manifest. The accepted target is the complete original universal extremizer equality negated by George Stepaniants's order-eight counterexample to John Peca-Medlin's conjecture. Both actual positive-diagonal QR factorizations and their first-available-tie GEPP paths are covered. Actual row swaps and Schur recurrence define admissible paths; the supremum includes every real orthogonal matrix and every admissible tie path. The denominator is the actual maximum input-entry magnitude, growth includes every intermediate entry, and the real supremum's set is explicitly nonempty and bounded above.

The proved one-sided bounds are candidate growth at most `sqrt(17948132/2601)` and witness growth at least `5272/63`, with strict separation and a strict gap below the genuine supremum. These suffice for full negation. Exact source stage tables, an exact true orthogonal supremum, and a separate asymptotic conjecture are not claimed. The source credits and disclosed formalization assistance remain intact. LeanCert's two rational kernel point cuts and four trust audits are supported by the retained mathematical review and the actual accepted proof closure; no numerical oracle is advertised.

## Limits and retained hashes

The command truthfully records `semantic_review: not-performed-by-this-command`; separate frozen statement and final proof reviews provide that scrutiny. This report closes the Linux operational gate for the tested bytes. The input README/manifest still say Linux was pending because they predate this run; later status-only edits must retain this original receipt and commit binding. No assertion is made here about other project runs or later changed proof bytes. Tool executable and pinned probe digests are recorded and runtime-validated by the harness, but binaries themselves are not retained in the ZIP and were not independently rehashed by this reviewer. GitHub and hosted-runner infrastructure remain trust assumptions.

- `RUN.json`: `01fe28c0a690dd70c29b0a9e7aa35473d91589ac3f28c807a4de85c8e6a6ca00`
- `github-run.json`: `c9e16ad422979821b81db7aaaac0f3b5528ac000b2582bc4c6d49b3887ac2fcc`
- `github-artifact.json`: `85605d5e8758a0f7cea359bcf730585caba131c1aaa5207f377994d69c8efad8`
- `artifact/verify-20260914T152925Z-3957/comparator-controls.log`: `ebd3e1561f6618ce55b885293395216de456457404ec415a059f0375cf6d53f9`
- `artifact/verify-20260914T152925Z-3957/comparator.log`: `ffe79e273f3b315d89aa092df7051bbf392fe151bf8f631ef954a939c01ee101`
- `artifact/verify-20260914T152925Z-3957/dependencies.log`: `740fcb700c777ae28e11ddf7c40e50a87ba79bbe97b1a1e1d21a314fea802b4d`
- `artifact/verify-20260914T152925Z-3957/kernel-controls.log`: `ac5884a6a9aab533b23369a1a9a4e453f745264bbaeb2e13d60d94569c45a361`
- `artifact/verify-20260914T152925Z-3957/mathlib-cache.log`: `f2be99b522ba6fb7d9a79b3b27852ef9d816dba126dc5ba4139d9be1c29de84f`
- `artifact/verify-20260914T152925Z-3957/negative-native.log`: `8f8dfb2fce0f48ee84af9e2e9f7580078ba72f7be1c460aefbbbd858b898f399`
- `artifact/verify-20260914T152925Z-3957/negative-sorry.log`: `d0ddeaa4523ea446dfa7886a014594bfcd1843da2d1ef11bce0d2f9dce4dcc70`
- `artifact/verify-20260914T152925Z-3957/sandbox.log`: `0969da2cfe996b4c5321630421c7726a56f33722bf18d5e49790b5132ed9d3fd`
- `artifact/verify-20260914T152925Z-3957/user-service.log`: `4700d2ea9f713793f38154d753a4e1aa1ff05342dc9d3ac4cfd5ffde7d53851a`
- `artifact/verify-20260914T152925Z-3957/result.json`: `416c8be39208c8cc09367240052806da45c48e63a37a97fa9d0fd201df391457`
