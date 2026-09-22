# MI-04 Lean statement candidate

Two exports specify the complete original universal positive-block norm implication and its orthonormal-pair intermediate. All finite n>=1, arbitrary complex X, the genuine Euclidean operator norm and the actual PSD block condition are retained. No invertibility or spectral simplicity assumption is added.

This is a statement-only candidate: Challenge has two intentional placeholders and no Solution implementation exists. Statement reviews, proof, final reviews and actual isolated Linux Comparator are pending. Canonical status and source files remain unchanged.

Read [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md), [PROOF_PLAN.md](PROOF_PLAN.md), [Definitions](NLA/MI04/Definitions.lean), [Challenge](Challenge.lean), and the [complete informal proof](../solution.tex). The planned PSD-rescaling proof replaces the source's eigenvalue perturbation step; it is a formal-proof adaptation, not a claim that the source contains this argument verbatim. Only canonical necessity is in scope; no optional converse/equivalence is advertised.

With the pinned toolchain/dependencies, run `lake build Challenge`. The future proof build must explicitly use `lake build Solution`. `comparator.json` registers exactly two exports and permits only propext, Classical.choice and Quot.sound. LeanCert will audit kernel trust; Linux Comparator acceptance remains a separate mandatory gate.

Mathematical source: Matthew J. Colbrook, Cambridge. Original question: Bourin–Lee; Hayashi background. Formalization: Sidney Holden with OpenAI Codex assistance. The two authors are agents /root and /root/iv06_statement_referee_1; independent nonauthor statement/final referees are /root/iv06_statement_referee_2 and /root/new_target_screen. AI-agent review is not external human review or author endorsement. Pinned project layout/API examples were studied in MF-22 and the existing matrix projects; no theorem is imported from another problem project.
