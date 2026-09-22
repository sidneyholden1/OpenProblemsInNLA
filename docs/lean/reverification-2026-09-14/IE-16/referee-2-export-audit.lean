import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.IE16.explicitL_card
#print axioms NLA.IE16.explicitL_card
#assert_trust kernel NLA.IE16.explicitL_card
#check @NLA.IE16.explicitL_admissible
#print axioms NLA.IE16.explicitL_admissible
#assert_trust kernel NLA.IE16.explicitL_admissible
#check @NLA.IE16.witness_feasible
#print axioms NLA.IE16.witness_feasible
#assert_trust kernel NLA.IE16.witness_feasible
#check @NLA.IE16.witness_objective
#print axioms NLA.IE16.witness_objective
#assert_trust kernel NLA.IE16.witness_objective
#check @NLA.IE16.full_minimum_exact
#print axioms NLA.IE16.full_minimum_exact
#assert_trust kernel NLA.IE16.full_minimum_exact
#check @NLA.IE16.full_minimum_isLeast
#print axioms NLA.IE16.full_minimum_isLeast
#assert_trust kernel NLA.IE16.full_minimum_isLeast
#check @NLA.IE16.full_lower_bound
#print axioms NLA.IE16.full_lower_bound
#assert_trust kernel NLA.IE16.full_lower_bound
#check @NLA.IE16.every_five_point_subset_upper
#print axioms NLA.IE16.every_five_point_subset_upper
#assert_trust kernel NLA.IE16.every_five_point_subset_upper
#check @NLA.IE16.every_five_point_subset_minimum_isLeast
#print axioms NLA.IE16.every_five_point_subset_minimum_isLeast
#assert_trust kernel NLA.IE16.every_five_point_subset_minimum_isLeast
#check @NLA.IE16.subset_max_upper
#print axioms NLA.IE16.subset_max_upper
#assert_trust kernel NLA.IE16.subset_max_upper
#check @NLA.IE16.subset_max_positive
#print axioms NLA.IE16.subset_max_positive
#assert_trust kernel NLA.IE16.subset_max_positive
#check @NLA.IE16.ratio_lower_bound
#print axioms NLA.IE16.ratio_lower_bound
#assert_trust kernel NLA.IE16.ratio_lower_bound
#check @NLA.IE16.ratio_exceeds_candidate
#print axioms NLA.IE16.ratio_exceeds_candidate
#assert_trust kernel NLA.IE16.ratio_exceeds_candidate
#check @NLA.IE16.counterexample
#print axioms NLA.IE16.counterexample
#assert_trust kernel NLA.IE16.counterexample
#check @NLA.IE16.not_IE16Conjecture
#print axioms NLA.IE16.not_IE16Conjecture
#assert_trust kernel NLA.IE16.not_IE16Conjecture
