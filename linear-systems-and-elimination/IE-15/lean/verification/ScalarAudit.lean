import NLA.IE15.ScalarFour
import LeanCert.Tactic.Verification
#assert_trust kernel NLA.IE15.two_pivot_scalar_bound
#assert_trust kernel NLA.IE15.scalar_three_bound
#print axioms NLA.IE15.two_pivot_scalar_bound
#print axioms NLA.IE15.scalar_three_bound

#assert_trust kernel NLA.IE15.scalar_four_bound
#print axioms NLA.IE15.scalar_four_bound
