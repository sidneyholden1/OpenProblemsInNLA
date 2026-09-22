# NR-03 — independent statement referee 2

**PASS — approved for proof audit at the hashes below.** Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_2`, 2026-09-14. Covers fidelity/scope, nonvacuity, numerical obligations, relevant API reuse and attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation, without claiming official endorsement or human peer review.

This is independent reverification of existing authored statements preserved at `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored formalization or the current upstream main. The separately observed upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f` is not the source base. I read the full canonical page, complete informal proof, numerical plan, Definitions and Challenge before inspecting any implementation. Historic statement-stage wording and prior verification claims remain archival; neither supplies this approval. George Stepaniants retains formalization authorship; Colbrook retains mathematical credit except NR-03's complete counterexample by Sidney Holden. No source bytes were changed.

The target retains all n≥3 and all Boolean row/column vectors, with every real entry `(1−boolDot a b)^2` prescribed. Crucially subtraction is real, so intersections larger than one remain fixed; no partial completion, parity restriction or truncated natural subtraction changes the matrix. Entrywise nonnegative factors are arbitrary real matrices through Fin r. `nonnegativeRank` uses Nat.find on actual existence, with attained-minimum and every-width minimality exported explicitly. Its impossible-branch default cannot affect the n=7 counterexample because actual width-127 existence is itself a required unconditional export. More generally prescribed nonnegative matrices admit the elementary identity factorization.

The integer-certificate predicate existentially quantifies complete natural-valued W,V, every strictly positive column denominator and every scaled entry identity. The named division map produces genuine real factors; positive denominators and the exact real product are exported conclusions. No imported JSON, assumed correctness or rank proxy serves as a premise of the final result. The Boolean index cardinality is explicitly 128, and 127<2^7 defeats the original universal equality.

I read Holden's complete manuscript, including the general construction, all degenerate column sizes, polynomial identity, strictness argument and scope. Independently read its retained certificate and checked dimensions, nonnegative integer entries, all positive denominators and all 16,384 exact scaled products against the original formula. This supplemental arithmetic is not a Lean proof. A symbolic atom-family proof or complete optimized kernel certificate is feasible; it must retain all entries. Pure exact integer/rational work calls for LeanCert trust auditing without artificial interval subdivision. The general-n bound, all-n≥7 strictness, exact rank at seven, smallest counterexample and full-polytope extension complexity are excluded. Mathematical credit is Sidney Holden, historical n=3 partial credit remains Colbrook, and formalization credit is George Stepaniants.

The Comparator roster matches all 10 Challenge declarations exactly, with no definition exceptions and only the three standard permitted axioms. I independently matched every reviewed local source to its immutable Git blob (git-show supplied sparse references). The coordinator's fresh macOS `lake build Challenge` passed; I checked its complete short log, 10 deliberate placeholder warnings, exit zero and SHA256 `5d21ee3d4141e01d38f8d723c5fc6c432679aa262032af3105ae5eaaa14ff22b`. This was the coordinator's execution, not mine, and establishes statement elaboration only. Fresh proof review, all-export trust checks and actual Linux Comparator execution remain separate gates. No historical PASS is being substituted for those future gates.

`referee-2-statement-checks.json` records the exact supplemental computations, read methods, export names, fresh build receipt and inspected Mathlib definitions/ranges at the pinned revision. All read primary-source hashes are below; metadata was inspected for scope/attribution, without re-auditing its historical run claims.

| Source | SHA256 |
| --- | --- |
| `nonnegative-and-positive-factorizations/NR-03/README.md` | `8ec5b1fa32f457b09bf63ce14b17a527fcaafd29e068930b0fc5b2a5045435c2` |
| `nonnegative-and-positive-factorizations/NR-03/lean/NUMERICAL_TARGETS.md` | `817a0978869dcaf2bb918d846e4143df480665e5db3bc841cf4070bd3f683c42` |
| `nonnegative-and-positive-factorizations/NR-03/lean/Challenge.lean` | `4f1764cf9c604f33ed6f285e83ca32ebd1ae1fb1fd8f763a1c4a719ef068c335` |
| `nonnegative-and-positive-factorizations/NR-03/lean/NLA/NR03/Definitions.lean` | `5157fd499d2f63d218012f96bee43f30e5f57e5a2353fde13878af46d30fda04` |
| `nonnegative-and-positive-factorizations/NR-03/lean/comparator.json` | `ea1cea90b8e25535a31dca7fc620494ded851587609bb1473c651d07757f40bd` |
| `nonnegative-and-positive-factorizations/NR-03/lean/formalization.yaml` | `1ca07539879c80103c75bc05b452357e7c524cc26448e8da40c5360855eab265` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `references/holden-nr03-2026-09-13/NR03_counterexample.tex` | `26cac3ed5aa30226530bbf8562a626b6582444abcc8ef8e8e69ebde6160565a3` |
| `references/holden-nr03-2026-09-13/data/factors_n7.json` | `fa515775f9c77e5dfe85109125d3f730c4b36684894730096247cd67fcc60bb9` |

Imported semantic definitions inspected (complete file hashes recorded in machine evidence): `Data/Nat/Find.lean`.
