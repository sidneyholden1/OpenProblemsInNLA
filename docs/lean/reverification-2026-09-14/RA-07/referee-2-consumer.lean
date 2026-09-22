import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.RA07.elementary_values
#print axioms NLA.RA07.elementary_values
#assert_trust kernel NLA.RA07.elementary_values
#check @NLA.RA07.generating_derivative_values
#print axioms NLA.RA07.generating_derivative_values
#assert_trust kernel NLA.RA07.generating_derivative_values
#check @NLA.RA07.positive_derivative_factorization
#print axioms NLA.RA07.positive_derivative_factorization
#assert_trust kernel NLA.RA07.positive_derivative_factorization
#check @NLA.RA07.power_sum_certificate
#print axioms NLA.RA07.power_sum_certificate
#assert_trust kernel NLA.RA07.power_sum_certificate
#check @NLA.RA07.second_difference_certificate
#print axioms NLA.RA07.second_difference_certificate
#assert_trust kernel NLA.RA07.second_difference_certificate
#check @NLA.RA07.errorSequence_convex
#print axioms NLA.RA07.errorSequence_convex
#assert_trust kernel NLA.RA07.errorSequence_convex
