import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.MI19.counterexample
#print axioms NLA.MI19.counterexample
#assert_trust kernel NLA.MI19.counterexample
#check @NLA.MI19.not_subsetConjecture
#print axioms NLA.MI19.not_subsetConjecture
#assert_trust kernel NLA.MI19.not_subsetConjecture
#print NLA.MI19.strict_scalar_gap
#print axioms NLA.MI19.strict_scalar_gap
#assert_trust kernel NLA.MI19.strict_scalar_gap
