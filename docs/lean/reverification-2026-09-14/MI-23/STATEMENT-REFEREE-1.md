# MI-23 independent statement referee 1 — 2026-09-14

PASS — explicit approval of the exact statement boundary bound in the evidence below. No blocking fidelity, scope, numerical or vacuity finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, covering the relevant adapted Tau Ceti correctness, fidelity, scope, generality, optimization, reuse/API, documentation and attribution angles. It is not official Tau Ceti endorsement or external human peer review. No active Proof or Solution body was inspected.

## Original target, numerical statements and semantics

The preserved authored source is `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. I compared the recorded old and preserved canonical target sections: their mathematics agrees, with rendering and whitespace differences only. I read the complete canonical page and complete informal proof, Definitions, Challenge, numerical targets, available source correspondence, project README, Comparator and formalization metadata. Their historical completed-status or statement-stage descriptions do not establish any fresh result. Existing authorship and permanent IDs remain unchanged.

All eight contracts retain the corrected eigenvalue conjecture, not the earlier singular-value version. The target quantifies every positive dimension, complex positive-definite A,B and real r,s,p,t with p≥1, t∈[0,1], and both original regions r,s≥1 or r,s≤0. CFC powers preserve zero and negative exponents and all factor order. Generic positive_powers_and_means is stronger in permitting arbitrary real r,t; this is mathematically consistent because every positive-definite input's real powers are again positive definite.

OrderedEigenvalues maps the full actual characteristic-root multiset to real parts and sorts decreasingly. This mapping is not accepted as an unsupported reality assumption: the product semantics contract requires reverse complex-root multiset equality, exact length n, strict positivity, descending order, determinant product, actual inverse products and an explicit similarity to Y^(1/2)XY^(1/2). Multiplicity is retained. LogMajorized keeps equal lengths, every proper prefix and equality of complete products. The zero default in largestEigenvalue is guarded by the positive-dimensional semantic theorem; it cannot fabricate the witness reversal.

The exact D,T and eighth-power construction match the complete source. My fresh rational multiplication checked the LDL factorization, pivots 2,49/2,150/49, leading minors 2,49,150, conjugated T⁸, the paper's (1,3) entry at Lean (0,2), the entire Frobenius sum and the positive gap 99434824489435745411095588895/107495424. The selected r=s=1,p=2,t=1/8 lies in the original domain and outside the cited narrower t interval.

All actual half/eighth-power identities, positivity of both means, and identifications with G²H² and A²B² are conclusions. The generic squared_product_largest theorem connects the actual largest characteristic root to ‖XY‖² through similarity to YX²Y=(XY)ᴴ(XY); it does not define eigenvalues by norms. Actual Euclidean entry/Frobenius bounds turn the rational gap into the required first-root reversal. The final theorem negates the whole original conjecture.

Exact integer powers remove all fractional-root approximation and expensive spectrum computation; only a scalar positive gap is planned for LeanCert kernel checking. Its actual proof route and material use remain later obligations. No all-parameter failure, classification of valid regions or separate earlier singular-value conjecture is claimed. Colbrook's original counterexample and Stepaniants's formalization credits remain intact.

## Fresh evidence and approval limits

The fresh independent [referee-1-precheck.py](referee-1-precheck.py), invoked with `MI-23`, exited 0. Its [exact output](referee-1-precheck.log) records the reconstruction and its explicit mathematical limits. The script imports no authored verifier or Lean proof module. Exact finite/symbolic diagnostics are supplemental evidence, not formal proof or universal analytic/algebraic assumptions.

I inspected the coordinator's fresh macOS aarch64 `lake build Challenge` receipt and full log, and verified its SHA-256. It exited 0 with exactly 8 intentional Challenge placeholder warnings. This is the coordinator's execution, not a second build by this referee; compilation establishes well-formedness only. Comparator selects all 8 reviewed signatures, no definition exceptions and only `propext`, `Classical.choice`, `Quot.sound`. The actual imported Mathlib definitions and example proof APIs were inspected at their pinned revision; LeanCert's kernel-mode examples and checked-bound interface were also read. A later actual proof-term audit must determine the tactic route and certificate consumption rather than assuming a backend from the command name.

[referee-1-statement-evidence.json](referee-1-statement-evidence.json), SHA-256 `551fa70a513ec52cc42887701a8ee871b063b8772a0454a4fdce8e599c471c4e`, records every read authored-file hash, exact relevant library hashes, registered exports, all ten dependency pins, diagnostic script/results and fresh build/provenance attachments. All read authored bytes match the preserved source. Whole library files are hashed to identify the inspected definitions and examples; this is not a claim that every dependency line was read.

I approve these exact statements for the subsequent gated proof audit. Fresh complete proof review, all-export axioms, material certificate terms, second independent final review and actual Linux Comparator/default-kernel/control verification remain separate. No authored source, metadata or historical evidence was changed.
