import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.MI06.modulus_eq_sqrt
#print axioms NLA.MI06.modulus_eq_sqrt
#assert_trust kernel NLA.MI06.modulus_eq_sqrt
#check @NLA.MI06.witness_moduli
#print axioms NLA.MI06.witness_moduli
#assert_trust kernel NLA.MI06.witness_moduli
#check @NLA.MI06.two_vector_orthogonal
#print axioms NLA.MI06.two_vector_orthogonal
#assert_trust kernel NLA.MI06.two_vector_orthogonal
#check @NLA.MI06.witness_quadratic_bounds
#print axioms NLA.MI06.witness_quadratic_bounds
#assert_trust kernel NLA.MI06.witness_quadratic_bounds
#check @NLA.MI06.counterexample
#print axioms NLA.MI06.counterexample
#assert_trust kernel NLA.MI06.counterexample
#check @NLA.MI06.not_dominationConjecture
#print axioms NLA.MI06.not_dominationConjecture
#assert_trust kernel NLA.MI06.not_dominationConjecture
set_option pp.proofs true
#print _private.NLA.MI06.Proof.0.NLA.MI06.scalar_squared_gap
