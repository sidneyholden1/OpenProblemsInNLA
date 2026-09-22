# IE-15 Lean verification project

Mathematical resolution: George Stepaniants, Department of Computing and
Mathematical Sciences, California Institute of Technology. Original question:
Nicholas J. Higham. Formalization: Sidney Holden, Center for Computational
Biology, Flatiron Institute, Simons Foundation, with OpenAI Codex assistance.

The four exports prove both full original sharp rook-growth constants, 3 and
14/3, including all real nonsingular inputs, admissible choices and ties, every
intermediate entry, and genuine nonempty bounded suprema. The exact rational
matrices attain both values. No diagonal-pivot or normalized-input assumption
replaces the original universal statement.

Local status, 2026-09-22: complete Solution build PASS (3087 jobs). All four
LeanCert `#assert_trust kernel` checks pass; each transitive axiom closure is
exactly `propext`, `Classical.choice`, and `Quot.sound`. Two independent nonauthor final reviews passed. Actual isolated Linux
Comparator/default-kernel verification accepted all four exports at proof
revision `1ada36c90a34f5567902c4ae306c01e392a8bac9`, with all rejection and sandbox
controls checked. [Complete acceptance record](../../../docs/lean/verification-2026-09-22/IE-15/README.md).
These are AI-assisted checks, not external human peer review or source endorsement.

The original two statement approvals were independently hash-bound before
implementation and revalidated on 2026-09-22. Challenge and Definitions,
Comparator configuration, and all dependency pins remain unchanged. Their
[fresh gate](reviews/statement-gate-20260922.json) records the successful replay.
The old reviewed documentation is retained in `reviews/statement-review-snapshot`.

The proof proceeds through actual remaining pivot permutations, real sign
changes and positive normalization, then exact ratio identities for the Schur
updates. It bounds all earlier entries separately. The source scalar lemma is
proved analytically; bilinear interpolation replaces its corner-optimization
argument. LeanCert supplies kernel trust audits rather than an unnecessary
interval search for these exact algebraic results. The final real supremum
proof explicitly supplies both nonemptiness and boundedness.

Files: `PathReduction.lean` and `SignScaling.lean` transport arbitrary paths;
`PathBounds.lean` supplies the actual recurrence, padding and stage estimates;
`Scalar.lean`, `ScalarFour.lean`, and `NormalizedProof.lean` establish the sharp
upper bounds; `Witnesses.lean` proves the literal rational certificates;
`Supremum.lean` and `Solution.lean` assemble the original four exports.
The generic finite-maxima helpers in `Bounds.lean` are adapted with credit from
the existing IE-05 formalization. Shared workflow provenance and dependency
licenses are recorded in `tools/lean/NOTICE.md`. Apache-2.0 is retained.

The supporting `verification/verify_witnesses.py` is copied byte-for-byte from
George Stepaniants's retained source at immutable base
9777c86853b40206f70438c92a47a7dec9bc66ae. Its exact rational computations are
supporting diagnostics and are not trusted by Lean. Formal statements and
numerical contracts are in [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md).
