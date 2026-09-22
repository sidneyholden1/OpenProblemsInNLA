import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.IS03.nonnegative_power_trace
#print axioms NLA.IS03.nonnegative_power_trace
#assert_trust kernel NLA.IS03.nonnegative_power_trace
#check @NLA.IS03.witness_admissible
#print axioms NLA.IS03.witness_admissible
#assert_trust kernel NLA.IS03.witness_admissible
#check @NLA.IS03.witness_polynomials
#print axioms NLA.IS03.witness_polynomials
#assert_trust kernel NLA.IS03.witness_polynomials
#check @NLA.IS03.trace_moment_certificate
#print axioms NLA.IS03.trace_moment_certificate
#assert_trust kernel NLA.IS03.trace_moment_certificate
#check @NLA.IS03.negative_moment
#print axioms NLA.IS03.negative_moment
#assert_trust kernel NLA.IS03.negative_moment
#check @NLA.IS03.counterexample
#print axioms NLA.IS03.counterexample
#assert_trust kernel NLA.IS03.counterexample
#check @NLA.IS03.not_derivativeRealizabilityConjecture
#print axioms NLA.IS03.not_derivativeRealizabilityConjecture
#assert_trust kernel NLA.IS03.not_derivativeRealizabilityConjecture
set_option pp.proofs true in
#print NLA.IS03.numerical_negative_moment
