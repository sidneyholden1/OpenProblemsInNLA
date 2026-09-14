# MI-08 independent statement referee 1

**Verdict: PASS / approve the exact statement boundary for the declared partial formalization.** No blocking semantic or feasibility changes requested. This is not approval of the adaptive comparison or an all-dimension optimum.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the statement implementer. Date: 2026-09-14. Phase: before proof implementation. Responsibilities: full fidelity within the declared limited scope, quantifiers, nonvacuity, integer/real bridges, minimum semantics, proof feasibility, computation and reused API/attribution, following `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not an official Tau Ceti assessment or external human review.

## Read sources and exact hashes

I read the complete canonical README, solution.md submission note and full solution.tex, including all of Theorem 1.1 and its adaptive proof, numerical targets, Definitions, Challenge, project README, formalization.yaml, Comparator config and the exact precheck program/output. All three canonical source files are byte-identical to base `9777c86853b40206f70438c92a47a7dec9bc66ae`, with SHA-256 hashes:

- README: `814804db20ca8a73366cced2a5de00f8f01261f13d05d5bae1eaa1a1124289e2`.
- solution.md: `854a282d60852a4a15a91bcc8a2889d69a1268124faca6cbd92d40e4e547cd99`.
- solution.tex: `c15abfde319610c212c0e021531fd7a89640fb39fb39ef1c112c0cd64827f404`.

Every entry of `reviews/statement-source-hashes.json` was independently recomputed and matched, and rechecked at report creation:

| File | SHA-256 |
| --- | --- |
| `NLA/MI08/Definitions.lean` | `3d239b1379ea53cead7b54a06ed8ae92e2d191420f45a39b5466dcd6380c3965` |
| `Challenge.lean` | `7ef811f91e89621f606400fb76756068f941c30f94ac4d9135bb6111d115413e` |
| `NUMERICAL_TARGETS.md` | `c8bf9ab6782e2bec826664fe69cd09a523e495cedadbee64ada5f4eca6d25832` |
| `comparator.json` | `18928dd61159e774c47a220a825f4666881e2a89fa825514bd800a91463bf465` |
| `formalization.yaml` | `5a5e7b8ddc58f8eba0ddfbe8a865f65089503de2edc9e04ddc6d02c51f3264ac` |
| `README.md` | `1a55dbd03860837653a88abe2d3d017ecf0537d6b885315704cb2066687166c0` |

## Fidelity within the explicit partial scope

`FixedPinching U` requires a positive length, actual square-matrix orthogonality UᵀU=I for each member, and the exact averaging identity for EVERY real square X. The list is a parameter outside that universal quantifier, so it cannot depend on X. Nonsymmetric matrices are included. `pinching` is actual diagonal extraction, and the products are U X Uᵀ in the source order. Equal weights are exactly 1/q. No diagonal/sign assumption is imposed on a general U in the forward direction.

The first theorem compares existence of a fixed list and existence of an integer sign design for every positive d and q. A rectangular q-by-d integer matrix with entries ±1 and actual column Gram HᵀH=qI is exactly the source real sign design: integer ±1 maps faithfully into real ±1, and finite sums/products commute with that cast. Conversely, a real scalar forced to be ±1 can be encoded by the corresponding integer sign without approximation. Positive q is crucial to the scale and is present both in the theorem and in `FixedPinching`. The sign predicate itself permits a vacuous q=0 Gram equation, but no relevant equivalence or obstruction accepts q=0, and no feasible-length set member can use it.

`design_obstructions` ranges over every such design with q>0 and requires d≤q and, when d≥3, natural divisibility 4∣q. Allowing d=0 in this theorem is harmless: rank gives the trivial bound and the divisibility implication does not apply. The equivalence itself deliberately restricts to positive d, exactly the source problem. The cases d=1,2 are retained without a false divisibility-by-four requirement.

`hadamardTwelve` is the explicit Paley construction in the manuscript, with first row/column all ones, core diagonal −1 and quadratic-residue signs. In its nonborder branch, i,j belong to 1,…,11 and i+11≥j, so natural subtraction in `(i.val+11-j.val)%11` does not truncate an intended negative difference; it computes the same residue as the integer i−j modulo 11. Shifting both core field indices by one cancels in their difference. The source displays HHᵀ=12I, while the target checks HᵀH=12I, the column orientation needed for rectangular restrictions. For this square matrix both hold; the exact target orientation was independently verified directly. The additional real inequality 0<12 is compatible with the positive feasible length and supplies a small explicit LeanCert target.

The last theorem covers EVERY d between 9 and 12 inclusive. It requires nonemptiness of the actual orthogonal fixed-list feasible-length set, `IsLeast` of that set at 12, and equality of its natural infimum with 12. I inspected `Order/Lattice/Nat.lean`: natural sInf is Nat.find for a nonempty set and defaults to zero otherwise. `IsLeast` requires membership and a lower-bound property; nonemptiness is also explicitly exported. Thus neither empty-infimum behavior nor an unattained lower bound can establish this theorem. There is no real-infimum convention hidden in `phi`, which is correctly natural-valued. Positivity in `FixedPinching` keeps zero out of the feasible set.

This package formalizes fixed feasibility for all positive d,q and the four exact minima only. The canonical source also proves equality with the adaptive length, but the README, targets and manifest explicitly exclude that comparison. They also do not advertise a formula for the general optimum or a proof of global feasibility in all dimensions via Sylvester construction. Those omissions are consistent with the declared partial scope and leave the canonical all-dimension question and permanent ID/path unchanged.

## Proof bridges and feasibility

The planned forward proof is valid for fixed lists. Apply the identity to a diagonal matrix unit E_jj: a zero off-diagonal-position diagonal output yields a sum of squares of the corresponding column entries of all U_r, so each unwanted entry is zero. Orthogonality then forces each surviving diagonal entry to square to one. Applying the identity to all E_ij yields the zero cross-column sign correlations, while diagonal correlations are q. This produces the integer design without assuming diagonal factors in advance. In the reverse direction, diagonal matrices built from sign rows are orthogonal, and the Gram identity proves the pinching average entrywise for arbitrary real X. No input-dependent choice is used.

For d≤q, actual rank of HᵀH=qI can be used over a suitable ring/field with q nonzero. I inspected Mathlib's `Matrix.rank_one`, product-rank bounds and dimension bounds in `LinearAlgebra/Matrix/Rank.lean`; the factor Hᵀ has q columns, giving the required bound. The integer q remains nonzero under a characteristic-zero cast. A proof must discharge that cast/nonzero step rather than rely on rank over an inappropriate characteristic.

For divisibility, choose three distinct columns. For each row's signs a,b,c, the integer expression (1+ab)(1+ac) equals 1+ab+ac+bc and is divisible by four. Sum over rows; pairwise column orthogonality cancels the three cross terms, leaving q. I inspected the corresponding Mathlib Hadamard proof by Dennj Osele. Its square-matrix theorem cannot simply be invoked for arbitrary rectangular designs, but its three-row argument transposes directly to the required three-column argument. The proof plan correctly proposes that adaptation and preserves attribution.

Restricting the twelve sign columns to the first d columns proves a length-12 design for every d≤12, and the equivalence supplies actual orthogonal pinching lists. Conversely each feasible q in dimensions 9–12 gives a design, so d≤q and 4∣q imply q≥12. This proves actual membership and leastness and then the stated phi equality. No exhaustive candidate search or hidden Hadamard-existence assumption is needed.

## Independent checks and limits

I independently derived the mod-11 nonzero square residues by squaring 1,…,10, reconstructed the exact encoded matrix, and matched the author's stored matrix. All 144 entries are signs and the actual column Gram is exactly 12I. For every 9≤d≤12, I checked every matrix-unit conjugation coefficient in the restricted construction. I also checked all eight triple-sign cases of the divisibility identity and the finite lower-bound arithmetic. These integer diagnostics passed and are recorded separately; they are not Lean proof evidence.

The author's 1855-job statement build was inspected. My independent pinned Lean 4.33.1 `lake env lean Challenge.lean` replay exited 0, with precisely the four intended placeholder warnings. The shared local dependency cache was used. This verifies elaboration, not theorem truth or future transitive axiom closure. Exact computation without interval subdivision is appropriate here; the proposed LeanCert kernel positivity target and later all-export trust audits do not replace the required universal algebra.

Metadata accurately labels the project partial and statement-only, credits Colbrook's partial result and Bourin–Lee's original question, records Holden/Codex formalization attribution, and acknowledges the studied Mathlib Hadamard argument. The added standard Apache-2.0 LICENSE does not alter any of the six reviewed files. Comparator selects all four exports, no definition holes and only the three standard axioms. I did not independently repeat official schema validation, and no solution proof, final review, actual Linux Comparator run or rejection-control pass is established by this report.

Evidence hashes:

- `verification/numerical_precheck.py`: `4fbacd2db7e41356c2c493d9f4fcd256a81c2622840f2d563d2756ae755aef23`
- `verification/numerical-precheck.json`: `f100927d3e4e2a1b7d4f4a5cd17f9a3d423d471d73e0dac829386a2538f74715`
- `verification/referee_1_statement_check.py`: `15178a2d4fd5671ab6e02c39133338f4ad5aca3becfe0c9fc5c72c671042b5d8`
- `verification/referee-1-statement-precheck.log`: `af8b24e3ad5a4b0b1bc2487fac57bceb355bc443e7ce1f419b283ee1b776f232`
- `verification/referee-1-statement-build.log`: `9597e8ada96e505a10703118c86d02bf0759e20fcaf920f40445b97aa7bc2b96`
- `verification/referee-1-statement-hashes.log`: `36469add7e9d0f8ab7cd7f08aeeb32ac16ebaf0c40cbb26c476945da99cfdbc9`

No frozen file, proof or metadata was changed by this referee; only independent review/diagnostic artifacts were written. Final proof review must check each forward/reverse real/integer, rank/divisibility and leastness bridge in actual Lean. Canonical status remains Partially resolved. Latest account usage check: 27% remaining, above the user's 25% checkpoint threshold. No push was attempted.
