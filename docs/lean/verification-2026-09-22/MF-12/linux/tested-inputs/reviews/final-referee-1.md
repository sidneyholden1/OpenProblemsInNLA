# MF-12 final independent proof review — PASS

Date: 2026-09-22. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_1`, a nonauthor of this boundary and proof. This applies the repository's `docs/lean/REVIEW.md` Tau Ceti adaptation across fidelity, correctness, computation, reuse/API and attribution. It is not human peer review or Tau Ceti endorsement.

**Verdict: PASS for the complete local mathematical proof and all four frozen exports.** Actual isolated Linux Comparator acceptance is a separate, pending gate; this report does not promote the canonical status.

## Exact evidence and execution

I read all twelve files in the active local Solution import closure, including Definitions and the public wrapper, and the full canonical statement and Colbrook manuscript. I independently recomputed all 23 candidate hashes and all 15 frozen statement-input hashes. The unchanged statement README/YAML are preserved under `reviews/statement-review-snapshot`; current metadata accurately reports local completion and pending reviews/Linux. The original manuscript SHA-256 is `e3e3e00f87e705620265eb854adc22a2a60516dce897e4022938884381c5d779`.

The candidate manifest SHA-256 is `29cf889f47b7dd8f16a33d6b639671f0740d4b7e45ff582368a41ee161167167`. Exact active-source, boundary, supporting-library and execution hashes are in `referee-1-proof-evidence-20260922.json` (SHA-256 `1a0d874567aab5cd59244a2bfd13fb81691e63e761befd62d5e24c3aad2d94e4`).

I ran `verification/Referee1Consumer20260922.lean` independently with pinned Lean 4.33.1 and the pinned shared dependencies: exit 0. It restates each of the four exact Challenge signatures, supplies it using the corresponding Solution export, prints its transitive axioms, and asserts LeanCert kernel trust. All four have exactly `propext`, `Classical.choice`, `Quot.sound`. I inspected the author's current `solution-build-2.log`: full build PASS, 3,110 jobs. This was the author's execution, not mine. The earlier failed `solution-build.log` is historical development evidence and is not used as acceptance. Current metadata validation passes for four declarations. No Challenge import, sorry, custom axiom, unsafe definition or native verification appears in the active local closure.

## Fidelity and mathematical closure

`compressed_powers` proves the literal source 2×6/6×6/6×2 multiplication for every real μ and every natural q, including q=0. `fractional_growth` covers every real 0<α<1, every switching word and every positive length. `arbitrary_pair` covers every real γ≥0 with two distinct matrices in one fixed positive dimension; `original_target` gives the canonical finite nonempty family. Dimension, matrices and positive comparison constants are outside the length quantifier. There is no rational-exponent or subsequence restriction.

The norm is the genuine Euclidean operator norm, confirmed by the definitions-only instance probe and the pinned Matrix C*-algebra APIs. `productNorms` is the actual set of norms of all words; the binary-word range equality handles repeated matrix values. Its finite nonempty range yields a genuine attained `sSup`, not a default value. `RealizesExponent` includes the actual nth-root limit; the proof uses the rpow asymptotics and a squeeze from positive two-sided polynomial bounds. No spectral-radius assertion is smuggled in as an assumption.

Geometry proves the seed power formula, U V=I, reset identity and coordinate compression exactly. Matrix entries are bounded by the actual operator norm using Euclidean coordinate vectors; conversely a finite matrix-unit decomposition yields a positive dimension-dependent operator-norm constant. These two proved comparisons justify every later scalar-to-matrix bridge, including rectangular products.

ScalarBudget proves finite Hölder with the actual conjugate exponents and nonnegative inputs. Its stronger inductive triangular-product budget tracks both total gap length and the remaining damping factor. Empty products, q=0, zero weights and zero scales are handled. The exact real-power identities turn the literal compressed matrix into that budget. The additional telescoping identity is proved but need not be assumed or used to close the main estimate.

Words decomposes every binary word into either a pure seed power or seed end factors around a finite list of compressed reset gaps, with an exact length identity. WordBounds bounds all pure powers using actual convergence of q μ^q and applies rectangular operator-norm submultiplicativity to the full decomposition. Constants are fixed for α and do not depend on the word.

ScalarLower uses an exact Bernoulli estimate, q=floor(log₄ n), and a floor quotient. The power sandwich supplies the necessary positive denominator before division and guarantees a uniformly positive gain. WordLower constructs a word of exactly n letters by padding, proves its compressed power identity and unchanged first row, and obtains the lower operator-norm bound from two actual entries. Lengths 1, 2 and 3 are treated separately using a diagonal entry equal to one. Thus the lower bound holds at every positive integer, not merely a chosen subsequence.

IntegerGeometry proves the reindexed Kronecker-product entries, products and the exact powers of J₂. IntegerLift attaches the same fixed J₂ to each generator and proves two-sided actual norm comparisons by its diagonal/off-diagonal entries. Every lifted word gains exactly one power of its length. Injectivity preserves distinctness. The γ=0 pair is handled directly; natural-floor decomposition and repeated lifting cover every real γ≥0. This may use a larger dimension than the source's optional efficient Jordan-block construction, which is permitted by the original target and explicitly disclosed. Internal parameterized helpers are discharged by the proved fractional construction in the final Proof module; no public conclusion remains a premise.

## Computation, API, credit and limits

The proof uses exact algebra, finite Hölder, Bernoulli, natural-log bounds and real asymptotics. It avoids needless interval subdivision, matrix singular-value calculations and a general tensor spectral-norm theorem. LeanCert's actual role here is the checked `#assert_trust kernel` transitive-axiom audit; no numerical interval certificate is claimed. I inspected its `collectAxioms` classification and rejection of sorry, native and custom axioms. The previous finite rational seed tests are supporting diagnostics only.

Reuse of Mathlib's Euclidean operator norm, finite maxima, Hölder, matrix basis/Kronecker and real-power limit APIs is appropriate. Module placement and helpers separate literal geometry, all-word bounds, lower witnesses and integer lifting. Current successful-build lint warnings concern unused simp arguments, sequencing and unreachable/unused tactics; they are nonblocking maintenance items and do not justify altering this reviewed mathematical candidate. Source credit to Matthew J. Colbrook, Varney–Morris antecedents, Sidney Holden's formalization and AI assistance, and dependency licenses is retained. No optional optimal-dimension or rational-entry refinement, novelty, source-author endorsement or human review is claimed.

No unresolved material finding remains. Linux isolation, rejection controls and Comparator theorem identity must still be audited against the eventual immutable tested commit before publication.

## Active source hashes

| File | SHA-256 |
|---|---|
| `NLA/MF12/Definitions.lean` | `9411884dcbbfd4d2dc28fcbefac98fdef3f7860c3150d311659882edc58b7d41` |
| `NLA/MF12/Geometry.lean` | `24680eef99657ba284b7818b3972751f67007bf5684f278151dfd3ec8d3a1a5c` |
| `NLA/MF12/Growth.lean` | `0fe4c240a0284fff13b9c7a79d15b34a48a77603e13dfa8ec1890890cb6edb46` |
| `NLA/MF12/IntegerGeometry.lean` | `dcd44573d180ab88acd4cb54069066abc69b4ba81de7e9e853cb4170d7e58925` |
| `NLA/MF12/IntegerLift.lean` | `583b290ef81a88442a86a8ebcc5e429a2149fbdf24a76854cdcec3305ae1cf95` |
| `NLA/MF12/Proof.lean` | `a8a4633b363176556277cc9b2398e3b17f2fe9873f0f3e38fb89e1e8877da435` |
| `NLA/MF12/ScalarBudget.lean` | `eebdaf05d603e604be1618ddf71434e73bb15b602c0240371e4304e88b05795a` |
| `NLA/MF12/ScalarLower.lean` | `c75e61035a1e515db70dbdcdeff17234356b4e9b338830d17f359cc6ade14f51` |
| `NLA/MF12/WordBounds.lean` | `d407205f4d83a4c0bff42635e0708e3af8fc634e3a1b88a42fb931bd31616224` |
| `NLA/MF12/WordLower.lean` | `58c81d76538701a7a28ec27911ba7ed881f51ffcd300b0c998a54db88310cf29` |
| `NLA/MF12/Words.lean` | `36376dfd19e12e8aa760fb4ada84b95e77194bffb74eb5dc3315096736abd08c` |
| `Solution.lean` | `3651fe538a2bda2c7a6138a434b50b9999af00dbc89593b53664c26e3730f73d` |
