# Combined integration Linux operational review — PASS

Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_1`, 2026-09-22. Independent collection and operational audit; this does not replace each project's mathematical referee reports.

Actual GitHub run [35691146159](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35691146159) completed successfully: all 35 selected project jobs passed. Event head `83a1a1407d1427dbda6d968a9047b17f2071c229`; actual tested pull-request merge commit `60c105ce368c06ded0cc176419f814db97231e4a`. Every project tree is identical between those commits; shared `tools/lean` and the verification workflow also have no delta. This distinction is retained in the machine receipt rather than conflating the two commits.

I downloaded all 35 original GitHub ZIP artifacts, checked each API SHA256 digest and ZIP CRC, and safely extracted them. Fresh API metadata, original ZIPs, full logs, results and digest receipts are retained. Independently hashed all **17,159 tracked project inputs** (7,183 unique Git blobs) at the actual tested commit and matched every reported input hash, including exact file-set equality. The selected project set equals the independent 35-project inventory exactly. All **284 declared theorem exports** were accepted by actual Comparator and replayed by the Lean default kernel on Linux x86_64 Lean 4.33.1. Source-lock hashes and exact Comparator configurations match Git. No definition holes or axioms beyond propext, Classical.choice and Quot.sound are permitted.

For every project I checked the actual successful build/export/kernel log and all controls: honest kernel fixture accepted; invalid raw proof and quotient post-check mismatch rejected; all five Comparator identity/kind/type/custom-axiom regressions passed; sorry and native-oracle fixtures rejected for the specific illegal axioms. Both build and export sandbox modes passed private user/PID/mount/network/IPC/UTS namespaces, nonroot/no-capabilities/no-new-privileges, host process and socket isolation, outside-write/truncation/symlink defenses, nested-namespace defense, build-only .lake writes, export read-only .lake, and fail-closed unknown/writable-path arguments. Fixtures outside permitted build space remained unchanged. Dependency, cache and sandbox service setup exited successfully. The standalone shared-controls job was skipped by workflow selection, but **each of the 35 actual project jobs ran and passed these controls**; the skip does not substitute for evidence.

The auditor initially could not fetch the GitHub-generated merge commit because the local global Git URL rewrite selected unauthenticated SSH. A command-local configuration override fetched that exact public commit over authenticated HTTPS, without changing global Git settings or any project source. The subsequent full audit passed. This infrastructure retrieval issue was not a Lean failure. NR-03 was the last completing job and passed its full 10-export check; no failed job is concealed.

Scope remains that of each original reviewed target. In particular **MI-08 remains Partial**: the fixed-list equivalence, obstructions, order-12 certificate and dimensions 9–12 minima do not prove its excluded adaptive/general-optimum claims. Operational success does not promote it to full-target verification. No novel mathematics, external human peer review, new author endorsement, or publication-head check is inferred from this run.

Reproducer: `audit_run.py`; machine receipt: `AUDIT-RESULTS.json`. SHA256:

- `audit_run.py`: `fec832d4531b2e26bcc72b563c2bff2aab3c45164941babc67129f21b52ebca0`
- `AUDIT-RESULTS.json`: `8849e97d14e24ccbd90d82e32a3983dd4a83104e0cd54e837f5598f7516f3f26`
- `github-run.json`: `a7053862d608e9737d4e75bfb75086832d990d06bc682aeba1ba90a0dce5cdad`
- `github-artifacts.json`: `2049635390430bd54a07142fb217770b83e2d9c55a7923c47bbe72a3904a3077`
- `downloads.json`: `ab65652b53c945db6e306f235f8a82065174e345a4be5ff8d88ef9fc61fd4f62`

**PASS for all 35 exact tested project trees, 284 exports and retained operational gates.** No operational blocker to the authorized consolidation merge was found.
