# IV-06 Lean formalization

This project formalizes Matthew J. Colbrook's complete negative resolution of
[IV-06](../README.md): an independent-entry real interval matrix of dimension
three has at least four connected components in its real eigenvalue set.
Formalization: Sidney Holden, with OpenAI Codex assistance.

The proof uses four integer eigenpairs, exact elimination at three excluded
separator values, and Mathlib's theorem that a preconnected real set contains
the intervals between its points. All component counts use actual nonempty
connected components and extended-natural cardinality. A kernel-only LeanCert
point certificate checks the positive corner margin of the eigenvector
elimination at 12; monotonicity eliminates both interval variables first.

The definitions and Challenge signatures were frozen in commit `9145e017`
after two independent AI statement reviews and successful type-checking.
The reviews retain and resolve a corrected explanation of which parameter
bounds supply the margin at 12. The solution never imports Challenge.

Local Lean compilation, transitive axiom audits of all four exports, and two
independent final AI proof reviews passed. Actual isolated Linux Comparator
checks are pending; the canonical problem remains Solved. No external human peer
review or source-author endorsement is claimed.

See [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md), [formalization.yaml](formalization.yaml),
[reviews](reviews/), and [verification](verification/). The pinned dependency
and checker workflows follow the existing repository examples, particularly
MI-29's exact-certificate structure; imported implementation retains its own
licenses. The mathematical source is credited separately in the manifest.
