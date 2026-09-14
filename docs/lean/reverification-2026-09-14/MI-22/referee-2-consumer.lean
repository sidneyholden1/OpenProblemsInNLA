import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.MI22.singular_values_semantics
#print axioms NLA.MI22.singular_values_semantics
#assert_trust kernel NLA.MI22.singular_values_semantics
#check @NLA.MI22.spectral_power_semantics
#print axioms NLA.MI22.spectral_power_semantics
#assert_trust kernel NLA.MI22.spectral_power_semantics
#check @NLA.MI22.euclidean_norm_bounds
#print axioms NLA.MI22.euclidean_norm_bounds
#assert_trust kernel NLA.MI22.euclidean_norm_bounds
#check @NLA.MI22.witness_rational_data
#print axioms NLA.MI22.witness_rational_data
#assert_trust kernel NLA.MI22.witness_rational_data
#check @NLA.MI22.witness_principal_powers
#print axioms NLA.MI22.witness_principal_powers
#assert_trust kernel NLA.MI22.witness_principal_powers
#check @NLA.MI22.witness_operator_gap
#print axioms NLA.MI22.witness_operator_gap
#assert_trust kernel NLA.MI22.witness_operator_gap
#check @NLA.MI22.counterexample
#print axioms NLA.MI22.counterexample
#assert_trust kernel NLA.MI22.counterexample
#check @NLA.MI22.not_weightedLogMajorizationConjecture
#print axioms NLA.MI22.not_weightedLogMajorizationConjecture
#assert_trust kernel NLA.MI22.not_weightedLogMajorizationConjecture
#print NLA.MI22.numerical_separation
#print axioms NLA.MI22.numerical_separation
#assert_trust kernel NLA.MI22.numerical_separation
