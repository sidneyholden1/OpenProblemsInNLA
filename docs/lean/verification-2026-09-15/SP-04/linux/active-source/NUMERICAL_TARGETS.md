# SP-04 statement boundary — draft for independent review

This directory contains statements and definitions only. No proof is complete, no
verification is claimed, and the boundary is not frozen until two independent
referees approve it. `Challenge.lean` uses explicit `sorry` placeholders solely to
type-check the proposed statements; a future proof must not import Challenge.

The mathematical source is Matthew J. Colbrook's complete SP-04 manuscript and
canonical README at commit `deb549fa9ddd6b119e6c59016f268237e645dfa2`.
`SOURCE_PROVENANCE.json` records exact Git blob IDs and SHA-256 digests, including
the source text containing the authorship attribution. The new formalization
draft is attributed to Sidney Holden with AI assistance, not to the source author.

## Original target, preserved

For real n-by-n data U, the feasible matrices have absolute determinant one.
A stationary pair satisfies Xᵀ(U−X)=cI. The proposed rule selects the unique
stationary pair with least absolute multiplier and claims global nearestness in
Frobenius norm, for algebraic-generic data in every dimension n≥2.

The target here is the negation of that complete generic rule. Both determinant
signs are included. `UniqueLeast` quantifies over **all real stationary pairs**,
not only diagonal candidates. `Nearest` compares with **all feasible matrices**.
The squared Frobenius distance is an explicit double sum; its order is equivalent
to that of the Frobenius norm. No supplied spectral or optimization assumption is
substituted for the original matrix equations.

`GenericSmallestMultiplierConjecture` permits a nonzero exceptional polynomial
in all n² entries separately for each dimension. This expresses the proper-real-
algebraic-exception meaning: every proper algebraic exceptional set is contained
in the zero locus of a nonzero polynomial. The counterexample is proved in n=3
against **every** such polynomial. The statement restricts the rule to unique
least choices as explicitly permitted by the canonical target; existence and
uniqueness of this choice are conclusions for the counterexamples. Finiteness of
the whole stationary set is not assumed as a substitute for existence/uniqueness.

## Exact numerical statements

All three real parameters satisfy 7/4 < s₀ < s₁ < s₂ < 44/25.

1. For every 0≤c≤13/25 there is no real triple x with |x₀x₁x₂|=1 and
   xᵢ²−sᵢxᵢ+c=0 for all i.
2. Put a(s,t)=(s+sqrt(s²+4t))/2. There exists exactly one t in (0,13/25)
   satisfying t·a(s₁,t)·a(s₂,t)/a(s₀,t)=1.
3. Every real stationary matrix for diagonal data in this full parameter region
   is diagonal and its entries obey exactly those quadratic and determinant
   equations. This is a theorem obligation, not a definition of stationarity.
4. Every diagonal datum in the region has a unique least stationary pair which
   is not nearest. The proof must classify the finite root-sign patterns and
   prove the strict comparison, not merely exhibit one bad stationary point.

Planned computation reduction, not an additional hypothesis: for positive c,
the large quadratic roots rᵢ satisfy r_min>1, r_max<44/25 and
r_max−r_min<1/50, hence r_max/r_min<51/50. The small-root product bound is
(13/25)(44/25)(51/50)=29172/31250<1. Rational radicand estimates and the
square-root-difference identity avoid derivative computation or wide interval
subdivision. LeanCert can certify the scalar inequalities; existence, uniqueness,
matrix identities, topology and polynomial genericity require ordinary proofs.

## Generic extension obligations

5. Define the family as **all** P·diag(s)·Qᵀ with the parameter conditions above
   and real orthogonal P,Q. Every datum in this family has the same unique-choice
   failure. Orthogonal invariance must be proved.
6. Prove this family is nonempty and open in the full space of real 3-by-3
   matrices. Openness in the diagonal subspace alone is insufficient.
7. For every nonzero real polynomial in the nine data entries, prove some datum
   in that family lies outside its zero set.
8. Combine these results into a generic counterexample for every nonzero
   exceptional polynomial, then negate the all-dimensions conjecture.

The nine theorem declarations in Challenge are the proposed comparator exports.
The future comparator configuration must check all nine and allow only the
standard logical axioms. The type-check receipt does not certify any theorem.
No Solution file or proof body is present in this draft.
