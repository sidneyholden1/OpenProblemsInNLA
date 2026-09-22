# MF-22 exact roots, spectral data and finite Green cancellation

Author implementation notes, not an independent review. Source mathematics:
George Stepaniants. Formalization: Sidney Holden with OpenAI Codex assistance.
These notes cover the completed scalar/spectral/Green modules; they do not
claim the separate original finite Toeplitz inverse bridge is completed.

`Scalar` records the literal source coefficients, numerator and denominator,
quartic/cubic factorization and reciprocal identity. `Coprime` proves no common
root by exact algebra. Its quadratic resultant identity is proved as an elementary
linear combination of the two root equations. The other branch clears one
nonzero denominator and uses the source's exact real/imaginary polynomial
combination. No resultant oracle or numerical root isolation is used.

`CubicRoots` derives a real root and nonreal conjugate pair from Mathlib's
three-root splitting and discriminant-product identity. Distinctness follows
from nonzero discriminant; if all three roots were real the discriminant would
be nonnegative. Conjugation preserves the roots, and the real coefficient of
quadratic degree makes the remaining root real. `Cayley` proves the strictly
negative source discriminant and exact Cayley identity. Its norm comparison is
just the squared-modulus formula. `Roots` explicitly separates rho²=10: there
it uses (-20+i sqrt(14600))/(50 rho) and its conjugate, plus the missing root -1.
The other branch uses the generic cubic result. Adding1 yields four distinct,
nonzero quartic roots, one expanding and the other three of norm at most1.

`SpectralBasis` builds an actual eigenbasis using distinct eigenvectors and
finite dimension4. Its coordinate projectors are rankone without orthogonality
or normality assumptions. Matrix powers are a finite sum of eigenvalue powers.
`SpectralAdjugate` proves adjugate similarity under an actual pair of inverse
basis matrices. The adjugate of the diagonal resolvent is the diagonal of its
three-factor cofactors. At the reciprocal expanding root only the corresponding
projector remains. The true adjugate00 entry equals numerator/a, which is nonzero
by coprimality. Therefore projector00 is nonzero; no analytic pole or formal
power-series assertion is needed. `Decomposition` bounds the remaining three
modes by a finite sum of fixed projector entry norms. `ActualSpectral` discharges
the exact characteristic and adjugate identities with `Transfer`'s proofs.

`GrowthDenominator` uses ordinary exponential divergence and the reverse triangle
inequality to bound the actual boundary denominator below by
norm(gamma)*norm(lam)^n/2 eventually. Each ratio lam^k*x/a_n with k≤n is then
bounded by2 norm(x)/norm(gamma).

`GreenBounds` uses only natural exponents. For l<j put m=j-1-l and t=n-1-l;
the exact identity m+n=j+t cancels the double-projector term after clearing
the actual nonzero denominator. The remaining expression is R_m plus four
bounded power ratios. For l≥j the forward term is absent, and j+t≤n directly
bounds the four terms. One constant bounds all projector and remainder entries;
products are bounded by its square. This covers j=0,j=n and every l<n.
`ActualGreen.transfer_green_bounded` derives eventual nonzero denominator and
uniform Green-entry bounds for the original transfer at every rho>0, with no
spectral facts as external assumptions.

The actual roots, coprimality, transfer spectral decomposition and transfer Green
bound are checked by LeanCert kernel assertions and separate printed axiom
closures in verification/AnalyticAuthorAudit.lean. These are author checks;
independent final reviewers and the isolated Linux Comparator remain separate.
