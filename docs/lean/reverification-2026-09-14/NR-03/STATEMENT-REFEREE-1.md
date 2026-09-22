# NR-03 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below. No blocking fidelity or scope issue.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not the original implementer. Date: 2026-09-14. Applied the source-fidelity, correctness, scope, API/reuse, computation and attribution angles in `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or external human peer review. Per coordinator direction, this new report is outside the unchanged proof project.

Provenance: the deliberately preserved source base is `deb549fa9ddd6b119e6c59016f268237e645dfa2`, carried forward from the previous batch. It is NOT described as current upstream main: the coordinator observed upstream main at `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is a fresh review of an already authored formalization, not a newly written proof. Historical statement-first prose and prior success claims are retained as dated source evidence. I read the complete canonical README, complete informal argument (including excluded extensions), numerical plan, Definitions and all 10 Challenge signatures. I did not inspect existing implementation proof bodies. All read repository bytes were independently checked against the preserved immutable base.

## Fidelity, scope and obligations

All ten contracts preserve the full fixed matrix on all Boolean rows and columns over the REAL field: (1-boolDot a b)^2 uses real subtraction, so intersections greater than one remain prescribed rather than truncating to zero. BoolVec n is the complete function space Fin n -> Bool, with the explicit 128-cardinality contract at n=7. Entrywise nonnegativity is distinguished from PSD. Nonnegative rank minimizes over ALL real nonnegative factor matrices of width r; it is not a rational-only or support-restricted proxy. Nat.find is the actual least witness. Its totalized impossible branch is bypassed by proved factorization existence at the witness and by explicit existence premises in the generic attained/minimal contracts. For a general finite entrywise nonnegative input the identity factorization also ensures the ordinary minimum exists.

HasScaledIntegerCertificate exposes, rather than assumes, every full entry identity, positive denominator and integer factor dimension. The scaled_certificate_gives_factorization export must retain the same proposed factors and divide columns by their strictly positive denominators over the reals, proving nonnegativity and the complete actual product. The unconditional width-127 certificate, real factorization, actual minimum bound, strict <2^7 result and negation are distinct required steps. No certificate correctness is hidden as an input to the final statement.

I read Holden's complete general construction and proof, including all four atom families, exceptional empty/singleton columns, polynomial identity and stronger general-n strictness. I independently parsed the original factor JSON from the immutable commit, verified its stated SHA-256, integer dimensions/nonnegativity/positive denominators, and checked all 16,384 scaled entries. This is supplementary exact evidence, not a Lean oracle. The first diagnostic invocation met an older Python lacking int.bit_count; replacing that operation by the equivalent binary-digit count allowed the complete check to pass. Lean must prove the same full obligations, possibly via the much cheaper atom-family counting identity. LeanCert kernel trust audits suit this exact discrete task; no interval subdivision is necessary.

Only n=7 is needed to negate the complete universal n>=3 equality. The general-n upper bound, strictness for all n>=7, exact rank of C7, smallest counterexample and correlation-polytope extension complexity are excluded. Holden retains the complete-result credit, Colbrook the earlier n=3 partial-result credit, and Stepaniants the existing formalization credit.

## Evidence and remaining gates

The coordinator's NEW `challenge-local.json` and log have matching independently checked SHA-256, successful exit 0 and exactly 10 deliberate Challenge-placeholder warnings. Log SHA-256: `5d21ee3d4141e01d38f8d723c5fc6c432679aa262032af3105ae5eaaa14ff22b`. This was the coordinator's Lean 4.33.1 macOS aarch64 typecheck using pinned dependencies; I did not rerun it. It proves well-formed statements, not their mathematics. Prior archived builds or Linux success were not used as substitutes. The Comparator configuration names all 10 contracts, allows no definition replacement and permits only propext, Classical.choice and Quot.sound.

The exact diagnostic is supplementary and not a Lean proof. Its script/log are retained alongside this report; the log marks the RA-09 expansion as a manual symbolic check, not a numerical universal verification. The imported definitions were inspected directly in the pinned Mathlib source where relevant; exact hashes are in `referee-1-statement-evidence.json` (SHA-256 `45fb00d9f0ed77042858f1df08af1fd153d2e66673019c1e712b689d0dac131c`). That evidence lists all source hashes, access method, configured exports and inspected fresh build evidence. A second independent boundary approval precedes proof inspection; fresh implementation/axiom audits and actual Linux Comparator/default-kernel replay remain separate gates. No proof acceptance or new Linux run is claimed here. Original George Stepaniants formalization credit and the source authors' credits remain unchanged. No source, metadata, historical report, ID or canonical target was edited.

## Exact reviewed repository hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `nonnegative-and-positive-factorizations/NR-03/README.md`: `8ec5b1fa32f457b09bf63ce14b17a527fcaafd29e068930b0fc5b2a5045435c2`
- `nonnegative-and-positive-factorizations/NR-03/lean/NUMERICAL_TARGETS.md`: `817a0978869dcaf2bb918d846e4143df480665e5db3bc841cf4070bd3f683c42`
- `nonnegative-and-positive-factorizations/NR-03/lean/NLA/NR03/Definitions.lean`: `5157fd499d2f63d218012f96bee43f30e5f57e5a2353fde13878af46d30fda04`
- `nonnegative-and-positive-factorizations/NR-03/lean/Challenge.lean`: `4f1764cf9c604f33ed6f285e83ca32ebd1ae1fb1fd8f763a1c4a719ef068c335`
- `nonnegative-and-positive-factorizations/NR-03/lean/comparator.json`: `ea1cea90b8e25535a31dca7fc620494ded851587609bb1473c651d07757f40bd`
- `references/holden-nr03-2026-09-13/NR03_counterexample.tex`: `26cac3ed5aa30226530bbf8562a626b6582444abcc8ef8e8e69ebde6160565a3`
- `references/holden-nr03-2026-09-13/data/factors_n7.json`: `fa515775f9c77e5dfe85109125d3f730c4b36684894730096247cd67fcc60bb9`
