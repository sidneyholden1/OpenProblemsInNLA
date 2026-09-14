# IV-06 Linux verification: independent operational review

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent.
- Date: 2026-09-14.
- Verdict: **PASS for the recorded immutable input commit and artifact**. The actual Linux sandbox, theorem comparison, axiom rejection and kernel-replay gates ran successfully. This is an operational evidence audit, not a replacement for mathematical referee review.
- Verified input commit: `23dd1e1727494efac35743826c0725ebc71942c6`.
- GitHub run: [34805467886, attempt 2](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34805467886/attempts/2).
- Artifact: `lean-IV-06`, GitHub artifact ID `10333241003`, 14,648 bytes.
- Archive SHA-256: `16e7977c56a6e51d668e7a8753f9d773fe91fe6da7af4d2831eba82cb0adc0ff`.

## Provenance checks performed independently

I queried the GitHub Actions API directly. It records attempt 2 as completed/success on the stated commit, updated at `2026-09-14T04:28:27Z`. The artifact API reports the same commit, artifact name/ID/size, and archive digest, with the artifact not expired at audit time. I computed the local original ZIP's SHA-256 and matched it to GitHub's digest. I compared every one of its 13 file entries against the extracted `artifact/` bytes; all matched.

I read `artifact/verify-20260914T042254Z-4070/result.json` and checked all 26 `input_sha256` entries against Git blobs at the immutable commit. Every hash matched. Enumerating that commit's entire tracked IV-06 Lean project found no input omitted from the hash map. Thus the receipt covers the mathematical sources, Challenge/Solution, package pins, reviewed target text, referee files, configuration, and then-current documentation wrappers, rather than merely a selected theorem file. The source-lock hash also matches the immutable commit: `b3833b07916e5db77579b9cc53ca582282f6a841f36d6a60d693e5b02d342b6b`.

The receipt identifies real Linux execution: Lean 4.33.1 `x86_64-unknown-linux-gnu`, Linux `6.17.0-1022-azure`, Go 1.27.1 `linux/amd64`. The checker sources are pinned to Forsythe commit `8d1b0c0545a77b40245e84705aa7d273e6c81e62`; the receipt records executable hashes for Comparator, lean4export and Landrun, as well as the environment and adapted CI probe. This review inspected the Linux evidence from a macOS workspace; it makes no claim that the Linux sandbox ran on macOS.

I inspected the verification harness and workflow, checking their bytes match the immutable commit. Their SHA-256 values are respectively `f81767a17973956fbe9e5765c664d4639cce15ddf8c106f70cdcb32151808c2f` and `2c3963089483ec5e7e35e6355fa60988778e0b439ce099d7cd7050a8c3b6467c`. The harness snapshots ordinary tracked Git blobs into a fresh project, rejects tracked build artifacts/symlinks, checks source hashes after dependency setup/cache loading and after Comparator, and writes acceptance only after required controls and kernel-success markers. I also read the strict sandbox adapter and verified that its preserved bytes match the pinned source-lock digest `4d6172274dd6109b1171dc01548512aa1af31f1e8fed88aa40b3c8b831345e1c`.

## Actual isolation and rejection evidence

The complete `sandbox.log` records successful probes in both build and export modes. Writes, truncation, creation and a `.lake` symlink escape outside the allowed build area were denied. Build mode allowed its designated `.lake` write; export mode denied `.lake` writes and truncation. User, PID, mount, network, IPC and UTS namespaces were private. The host parent was absent from private `/proc`, parent signal lookup failed, the host loopback listener was unreachable, and AF_UNIX socket creation was denied. Effective capabilities were empty, `no_new_privs` was set, and nested namespace write attempts failed. Unknown sandbox options and unexpected/relative writable paths were rejected with exit 2. The fixtures confirmed only the designated build file changed.

These results agree with the inspected adapter: bubblewrap supplies a read-only host mount and private process/network/device environments, exposes only the current build's `.lake` when required, drops capabilities, and wraps the official Landrun invocation. The outer systemd service denies AF_UNIX creation. This is observed enforcement for the recorded host and tested operations; it is not a claim that every possible escape technique was exhaustively tested.

The complete `comparator-controls.log` shows the honest match accepted, a constant-kind mismatch rejected, illegal helper-axiom cases rejected, and an actual theorem-statement mismatch rejected. All five named regressions returned the expected exit and phase. The two helper-axiom labels are not counted here as two different security mechanisms. `negative-sorry.log` rejects `sorryAx`; `negative-native.log` rejects the generated `checked._native.native_decide.ax_1_1` axiom. Both reject after building/exporting the corresponding Solution, not through an unrelated setup failure.

The complete `kernel-controls.log` exercises the real `Comparator.runBuiltinKernel` path: an honest fixture containing inductives and quotients is accepted; an invalid raw proof with type `True` where `False` is expected is rejected by the kernel; a deliberately mismatched `Quot.lift` is rejected by the quotient post-check even after kernel acceptance. All three cases completed with their required outcomes.

## IV-06 theorem identity and kernel acceptance

The complete `comparator.log` builds and exports separate Challenge and Solution environments for exactly these four declarations:

- `NLA.IV06.included_points`
- `NLA.IV06.excluded_separators`
- `NLA.IV06.counterexample`
- `NLA.IV06.not_componentBoundConjecture`

The configuration supplies no definition holes and permits only `propext`, `Classical.choice`, and `Quot.sound`. The fresh Challenge build has exactly its four intentional placeholder warnings. The fresh Solution build reaches 2,918 jobs, including the actual LeanCert modules, IV-06 Proof and Solution, with no Solution-placeholder warning. Comparator then reports `Running Lean default kernel on solution.`, `Lean default kernel accepts the solution`, and `Your solution is okay!`, followed by `EXIT_STATUS=0`. The receipt records `comparator-accepted`, with the same four exported names and input hashes reviewed above. This demonstrates successful comparison and replay, not merely successful Lean compilation.

## First-attempt failure retained

I independently queried [attempt 1](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34805467886/attempts/1): GitHub records completed/failure on the same commit. Its failed-job log shows bootstrap reporting `<urlopen error [Errno 104] Connection reset by peer>` at `2026-09-14T04:19:00Z`, exit 2, followed by an upload warning that no logs artifact existed. The first attempt therefore did not supply mathematical or sandbox acceptance evidence. Attempt 2 is a successful retry on unchanged input; its success does not erase that operational failure.

## Scope and remaining limitations

This approval binds the immutable input commit and original archive, including their exact mathematical boundary and proof bytes. Later README, formalization manifest, or publication-wrapper edits are not byte-for-byte inputs to this run and must be identified as subsequent changes. Any mathematical source/configuration change requires a new relevant verification run. Public dependency caching is part of the recorded harness; this was a fresh project-source build, not a claim that every dependency was rebuilt from source without caches.

The original archive contains logs and a hash/receipt manifest, not copies of all project source blobs or the checker executables. Source correspondence was independently checked against the local Git object database at the GitHub-confirmed commit. Executable digests were inspected as recorded provenance; this audit did not independently reconstruct the Linux binaries. Trust remains in GitHub artifact delivery, the pinned toolchain/checker and its foundational axioms, and the host enforcing the measured controls. The automated receipt explicitly says semantic review was not performed by that command; the separate statement/proof referee reports supply that review. No new Linux execution or mathematical code edit was performed by this operational referee.
