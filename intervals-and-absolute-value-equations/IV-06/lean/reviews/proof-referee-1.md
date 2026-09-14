# IV-06 independent proof referee 1

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent; not the proof implementer.
- Date: 2026-09-14.
- Phase: final mathematical correctness, original-target fidelity, certificate integration, topology and transitive axioms.
- Protocol: `docs/lean/REVIEW.md`, applying its Tau Ceti correctness/scope standards. This is not human peer review or an official Tau Ceti service result.
- Verdict: **APPROVE on the source hashes below**. No mathematical corrections requested. Linux sandboxed Comparator remains a separate uncompleted gate at review time.

## Reviewed source identity

Paths are relative to this Lean project. Canonical problem/manuscript identities and full pre-proof scope review are recorded in `statement-referee-1.md`; the approved boundary hashes remain unchanged.

| File | SHA-256 |
|---|---|
| `NLA/IV06/Proof.lean` | `965874d9b3311ec29edc9d6f79e92df950c4e66a072b7d88351adc3648aa4e36` |
| `Solution.lean` | `0ec0a35417c1ad929087daaabdf39b6a9f54235fcbc166cdf7d9b12e392dd421` |
| `NLA/IV06/Definitions.lean` | `880ca2f1b14e420ccb613fa560668d9d560329f2901421772fbe68a765aab0f7` |
| `Challenge.lean` | `b81665e31d3b971929e00d1096788accc9943ffd2c3bc947c0481460e9497ff1` |
| `NUMERICAL_TARGETS.md` | `631d38fec203c0da5dc57be09320df336049362718c43903788fba8a9d13fc8d` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lakefile.toml` | `dbf2f6562944c0730e262b80bea86abf6e5950684fe093af984cfbeab0a1029a` |
| `lake-manifest.json` | `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08` |

Toolchain is Lean 4.33.1, with LeanCert `621a43d7cf21f87872392a01e874f2f1dbddc926` and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`.

## Mathematical proof inspection

I read the entire proof and Solution, rather than accepting build output as semantic evidence. The representation lemma derives the seven fixed entries of an arbitrary interval-family matrix from both weak entrywise bounds; its two free entries are unconstrained except for their original independent intervals. Thus subsequent elimination applies to every admissible matrix, not just selected witnesses. `eigen_equations` derives all three scalar equations from an actual nonzero real eigenvector. Each supplied integer eigenpair matches the manuscript and satisfies both parameter bounds. Nonzero-vector obligations are explicitly discharged.

At `-1`, the second and third equations force coordinates 0 and 2 to vanish, and the negative upper bound on `a` excludes `a = 0`. At `1`, the third and second equations force coordinates 0 and 1 to vanish, and the positive lower bound on `b` excludes `b = 0`. At `12`, the exact identities `v0 = 13 v1`, `v2 = (13/11)v1` produce `(1859 + 11a + 13b)v1 = 0`. The corrected lower bounds make the coefficient strictly positive. The argument never divides by a coordinate, never assumes a vector sign, and checks all three coordinates before contradicting nonzeroness. The earlier statement-review finding about upper versus lower bounds is fully resolved in the actual proof.

`separator_margin` is used in the exclusion proof's positivity step. Inspection of its elaborated proof term shows a real call to `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked`, certifying constant zero below 150 on the singleton interval `[0,0]`; exact normalization transports this to `0 < 1859 + 11*(-166) + 13*9`. I inspected that validity theorem in `LeanCert/Validity/DyadicBounds.lean`, the point-inequality tactic route, and the kernel invocation examples in `LeanCert/Test/TrustModes.lean`. Monotonicity removes parameter uncertainty before certification. No sampling, floating eigenvalue approximation or subdivision claim is used.

I checked Mathlib's actual `IsPreconnected.Icc_subset` in `Topology/Order/IntermediateValue.lean`: it is the intermediate-value theorem applied to the identity function. Together with the component membership, preconnectedness and subset APIs inspected during statement review, `separated_components` establishes genuine inequality of connected-component sets. Its weak ordering assumptions are harmless because the excluded separator cannot equal either included endpoint. All six required pairs are covered: `(-3,0)`, `(-3,3)`, `(-3,25)` use separator `-1`; `(0,3)`, `(0,25)` use `1`; `(3,25)` uses `12`. The finite component subset therefore has ENat cardinality four, and cardinal monotonicity gives the full lower bound. There is no hidden finiteness assumption on the complete collection. Endpoint ordering is explicitly proved, then the universal conjecture is specialized to dimension three, yielding the impossible ENat inequality `4 ≤ 3`.

The definitions preserve the full original independent-entry real eigenvalue target, including singleton entries and arbitrary positive dimensions. Solution exports the same four signatures as Challenge and imports only Proof. No symmetry or other extra hypothesis is introduced, and no exact component count is asserted.

## Independent mechanical checks

With the pinned runtime on PATH, I independently ran `lake env lean NLA/IV06/Proof.lean` and `lake env lean Solution.lean`; both returned exit 0 with no diagnostics. These runs re-elaborate the actual sources and execute their kernel-trust assertions. I also ran a separate temporary Lean audit importing Solution and printing the transitive axiom closures of the four public exports and `separator_margin`. Every closure was exactly:

`[propext, Classical.choice, Quot.sound]`.

There was no `sorryAx`, custom axiom, native-decide/compiler-trust axiom, or dependency on Challenge. I inspected LeanCert's `#assert_trust` implementation: it calls Lean's `collectAxioms`, classifies these three foundational axioms, and rejects sorry/custom/native dependencies in kernel mode. The independently printed closures corroborate the assertions. The audit also printed the actual certificate proof term described above. These are checks I ran directly, not claims copied from an author's verification log.

## Remaining limits

This report approves mathematical correctness and local kernel verification on the identified bytes. I did not run Linux sandboxed Comparator, inspect a completed remote CI run, or review final catalog/metadata publication status. Those gates must be recorded separately and must not be represented as completed by this approval. The standard foundational classical axioms remain part of the trusted base. Authorship and AI assistance are disclosed in the source; this report is independent AI review, not external human certification.
