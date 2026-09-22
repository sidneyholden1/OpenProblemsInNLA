import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.MI07.modulus_eq_sqrt
#print axioms NLA.MI07.modulus_eq_sqrt
#assert_trust kernel NLA.MI07.modulus_eq_sqrt
#check @NLA.MI07.maximalModulus_eq_of_tendsto
#print axioms NLA.MI07.maximalModulus_eq_of_tendsto
#assert_trust kernel NLA.MI07.maximalModulus_eq_of_tendsto
#check @NLA.MI07.root_limit_iff_spectralNorm
#print axioms NLA.MI07.root_limit_iff_spectralNorm
#assert_trust kernel NLA.MI07.root_limit_iff_spectralNorm
#check @NLA.MI07.witness_moduli
#print axioms NLA.MI07.witness_moduli
#assert_trust kernel NLA.MI07.witness_moduli
#check @NLA.MI07.witness_root_limits
#print axioms NLA.MI07.witness_root_limits
#assert_trust kernel NLA.MI07.witness_root_limits
#check @NLA.MI07.counterexample
#print axioms NLA.MI07.counterexample
#assert_trust kernel NLA.MI07.counterexample
#check @NLA.MI07.not_triangleConjecture
#print axioms NLA.MI07.not_triangleConjecture
#assert_trust kernel NLA.MI07.not_triangleConjecture
set_option pp.proofs true
#print NLA.MI07.scalar_gap_positive
