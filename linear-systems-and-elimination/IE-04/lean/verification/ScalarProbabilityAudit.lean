import NLA.IE04.PolynomialNull
import NLA.IE04.GaussianBounds
import NLA.IE04.Asymptotic
import LeanCert.Tactic.Verification
#assert_trust kernel NLA.IE04.gaussian_polynomial_ae_ne_zero
#print axioms NLA.IE04.gaussian_polynomial_ae_ne_zero
#assert_trust kernel NLA.IE04.gaussian_density_lower_proved
#print axioms NLA.IE04.gaussian_density_lower_proved
#assert_trust kernel NLA.IE04.asymptotic_escape_proved
#print axioms NLA.IE04.asymptotic_escape_proved
set_option pp.proofs true in
set_option pp.deepTerms true in
#print NLA.IE04.exp_neg_two_lower
