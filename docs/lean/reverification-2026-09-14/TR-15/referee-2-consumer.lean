import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.TR15.lower_contractions
#print axioms NLA.TR15.lower_contractions
#assert_trust kernel NLA.TR15.lower_contractions
#check @NLA.TR15.upper_contraction
#print axioms NLA.TR15.upper_contraction
#assert_trust kernel NLA.TR15.upper_contraction
#check @NLA.TR15.lower_eigenvalues_pos
#print axioms NLA.TR15.lower_eigenvalues_pos
#assert_trust kernel NLA.TR15.lower_eigenvalues_pos
#check @NLA.TR15.lower_eigenpair_exists
#print axioms NLA.TR15.lower_eigenpair_exists
#assert_trust kernel NLA.TR15.lower_eigenpair_exists
#check @NLA.TR15.upper_negative_eigenpair
#print axioms NLA.TR15.upper_negative_eigenpair
#assert_trust kernel NLA.TR15.upper_negative_eigenpair
#check @NLA.TR15.counterexample
#print axioms NLA.TR15.counterexample
#assert_trust kernel NLA.TR15.counterexample
#check @NLA.TR15.not_inheritanceConjecture
#print axioms NLA.TR15.not_inheritanceConjecture
#assert_trust kernel NLA.TR15.not_inheritanceConjecture
#print NLA.TR15.negative_eigenvalue_certificate
#print axioms NLA.TR15.negative_eigenvalue_certificate
#assert_trust kernel NLA.TR15.negative_eigenvalue_certificate
#print NLA.TR15.upper_negative_eigenpair_proved
#print axioms NLA.TR15.upper_negative_eigenpair_proved
#assert_trust kernel NLA.TR15.upper_negative_eigenpair_proved
