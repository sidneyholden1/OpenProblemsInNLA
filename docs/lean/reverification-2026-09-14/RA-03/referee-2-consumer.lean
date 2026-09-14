import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.RA03.frobeniusSq_eq_norm_sq
#print axioms NLA.RA03.frobeniusSq_eq_norm_sq
#assert_trust kernel NLA.RA03.frobeniusSq_eq_norm_sq
#check @NLA.RA03.process_isProbability
#print axioms NLA.RA03.process_isProbability
#assert_trust kernel NLA.RA03.process_isProbability
#check @NLA.RA03.counterexample
#print axioms NLA.RA03.counterexample
#assert_trust kernel NLA.RA03.counterexample
#check @NLA.RA03.not_squaredErrorConjecture
#print axioms NLA.RA03.not_squaredErrorConjecture
#assert_trust kernel NLA.RA03.not_squaredErrorConjecture
#print NLA.RA03.strict_scalar_gap
#print axioms NLA.RA03.strict_scalar_gap
#assert_trust kernel NLA.RA03.strict_scalar_gap
