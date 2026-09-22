# IE-17 independent Linux operational review

Verdict: **PASS** for all four configured declarations at immutable commit `d45afc8a197ffeeff94abfca59ef93acda22efa5`.

Reviewer: independent AI referee 1. Date: 2026-09-14. This audit examines the original Linux evidence, supplementing the separate retained mathematical reviews. No proof build was rerun; no proof or publication file was changed.

## Immutable original evidence

I independently queried the GitHub run and artifact APIs. Run [34862174739](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34862174739), attempt 1, is completed/success at the commit above, triggered by a push of `codex/lean-ie17` through the retained Lean workflow. Artifact `10355407347`, `lean-IE-17`, is unexpired and bound to the same run/commit. Fresh API metadata agrees with the retained metadata.

The independently recomputed original ZIP SHA-256 matches both API records:

`cabb0de314a49e4f9f427a754d77aad55f8a7d0bf375bbee48d40bba7b9b423a`.

ZIP CRC validation passes. All 13 archive paths are safe and relative, and each extracted retained member is byte-identical to its original archive member. I independently checked every one of the 35 input snapshots against both its recorded SHA-256 and exact `git show` bytes at the tested commit. The complete committed project tree contains 35 files. The source-lock digest independently matches the committed bytes: `b3833b07916e5db77579b9cc53ca582282f6a841f36d6a60d693e5b02d342b6b`.

## Theorem identity and default kernel

The actual Comparator transcript shows separate successful Challenge and Solution builds, 2711 and 3677 jobs respectively, followed by matching exports of:

- `NLA.IE17.iterates`
- `NLA.IE17.backward_increase`
- `NLA.IE17.approximation_increase`
- `NLA.IE17.counterexample`

There are no definition replacement allowances, and the only permitted axioms are `propext`, `Classical.choice`, and `Quot.sound`. The transcript explicitly runs the Lean default kernel, records “Lean default kernel accepts the solution” and “Your solution is okay!”, and exits zero. The input-hash-bound axiom audit lists exactly these three standard axioms for each export. Challenge's four intentional placeholders belong to its separate statement environment. Solution only emits two nonblocking deprecated-notation warnings in Approximation; no Solution placeholder warning appears.

The receipt identifies Lean 4.33.1 on x86_64 Linux; the tested workflow uses Ubuntu. This is an actual Linux acceptance record, not a claim inferred from local macOS elaboration.

## Actual controls and harness

I inspected this run's kernel, Comparator regression, negative-axiom, sandbox and user-service logs. The honest inductive/quotient replay succeeds, the malformed raw proof is rejected by Lean's default kernel, and the quotient mismatch is rejected by the additional postcheck. All five Comparator regression expectations pass: the matching solution is accepted and the constant-kind, unexpected-axiom and theorem-statement failures are rejected. The fixture named `simple_kind_mismatch` is rejected for the logged `helper` axiom; its name is not treated as evidence for every possible constant-kind mutation. Separate controls reject `sorryAx` and `checked._native.native_decide.ax_1_1` with the expected exit status 1.

Both sandbox modes block outside writes, creation, truncation and symlink escape. Only the designated build `.lake` write is allowed; export writes are denied. Logs show private user/PID/mount/network/IPC/UTS namespaces, blocked host-parent process visibility/signalling, blocked host-loopback communication, denied AF_UNIX sockets, no effective capabilities, and `no_new_privs`. A nested namespace write attempt fails. Unrestricted-filesystem, unexpected writable and relative writable options are rejected. Outer/export fixtures remain unchanged apart from the explicitly permitted build write. The systemd user-service smoke check passes.

I independently compared the committed workflow, bootstrap, harness and source-lock bytes with the MI-03 versions inspected earlier in this same audit session; they are identical. The inspected harness runs controls before verification, validates pinned tools and receipt hashes, snapshots committed regular files into a fresh directory, checks unchanged inputs after dependency/cache/comparator steps, uses the AF_UNIX-denying systemd wrapper, and requires both explicit Comparator and default-kernel acceptance. These are the actual exercised checks, not an exhaustive sandbox-security claim.

## Faithful publication scope

I reread the accepted Challenge, complete numerical target and retained independent proof review. The result proves two separate negations, covering both original counted-together questions. The real, undamped, zero-initial-guess LSMR model uses exact Krylov normal-residual minimization with the minimum-length convention, actual Euclidean vector and rectangular L2 operator norms, fixed right-hand side, and perturbations of A only. The explicit 4-by-3 matrix is full column rank, and both displayed successive iterates and their normal residuals are nonzero.

For the actual spectral backward-error infimum, both minima are attained and the proved bounds are `mu(x1) <= sqrt(1979/2000)` and `sqrt(99/100) <= mu(x2)`, yielding strict increase. These bounds are not advertised as exact backward-error values. The lower bound covers every feasible perturbation, including a zero new residual, as detailed in the retained mathematical review. The projected approximation uses the actual stacked matrix and Moore–Penrose inverse, with all four identities verified. Its two exact squared rational values and strict increase are among the compared exports. The final theorem separately negates monotonicity for each error, rather than merely negating their conjunction.

LeanCert's rational kernel point cuts and trust audits are supported by the retained proof review and accepted proof closure. Credits remain Colbrook for the mathematical counterexample, Fong and Saunders for the questions, and Holden with disclosed Codex assistance for formalization. No Frobenius-error conclusion, perturbed-right-hand-side model, external human certification or new priority claim is inferred.

## Limits and retained log hashes

`result.json` correctly records that the command itself does not perform semantic review. Separate frozen statement and final proof reviews supply that part of the assessment. This report closes the operational Linux gate for the immutable tested bytes; earlier pending-language metadata is a historical snapshot and can be updated with this receipt retained. Later changed proof bytes and other project runs are outside this verdict. Tool executable/probe hashes are recorded and runtime-checked by the harness, but binaries are absent from this ZIP and were not independently rehashed by this reviewer. GitHub and hosted-runner infrastructure remain trust assumptions.

- `RUN.json`: `7f770f8a9a186e0e10cd244998ae62427d85fba00d7b4ed59d9b4683e67a1884`
- `github-run.json`: `04b416e924a5b494311195f4cb9c783d07b0fd155552cf3ffd90a9430efcae82`
- `github-artifact.json`: `a9034463379d34216facad170f0984a641a5fe1c486cfc1e6a33e76f418b8e5a`
- `artifact/verify-20260914T152936Z-3933/comparator-controls.log`: `0b13a4d388b746057bb2984b69feb62115ff3b45d00e12b6b76ddd6ff84fc143`
- `artifact/verify-20260914T152936Z-3933/comparator.log`: `09789b3079aa93eca1780464959b4b8c141d9365c8aa852eaa0dc0a368d89198`
- `artifact/verify-20260914T152936Z-3933/dependencies.log`: `740fcb700c777ae28e11ddf7c40e50a87ba79bbe97b1a1e1d21a314fea802b4d`
- `artifact/verify-20260914T152936Z-3933/kernel-controls.log`: `ac5884a6a9aab533b23369a1a9a4e453f745264bbaeb2e13d60d94569c45a361`
- `artifact/verify-20260914T152936Z-3933/mathlib-cache.log`: `983de0be98ac2d909b053b3b1c47a2c2c95efd84de3cbece84b07e6ad2bcc0ae`
- `artifact/verify-20260914T152936Z-3933/negative-native.log`: `6de45ff8be55677f664f11c66f68c7b610286e17a1f45213cb2e8019fae62928`
- `artifact/verify-20260914T152936Z-3933/negative-sorry.log`: `a9c3f50cf4677e81d859a3aaaa9660776041843300fb1557122ff807642131af`
- `artifact/verify-20260914T152936Z-3933/sandbox.log`: `89475cbc023ddc6337a56602d274a3889cb391721ad2b7aa8c542e04498a525d`
- `artifact/verify-20260914T152936Z-3933/user-service.log`: `4700d2ea9f713793f38154d753a4e1aa1ff05342dc9d3ac4cfd5ffde7d53851a`
- `artifact/verify-20260914T152936Z-3933/result.json`: `8c5f6e9b06df53689e142730fdc3f5f644b004764e85b5803fe39f8b48f32ac9`
