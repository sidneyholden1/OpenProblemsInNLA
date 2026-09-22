import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.IE19.counterexample
#print axioms NLA.IE19.counterexample
#assert_trust kernel NLA.IE19.counterexample
#check @NLA.IE19.not_lowerBoundConjecture
#print axioms NLA.IE19.not_lowerBoundConjecture
#assert_trust kernel NLA.IE19.not_lowerBoundConjecture
#check @NLA.IE19.not_sharpConjecture
#print axioms NLA.IE19.not_sharpConjecture
#assert_trust kernel NLA.IE19.not_sharpConjecture
#print NLA.IE19.strict_scalar_gap
#print axioms NLA.IE19.strict_scalar_gap
#assert_trust kernel NLA.IE19.strict_scalar_gap
#print NLA.IE19.counterexample_proved
#print axioms NLA.IE19.counterexample_proved
#assert_trust kernel NLA.IE19.counterexample_proved
