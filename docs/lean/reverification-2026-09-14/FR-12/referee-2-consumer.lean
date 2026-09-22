import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.FR12.counting_semantics
#print axioms NLA.FR12.counting_semantics
#assert_trust kernel NLA.FR12.counting_semantics
#check @NLA.FR12.injective_doubling
#print axioms NLA.FR12.injective_doubling
#assert_trust kernel NLA.FR12.injective_doubling
#check @NLA.FR12.factorial_doubling
#print axioms NLA.FR12.factorial_doubling
#assert_trust kernel NLA.FR12.factorial_doubling
#check @NLA.FR12.power_two_nonempty
#print axioms NLA.FR12.power_two_nonempty
#assert_trust kernel NLA.FR12.power_two_nonempty
#check @NLA.FR12.power_two_lower_bound
#print axioms NLA.FR12.power_two_lower_bound
#assert_trust kernel NLA.FR12.power_two_lower_bound
#check @NLA.FR12.counterexample
#print axioms NLA.FR12.counterexample
#assert_trust kernel NLA.FR12.counterexample
#check @NLA.FR12.not_countingConjecture
#print axioms NLA.FR12.not_countingConjecture
#assert_trust kernel NLA.FR12.not_countingConjecture
