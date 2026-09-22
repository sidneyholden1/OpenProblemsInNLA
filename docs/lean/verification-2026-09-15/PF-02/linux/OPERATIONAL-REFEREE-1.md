# PF-02 operational referee 1

**PASS** for the retained actual Linux run [34921326342, attempt 1](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34921326342) at immutable commit `61dae15457a532be05a9a54d8e1e4040fbefddbd`.

Reviewer: `/root/iv06_statement_referee_1`, an AI agent. I coauthored PF-02's StructuralBase/Structural implementation. This is an operational audit independent of the coordinator's evidence collection, **not an independent mathematical review of my own code**. The two separate final code reviews remain the mathematical-review evidence. I did not modify proof, statement, or publication files and did not rerun Linux verification.

## Source and artifact correspondence

I read the original retained ZIP and tested its CRCs; all 13 non-directory archive entries match their extracted bytes. Its SHA-256 is `812b74dadcc9c25e7257b9b7bea6836d6644743d3db6336f3049a7878448ad01` (16,624 bytes), matching both retained and independently refreshed GitHub artifact metadata for artifact `10378546659` (`lean-PF-02`). Fresh read-only GitHub API calls independently confirmed run ID, successful first attempt, immutable head commit, artifact identity and digest. The retained jobs metadata records the actual verification job on `ubuntu-24.04`; the tool receipt records Linux x86_64 and Lean 4.33.1, not macOS.

I independently recomputed **all 57** `result.json` input hashes from `git show` at the immutable tested commit. Every hash matches. All 14 retained active source/config snapshots also match these bytes. The comparator configuration is identical to the one in the result receipt: nine distinct declarations, no definition exceptions, only `propext`, `Classical.choice`, and `Quot.sound` permitted. I also verified that the harness, workflow and source lock I inspected match the tested commit. The source-lock SHA is `b3833b07916e5db77579b9cc53ca582282f6a841f36d6a60d693e5b02d342b6b`; it pins Forsythe tools at `8d1b0c0545a77b40245e84705aa7d273e6c81e62`.

The inspected harness constructs a fresh project from ordinary tracked Git blobs, rejects tracked build artifacts/symlinks, validates immutable dependency/configuration inputs, verifies tool/source receipts, and checks source bytes unchanged around dependency acquisition and Comparator execution. The actual log shows a fresh Challenge build, all active PF-02 proof modules built, and Solution built successfully (3592 jobs). Pinned public dependency downloads and the official Mathlib cache were used; this was **not** a full dependency-source rebuild.

## Actual acceptance and control results

- `comparator.log` exports the same nine named Challenge and Solution declarations, prints standard-three axiom closure for each, runs the default Lean kernel, records kernel acceptance and `Your solution is okay!`, and exits 0. Its SHA is `fdaac0ba9bc8d39524ddebb7465925019cba0c931594c17372723104d7384b8a`. Challenge's nine deliberate placeholders are expected statement fixtures; Solution was accepted separately. Numeric has harmless unused-tactic/simp warnings, so this report does not call the run warning-free.
- All three actual kernel replay controls passed: an honest inductive/quotient fixture accepted, a raw invalid proof rejected by the kernel, and a malformed quotient constant rejected by the post-check.
- All five Comparator regressions passed with their expected phases/statuses. The actual outputs cover acceptance, constant-kind mismatch, illegal helper axiom, and theorem-type mismatch. Two named fixtures reject the same illegal helper axiom; I do not portray their names as proving distinct unseen behavior.
- Fresh `sorry` and `native_decide` fixtures both built and were rejected at export/comparison with exit 1 for `sorryAx` and `checked._native.native_decide.ax_1_1`, respectively. These are successful negative controls, not failed PF-02 proofs.
- Real sandbox probes passed for build and export modes: writes/truncations/creation outside `.lake` denied, symlink escape writes denied, designated build `.lake` write allowed, export writes denied; user/PID/mount/network/IPC/UTS namespaces private; host parent absent from `/proc`; host signaling lookup and loopback access denied; AF_UNIX creation denied; effective capabilities absent and `no_new_privs` set; nested namespace write attempt rejected. Unsupported and expanded writable-path options exited 2. Outer/export fixtures remained byte-identical.
- The separate workflow `checker-controls` job was skipped because shared tooling did not change. **Per-project** user-service, sandbox, kernel, Comparator and negative-axiom controls actually ran and passed inside this PF-02 verification; the skip is not being counted as a successful execution.

The complete exported set is: `psd_rank_semantics`, `congruence_quotient_semantics`, `witness_exact_data`, `trace_coordinate_bridge`, `congruence_coordinate_identity`, `orientation_invariant`, `quotient_orientation`, `disconnected_counterexample`, and `not_connectedOrbitConjecture`, all under `NLA.PF02`.

## Limits and binding

This establishes operational correspondence for the exact tested commit and retained artifacts. It does not independently re-prove semantic fidelity, assert human peer review, exhaustively establish operating-system security, or extend acceptance to later source changes. Tool executable hashes are retained Linux receipts; I did not reproduce those binaries locally. Publication-wrapper changes may occur later and must continue to cite the immutable tested proof bytes honestly.

Independent script result: all 57 Git inputs, 13 archive entries, nine exports and all enumerated controls passed; refreshed GitHub identity/digest match. Detailed per-input, per-log and metadata hashes are in the attached evidence JSON.

## Review evidence SHA-256

- `RUN.json`: `a47dd27fdf6919dc2bee15ed3687e374f391b5f1189d8e61358428a2d495859d`
- `github-run.json`: `48f767193368ce94d67928d418b3daa0aa6144d495a96c76a71f433c7eb7a07e`
- `github-artifact.json`: `bb9adf2e345a51b1ddbdf2b05e0886e0f35f40c471374a2a2f826f2cd3061474`
- `github-attempt-jobs.json`: `7cf2a4cb8df8107805f88097d352ea2719063895c881e2368023d7c3863a6da9`
- `referee-1-live-run.json`: `da87e0ba86ab1d8cdb094c832366f804a2d788fc9fc6294574468e4347e0c71d`
- `referee-1-live-artifact.json`: `954213a4445c50d566bbb470d3c574b2ac27a1f7899eb002b764c7ce11ebeba8`
- `referee-1-operational-check.py`: `64ee6d2832522a3d550b0654b24ddbb7801fc6e8bfb2de96576a8cbca90868f6`
- `referee-1-operational-check.log`: `be3ee8b015d177ee72b74f8bfe93714490509fe3690e2a0f9fc84ea7a8a5f3fa`
- `referee-1-operational-evidence.json`: `bdebaa9161fe6bba22051ad3c69faa5656234242b2bf935000de92fdefeff4d0`
- `artifact/verify-20260915T023008Z-4834/result.json`: `346d960b385ec337e26b6ffafc3be35305d928800090d5cbaa477f2108dd8ed8`
