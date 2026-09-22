# MI-08 independent Linux operational evidence review

- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, 2026-09-14; independent audit of retained evidence, not human certification.
- Verdict: **PASS** for the actual Linux Comparator, default-kernel replay, controls, and provenance at the immutable commit below. No blocking finding.
- Mathematical scope remains **partial**: fixed-list feasibility for positive d,q and exact minimum twelve for dimensions 9–12. Adaptive equivalence and the all-dimension optimum are not verified; canonical MI-08 remains Partially resolved.

## Fresh GitHub provenance and archive integrity

I independently queried GitHub's run-attempt, artifact and job endpoints using authenticated read-only API calls. The initial restricted-network attempt failed to connect; the approved network retry succeeded. Fresh raw responses are retained as INDEPENDENT-GITHUB-RUN.json, INDEPENDENT-GITHUB-ARTIFACT.json and INDEPENDENT-GITHUB-JOBS.json.

[Run 34862187226](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34862187226), attempt **1**, completed successfully on branch codex/lean-mi08 at commit **a66e142cbe7907db6594ef57c7f542c3d33ad704**. Artifact **10355937198**, named lean-MI-08, is associated with that run/commit and was not expired at inspection. Its API digest exactly matches the independently calculated original zip SHA-256:

`db6d016b47dd8e8bcf81a64ad7faa01df7b270662702578fe9ed2fd89881e80a`.

All **13** non-directory zip entries match the retained artifact extraction byte for byte, with no extra extracted file. I did not treat copied RUN.json assertions as independent verification. INDEPENDENT-INTEGRITY.json records the full archive-entry and input-file comparisons.

## Exact source/configuration correspondence

The actual result.json names the same immutable commit/project and the expected four declarations: fixed_sign_equivalence, design_obstructions, hadamard_twelve and finite_minimums in namespace NLA.MI08. Its configuration exactly matches immutable comparator.json: Challenge versus Solution, no definition replacements, permitted axioms only propext, Classical.choice and Quot.sound.

I checked **all 45 input SHA-256 entries** individually against `git show` at the verified commit and source/project retained bytes. The manifest's file roster equals the complete tracked project roster at that commit, including the hidden .gitignore. At audit time all 45 also matched the working project. Thus retained proof, boundary, reviews, snapshots, configuration, dependency pins and metadata have exact immutable provenance. The source snapshots are separate from the original log zip; they are authenticated here by the immutable git blobs and result hashes, not misrepresented as zip contents.

The proof files are the same hash-bound mathematical bytes covered by the final reviews. Wrapper updates preserve reviewed statement/proof metadata under their snapshots. This audit does not extend the fixed-list mathematical scope or redo those semantic reviews.

I retained immutable copies and hashes of the workflow, source-lock, harness, bootstrap and verify scripts in source/. The result's source-lock hash and tool receipt agree with the immutable lock:
`b3833b07916e5db77579b9cc53ca582282f6a841f36d6a60d693e5b02d342b6b`.
The lock pins Forsythe at `8d1b0c0545a77b40245e84705aa7d273e6c81e62`. The receipt reports Lean4.33.1 on Linux x86_64, its exact Lean commit and tool executable hashes. The dependency log actually checks out LeanCert `621a43d7cf21f87872392a01e874f2f1dbddc926` and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`, matching the source manifest.

## Actual theorem acceptance and all controls

The Comparator log contains both Challenge and Solution exports selecting all four public results. It builds the actual project, records the expected four Challenge placeholders, finishes the Solution build (3584 jobs), then explicitly reports default-kernel acceptance and “Your solution is okay!”, exit zero. The accepted configuration allows only the standard three axioms. This is actual statement/axiom comparison and kernel replay, not merely a local lake build or a semantic-review assertion.

The project verifier runs its controls before snapshotting/building the solution and only writes comparator-accepted after successful controls, comparison, acceptance markers and unchanged-input checks. I inspected that immutable harness control flow and the following original logs:

- `kernel-controls.log`: the honest inductive/quotient fixture is accepted; a raw True proof presented as False is rejected by the default kernel; a corrupted Quot.lift fixture is rejected by the quotient post-check. All three required outcomes pass.
- `comparator-controls.log`: the honest match passes; declaration-kind mismatch and theorem-type mismatch fail at their specified phases; illegal-helper-axiom fixtures fail. All five named cases pass their expected-exit and required-message checks. The two helper-axiom fixture labels share the same rejection mechanism; I do not count them as distinct mechanisms.
- `negative-sorry.log`: rejected for illegal sorryAx, exit one. `negative-native.log`: rejected for the native_decide-generated axiom, exit one. These are expected controlled failures, not failures of the mathematical project.
- `sandbox.log`: actual build and export modes succeed under isolation. Writes/truncation/creation outside .lake and symlink escape writes are denied; build .lake writes are allowed while export .lake writes/truncation are denied. User/PID/mount/network/IPC/UTS namespaces are private; host parent lookup/signalling and loopback access fail; AF_UNIX creation is denied; effective capabilities are empty and no_new_privs is set. Nested namespace write attempts fail. Unsupported options and unexpected/relative writable-path requests each fail closed with exit two. Outer/export fixtures remain unchanged.
- `user-service.log`: the AF_UNIX-denying systemd user-service probe succeeds. Dependency/cache logs finish zero; the main Comparator runs in a fresh temporary project with an empty environment plus explicit allowlisted variables and the strict sandbox wrapper.

Fresh job metadata shows select and the MI-08 verify job succeeded. The separate **checker-controls job is skipped** because the workflow runs it only when shared tools changed. This does not omit this project's controls: verify unconditionally calls run_controls, and all the above actual per-project logs are in the authenticated artifact. The distinction is material and preserved rather than describing every workflow job as executed.

## Limits and publication use

This review authenticates and inspects the actual retained CI evidence; it did not rerun Linux/Lean or rebuild the checker. It relies on GitHub's authenticated API/artifact provenance and the pinned workflow/harness execution. The CI executables themselves are not retained here, so their receipt hashes cannot be independently recomputed from executable bytes; the immutable harness validates them at runtime. Likewise, no claim is made that sandbox probes exhaust every possible operating-system vulnerability. Dependency cache use is recorded and distinguished from the fresh project snapshot and default-kernel replay.

The run proves the accepted four-result configuration at the stated immutable commit. Later publication-wrapper commits are not retroactively that run's inputs; mathematical files and config must remain identical when citing it. This operational PASS, together with the existing independent mathematical reviews, supports publication of the **Lean-verified fixed-list partial result**, with explicit preservation of MI-08's Partially resolved status and source/formalization attribution. It does not verify the adaptive theorem, solve the general optimum, certify source priority, or imply external human endorsement. No proof/publication file was modified by this reviewer.

## Additional evidence hashes

- `INDEPENDENT-INTEGRITY.json`: `a35785eb86dae7639e1efcbc64a7291aa6d81c89546b0f2402d42b3aa52b22e1`
- `INDEPENDENT-GITHUB-RUN.json`: `681c1761bd1f65f5adb2400b036a47f15dbcbd9d4859e623c4a480d3a6566b40`
- `INDEPENDENT-GITHUB-ARTIFACT.json`: `9189a5aa008096190955ad3aa8717aa096eed924cb1b04e881665c5df0c0dd42`
- `INDEPENDENT-GITHUB-JOBS.json`: `cba7089e44b2f1009b78b4430737caa591e77378c87c684c36712c4ac8e86c1b`
- `artifact/verify-20260914T152834Z-3966/result.json`: `31935e7601267f899b0fa959cff170addf6bcdeb11ee5f6b17d3a93700d1343b`
- `artifact/verify-20260914T152834Z-3966/comparator.log`: `0192245a19d6dfeb19e6cbec90d3c0d6e3adf0ae8ac0cf6d8368f9403bef0659`
- `artifact/verify-20260914T152834Z-3966/kernel-controls.log`: `ac5884a6a9aab533b23369a1a9a4e453f745264bbaeb2e13d60d94569c45a361`
- `artifact/verify-20260914T152834Z-3966/comparator-controls.log`: `bbb47df1786a00af9fa612926dd8727edc89ca26081cd96f16051cbdf189902b`
- `artifact/verify-20260914T152834Z-3966/sandbox.log`: `2f0222199e2e3a0b0914563cc415bad2d0d9e240625185a26e2e85f076bcc738`
- `artifact/verify-20260914T152834Z-3966/negative-sorry.log`: `03e1c308b43e5a5fc4a03e948a611915a0c02998615617859d10ff1b7ed33535`
- `artifact/verify-20260914T152834Z-3966/negative-native.log`: `7c13dfef99cce647f5042d4e878c97cf007153fc3c811b634abb4dc3f9663aca`
