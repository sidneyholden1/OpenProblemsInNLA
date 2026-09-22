import NLA.MI04.Threshold
import LeanCert.Tactic.Verification
set_option leancert.trust "kernel"
#assert_trust kernel NLA.MI04.universal_unitary
#assert_trust kernel NLA.MI04.scalar_sum_reflection
#assert_trust kernel NLA.MI04.arrow_schur
#assert_trust kernel NLA.MI04.weighted_threshold
#print axioms NLA.MI04.universal_unitary
#print axioms NLA.MI04.scalar_sum_reflection
#print axioms NLA.MI04.arrow_schur
#print axioms NLA.MI04.weighted_threshold
