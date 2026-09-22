# IE-04 proof architecture

This development follows George Stepaniants's complete counterexample to the
Spielman–Teng exponential smoothed GEPP tail conjecture. It retains actual
row-swap and padded-Schur states, every legal tie schedule, the attained
supremum of actual finite entry maxima, Euclidean operator norm, and the full
product Gaussian matrix law. The extra zero-centered source result is not
claimed: the identity-centered example already negates the entire conjecture.

## Actual GEPP semantics

`GEPPKernel` describes injectivity of the active trailing block by supported
vectors. Explicit lift and tail operations prove that an actual nonzero-pivot
Schur step preserves this injectivity in both directions. At stage zero this
is equivalent to a nonzero determinant; at the final empty stage it is
vacuous. Thus nonsingularity supplies a nonzero available column entry, and
nonzero pivots throughout a schedule imply actual input nonsingularity.

`GEPPPaths` chooses the first row among the finite maximizers, builds its
recursive states, and proves legality from active injectivity. Prefix equality
of schedules implies equality of actual states; this gives first-row uniqueness
and, under strict column comparisons, uniqueness among all legal schedules.
`Growth` proves nonempty, finite, bounded, attained maximum semantics and
input growth at least one. It never replaces the true supremum by a prescribed
recurrence or assumes a legal path exists.

## Exact states and the full perturbation box

`Wilkinson` proves the closed-form reference states by induction for every
n and every stage through n. It derives the unique legal schedule, determinant
nonvanishing, input entry maximum one, and exact growth (3/2)^(n-1).

`Robustness` proves one scalar Schur-update inequality. If the error e is at
most 1/8, the diagonal pivot is at least 7/8, the competing column entries have
magnitude at most 5/8, and the multiplier error is at most 2e. Applied to all
entries, this propagates the actual state error by at most 2^(n+2).
The exact radius identity makes every required state error at most 1/8.
Consequently the entire closed n²-dimensional box has a unique legal path,
is nonsingular, and has strict growth greater than half the exact Wilkinson
growth. No random sample or normalized-input assumption enters this proof.

## Genuine Gaussian genericity and measurability

`Regular`, adapted with credit from the checked KE-05 framework, represents
rational expressions by explicit polynomial numerator/denominator pairs with
a nonzero denominator at a witness. Its inverse constructor preserves all
previous denominator guards. `PolynomialNull` proves the finite-product
nonatomic polynomial null-set theorem by induction and Fubini.

`Realize` reverses actual Schur steps with unit pivots, including undoing every
row swap. It realizes any specified padded trailing block while making every
preceding pivot exactly one. `Generic` uses these witnesses separately for
all admissible schedules and pivot/tie expressions. This avoids the incorrect
shortcut of using an identity witness for off-diagonal comparisons that tie
at zero. Affine surjectivity handles every deterministic center and positive
noise level. Almost-sure nonzero pivots of the identity schedule imply actual
nonsingularity; the finite family of squared-entry comparisons yields unique
legality. `GenericMeasure` transfers this result to the nested Gaussian matrix
law using `GaussianModel`'s actual flattening pushforward identity.

`Measurability` proves measurability of each total recursive state, finite
entry maximum, path growth, and legal-schedule predicate. On nonsingular inputs,
the actual attained-maximum theorem turns the strict tail event into a finite
union. Dimension zero is handled explicitly in this auxiliary measurable-event
theorem, while the original conjecture retains n≥1.

## Material LeanCert certificate and the final tail

`GaussianBounds` uses one kernel dyadic point certificate for exp(-2)>1/8.
Exact monotonicity and sqrt(2π)<3 turn it into the density lower bound 1/32
on the entire interval [-2,2]. `GaussianBox` integrates the actual Gaussian
density over each coordinate interval. `GaussianProduct` proves the exact
nested rectangle identity, multiplies the actual coordinate probabilities,
and derives the exact lower bound 2^(-n²(n²+n+5)).

`Consequences` proves the identity center has Euclidean operator norm one,
connects the full noise box to the strict tail event, and uses actual real
measure monotonicity. `Asymptotic` proves escape against every positive real
choice of exponents. `Tail` combines these facts to violate every candidate
pair and negate the full original quantified assertion.

The environment-value audit in `verification/numerical-route-audit.log` shows
the retained dependency path from the final negation through the actual box
probability to `exp_neg_two_lower`. The printed checker is
`verify_strict_lower_bound_dyadic_checked` on the single point [0,0], precision
-53 and depth 10. `numerical-boolean-audit.log` prints its Boolean proof as
`of_decide_eq_true (id (Eq.refl true))`. This is a material kernel certificate,
not native compiler trust and not an unused side calculation.

`Solution` copies the twelve reviewed signatures and audits each export with
LeanCert kernel trust checks. Mechanical receipts, independent final reviews,
and an actual isolated Linux Comparator are distinct gates; proof notes alone
do not establish any of those statuses.
