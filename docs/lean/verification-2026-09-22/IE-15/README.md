# IE-15 full-target acceptance — 22 September 2026

Both exact original rook-pivot growth constants are formally proved:3 and14/3,
for every real nonsingular matrix of the requested order, every admissible
choice/tie, and every intermediate entry. Both bounds are attained.

Proof revision: `1ada36c90a34f5567902c4ae306c01e392a8bac9`.
[Actual Linux run](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35691581091).
[Independent operational audit](linux/OPERATIONAL-REFEREE-1.md) checks the original
archive digest, all 65 input files, all four Comparator exports, default-kernel
replay, negative controls and both sandbox modes. Source and workflow are pinned.

Independent nonauthor source reviews: [referee1](../../../../linear-systems-and-elimination/IE-15/lean/reviews/final-referee-1.md)
and [coordinator referee](../../../../linear-systems-and-elimination/IE-15/lean/reviews/final-referee-root.md).
Both statement approvals preceded proof implementation; exact reviewed hashes
are retained in the project. LeanCert kernel checks allow only propext,
Classical.choice and Quot.sound. Four deliberate Challenge holes never enter
the completed Solution’s dependency closure.

Mathematical resolution: George Stepaniants, Caltech. Original question:
Nicholas J. Higham. Formalization: Sidney Holden with OpenAI Codex assistance.
Independent AI-agent checks are disclosed; no external human review, source
endorsement or novelty claim is made. Later publication checks are recorded
separately and do not replace this immutable proof acceptance evidence.
