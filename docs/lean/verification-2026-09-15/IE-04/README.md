# IE-04: complete Lean verification

The complete original negative answer passed [fresh isolated Ubuntu verification](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34926830831) at `82c0d620db7369a546071a13088ebb095368c262`. George Stepaniants retains mathematical authorship; Spielman and Teng retain attribution for the original conjecture. Sidney Holden prepared the formalization with OpenAI Codex assistance. The full identity-centered counterexample refutes every proposed positive pair of universal constants; the optional zero-centered extension is not claimed.

All twelve configured exports passed Comparator statement identity, permitted-axiom checks and Lean's default kernel. Only `propext`, `Classical.choice` and `Quot.sound` are permitted; no definition exceptions are allowed. Actual per-project sandbox, raw-kernel and Comparator controls passed, including rejected sorry and native-compiler axioms. The separate shared-tooling controls job was skipped because tooling did not change; full controls ran inside the IE-04 verification job.

[The original artifact and receipt](linux/RUN.json) bind all **110** tested inputs to exact immutable Git blobs and bind the ZIP hash to GitHub's artifact digest. [Operational audit](ROOT-LINUX-CHECKS.json) records each inspected log's hash and markers. Pinned public dependencies and the official Mathlib cache were used; a full dependency-source rebuild is not claimed.

The frozen statement reviews, two fresh independent nonauthor final source reviews and their [final evidence gate](../../../../linear-systems-and-elimination/IE-04/lean/verification/final-code-gate.json) are retained verbatim in [the project](../../../../linear-systems-and-elimination/IE-04/lean/README.md). They follow the repository's Tau Ceti adaptation and are AI-agent reviews, not human peer review, official Tau Ceti endorsement or source-author endorsement.

Publication updates prose, catalog entries and metadata after the immutable proof run. All 21 mathematical Lean files are unchanged. Earlier pending-status documents inside the retained artifact describe their historical phase, not the current publication status.
