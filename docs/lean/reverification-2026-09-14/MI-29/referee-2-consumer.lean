import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.MI29.spectralPower_natCast
#print axioms NLA.MI29.spectralPower_natCast
#assert_trust kernel NLA.MI29.spectralPower_natCast
#check @NLA.MI29.modulus_power_eight
#print axioms NLA.MI29.modulus_power_eight
#assert_trust kernel NLA.MI29.modulus_power_eight
#check @NLA.MI29.comparison_positive_real
#print axioms NLA.MI29.comparison_positive_real
#assert_trust kernel NLA.MI29.comparison_positive_real
#check @NLA.MI29.counterexample
#print axioms NLA.MI29.counterexample
#assert_trust kernel NLA.MI29.counterexample
#check @NLA.MI29.not_modulusDeterminantConjecture
#print axioms NLA.MI29.not_modulusDeterminantConjecture
#assert_trust kernel NLA.MI29.not_modulusDeterminantConjecture
#print NLA.MI29.scalar_gap_positive
#print axioms NLA.MI29.scalar_gap_positive
#assert_trust kernel NLA.MI29.scalar_gap_positive
