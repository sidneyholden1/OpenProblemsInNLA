# MF-02 independent final referee 2

**Verdict: PASS for the complete local formalization.** Date: 2026-09-22.
Reviewer: OpenAI Codex agent `/root/iv06_statement_referee_2`, an AI agent and
nonauthor of every MF-02 statement and proof module. This is the independent
final-code phase under `docs/lean/REVIEW.md`, adapting the stated Tau Ceti
correctness, fidelity, reuse, clarity and attribution criteria. It is neither
external human peer review nor isolated Linux verification.

I read the complete canonical README and complete Stepaniants solution.md,
all nine active NLA modules (including Definitions), all Solution wrappers,
frozen Challenge and numerical contracts, both metadata wrappers and the
Comparator configuration. I independently verified all 22 author snapshot
hashes and every frozen gate input; the reviewed original documentation is
retained in the documented snapshot. No mathematical boundary changed.

## Mathematical correspondence and proof inspection

The register model starts from 1,x, allows every real linear combination of
all retained earlier registers as both operands and output, and charges at
most m products. It includes reuse and arbitrary constants. Counting optional
scalar products does not alter the class because their result is already a
free span element. `Registers` bounds the span by degree and inducts over
actual stored multiplication. `ProgramCosts` explicitly stores p² then p³
before forming a cubic for free; composition cost is exactly the advertised
at-most 2T. Coefficient-list recursion and append lemma implement q1 first,
then q2, etc.; the empty composition really is x.

`Errors` splits the domain into its two closed intervals and proves compact
continuous images, nonemptiness, boundedness and attained polynomial error.
The sign convention at zero is immaterial for every allowed positive gap.
Both families of errors have actual members and the uniform lower bound zero.
Thus real supremum/infimum defaults cannot supply a spurious result.

`DegreeError` handles every real polynomial, including constants and zero.
The odd part does not increase error or degree. Its square has only even
coefficients; Mathlib's actual `contract` and `expand` recover a degree-at-most-D
polynomial in x². The reversed affine interval map sends the exterior positive
point to zero, allowing the pinned exterior Chebyshev theorem with derivative
order zero. A strictly positive slack error avoids a separate zero-error case
without assuming positivity of the unknown error. The final inequality is
obtained by a positive-product contradiction, not a sampled approximation.
I inspected the relevant pinned Chebyshev exterior theorem and real-cosh
identity, and the expand/contract coefficient and evaluation APIs.

`Cubics` proves the source optimized cubic's entire interval range by exact
factorizations, replacing derivative casework. Its peak is the positive square
root-based maximum, with all divisions guarded. The source polynomial identity
proves gap-ratio squaring exactly. `Constructive` absorbs normalization and
recentering into the two coefficients of the appended stage; it does not add
an uncharged stage. Oddness transports the positive-interval estimate to the
negative interval. Every potentially degenerate polynomial is covered by the
degree lower bound.

`ErrorEstimates` uses genuine real infima. In particular `cubic_square` selects
an actual error below a strict threshold using the infimum property; it does
not assume an optimal coefficient list exists. Strict decrease handles T=0
separately and every positive T by positive lower and subunit upper bounds.
`Stages` proves every feasible-stage set nonempty, its natural infimum a member
and minimal, before using that minimum. Hence its natural-valued definition
agrees with the canonical extended-natural convention on all admitted inputs.
The m=0 and m=1 endpoint values and every m≥2 bound are established, as are
absolute constants 1/4 and 1 uniformly for all 0<δ<1. There is no restriction
on how δ depends on m. The internal `DegreeBound` interface is explicitly
filled in every exported wrapper by `degree_error_bound_proved`; it is not an
extra final hypothesis or an assumed approximation result.

## Independent mechanical evidence, reuse and limits

I generated `verification/Referee2Consumer20260922.lean` from the frozen
Challenge signatures and supplied the actual seven Solution declarations.
My fresh `lake env lean` run exited 0. It queried every exported type, printed
every transitive axiom closure, and ran all seven `#assert_trust kernel`
checks. All closures are exactly propext, Classical.choice, Quot.sound.
Printed wrappers confirm the actual degree proof is in the exported closure.
The reproducible generator and receipt retain the command and exact hashes.
I also inspected the author's successful 3023-job local Solution log; that
whole build was run by the coordinator, not by me. No active proof contains
sorry, a custom axiom, admit, or native_decide.

The existing Mathlib Chebyshev, polynomial, compactness, span, conditional
infimum and natural minimum APIs are used directly. The module split follows
actual mathematical dependencies. Exact scalar identities are preferable to
interval subdivision here. LeanCert's material role is a kernel trust audit;
no numerical interval certificate is claimed. The manuscript's Cheon–Kim–Kim
prior-order credit and Chen–Chow cubic credit are preserved, with Stepaniants
identified as exposition author and no novelty/endorsement claim. The full
canonical asymptotic-order target is proved; the exact optimal stage count,
optimal leading constant and stronger same-budget error question remain
outside the claim, as in the canonical page.

One cosmetic inherited field remains: lake-manifest.json's top-level project
name is NLAIV06, while lakefile.toml correctly names NLAMF02. Its dependency
pins, imports and successfully checked declaration identities are correct;
this is nonblocking and I have not modified frozen metadata. Revisit it during
a deliberate future manifest refresh, not by changing tested proof inputs.

Actual isolated Linux Comparator/default-kernel and sandbox rejection controls
remain a separate pending gate. This report alone does not authorize a claim
that the project is already Lean verified. All conclusions bind exactly to
the bytes below.

## SHA-256 of inspected project and independent evidence files

- `Challenge.lean`: `0284eb85b2be3ec04516012b61e3d0d0c41717188a8944da8333558efb655546`
- `Solution.lean`: `6bff4237680834a54616e77427e0a92e32af2a3e2706ecfcac8074a420bdf913`
- `NUMERICAL_TARGETS.md`: `1fc2996bc424da250691ce4e02d33c08f9f7ea934994b3e3633c955bb6cdb4a3`
- `README.md`: `97c495c91c4461b178bb012a58ae2b782afe99881f88ef4487c79e7d6d0bbdbc`
- `formalization.yaml`: `71a78e300f20604dbd07420398909d0c89daaee0336bce290058f31d2ba1fea0`
- `comparator.json`: `24e218a102a833673e874c64bc368feb2033c2877228f97280ac633cfaf9706a`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `lakefile.toml`: `dc8685aa5eeceaefc95b56cbba12eaf37eaea6ef512c86b6dbba12c9647836cc`
- `lake-manifest.json`: `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08`
- `reviews/statement-gate.json`: `d07a41e49af4b016d54455a227f14198702fcc75de890bbde8c07ea3a67cb6a6`
- `verification/solution-build.log`: `4884a464f14b094e3869746d003f6b7c0e0dc937bbcac5f9adae890d1887ede8`
- `verification/metadata-local.log`: `c564296146112d01050bcfa06b93a2382ffffe76475429fdb108077ea03aa00a`
- `verification/referee-1-degree-helper-receipt.json`: `fc58b94db5b34847ca0cbf587d685768e8c1927866bdf3a631d3df93f40fdf8d`
- `NLA/MF02/Constructive.lean`: `bcd23fe7e8342fd3339150ed4652536d21ec689fe2d51f84b499f852b751be7d`
- `NLA/MF02/Cubics.lean`: `9a0e638d1d21c1f37ad1bb1c0c734d0c2abb5ac00669af17869d78d758585404`
- `NLA/MF02/Definitions.lean`: `e75b50eb3999052c92a2725942ed32d51c8fecbb1cc76aa635080f32ea0c3553`
- `NLA/MF02/DegreeError.lean`: `4f62030fa5147ecf4aed747fcdd243e37d509570a00cf767374138e77a934fba`
- `NLA/MF02/ErrorEstimates.lean`: `a05d109d69fc64076420590def40f250a3f387b0517713c965f26643fa8122e2`
- `NLA/MF02/Errors.lean`: `d63d46fc4f9687f6068c99ea70d4539048eb46248da610ff71614416f27106ad`
- `NLA/MF02/ProgramCosts.lean`: `e24fd1207e535e06dcced0b8e3c190eb046feb0bde939166f0d3824cdef06cdf`
- `NLA/MF02/Registers.lean`: `cc39e9fb9aabf45419b4911310c8409502418f17c9f98ce865ea6b2ff3df5bd9`
- `NLA/MF02/Stages.lean`: `0d3e65f67bf029636033ac0cb783bbfc3d61b96aaff73375c20658b63bdd4190`
- `../README.md`: `b779c356388860ddeab25dc9b6f35d968b6f42625c598038fa402e6841b477c9`
- `../solution.md`: `e104a785ddecbec117f6dffe58110222550dd7f1354bfda8c67c37daa68c1924`
- `verification/Referee2Consumer20260922.lean`: `e1ac660db0db814febc22685f3e1bd3a0b12dd4f731c5b45b50e993fb235e951`
- `verification/referee-2-consumer-20260922.log`: `79cb9285d9304bcbb3e43e84c0054254ed66d136759626e4a5d53c1a7c56299a`
- `verification/referee-2-check-20260922.py`: `e680381fa02be92bdc2cf257471c73e06c41f5d38bdd75d001302c635c102987`
- `reviews/referee-2-proof-evidence-20260922.json`: `d1d19fcfd32b80f7ec7cc38ce9afd1a819ce22fc61db82b8ea36b3f7286ad932`
