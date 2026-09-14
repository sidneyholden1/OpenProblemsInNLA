import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.MI26.admissibleFunction_iff
#print axioms NLA.MI26.admissibleFunction_iff
#assert_trust kernel NLA.MI26.admissibleFunction_iff
#check @NLA.MI26.functionalCalculus_eq_spectral
#print axioms NLA.MI26.functionalCalculus_eq_spectral
#assert_trust kernel NLA.MI26.functionalCalculus_eq_spectral
#check @NLA.MI26.functionalCalculus_congr_nonneg
#print axioms NLA.MI26.functionalCalculus_congr_nonneg
#assert_trust kernel NLA.MI26.functionalCalculus_congr_nonneg
#check @NLA.MI26.quadratic_cfc
#print axioms NLA.MI26.quadratic_cfc
#assert_trust kernel NLA.MI26.quadratic_cfc
#check @NLA.MI26.witness_data
#print axioms NLA.MI26.witness_data
#assert_trust kernel NLA.MI26.witness_data
#check @NLA.MI26.counterexample
#print axioms NLA.MI26.counterexample
#assert_trust kernel NLA.MI26.counterexample
#check @NLA.MI26.not_subadditivityConjecture
#print axioms NLA.MI26.not_subadditivityConjecture
#assert_trust kernel NLA.MI26.not_subadditivityConjecture
set_option pp.proofs true
#print NLA.MI26.witness_positive
