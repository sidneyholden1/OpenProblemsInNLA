import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.IE23.inducedNorm_semantics
#print axioms NLA.IE23.inducedNorm_semantics
#assert_trust kernel NLA.IE23.inducedNorm_semantics
#check @NLA.IE23.witness_matrix_identities
#print axioms NLA.IE23.witness_matrix_identities
#assert_trust kernel NLA.IE23.witness_matrix_identities
#check @NLA.IE23.fourth_power_norm_control
#print axioms NLA.IE23.fourth_power_norm_control
#assert_trust kernel NLA.IE23.fourth_power_norm_control
#check @NLA.IE23.witness_action_identities
#print axioms NLA.IE23.witness_action_identities
#assert_trust kernel NLA.IE23.witness_action_identities
#check @NLA.IE23.witness_attainment
#print axioms NLA.IE23.witness_attainment
#assert_trust kernel NLA.IE23.witness_attainment
#check @NLA.IE23.witness_norms
#print axioms NLA.IE23.witness_norms
#assert_trust kernel NLA.IE23.witness_norms
#check @NLA.IE23.witness_global_minimizers
#print axioms NLA.IE23.witness_global_minimizers
#assert_trust kernel NLA.IE23.witness_global_minimizers
#check @NLA.IE23.not_rightInverseUniqueConjecture
#print axioms NLA.IE23.not_rightInverseUniqueConjecture
#assert_trust kernel NLA.IE23.not_rightInverseUniqueConjecture
