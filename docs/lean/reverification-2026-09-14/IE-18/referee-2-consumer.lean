import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.IE18.residual_certificate
#print axioms NLA.IE18.residual_certificate
#assert_trust kernel NLA.IE18.residual_certificate
#check @NLA.IE18.counterexample
#print axioms NLA.IE18.counterexample
#assert_trust kernel NLA.IE18.counterexample
#check @NLA.IE18.not_fourStepConjecture
#print axioms NLA.IE18.not_fourStepConjecture
#assert_trust kernel NLA.IE18.not_fourStepConjecture
#print NLA.IE18.strict_scalar_gap
#print axioms NLA.IE18.strict_scalar_gap
#assert_trust kernel NLA.IE18.strict_scalar_gap
#print NLA.IE18.strict_amplification_gap
#print axioms NLA.IE18.strict_amplification_gap
#assert_trust kernel NLA.IE18.strict_amplification_gap
