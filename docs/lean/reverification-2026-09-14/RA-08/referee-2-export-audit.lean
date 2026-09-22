import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.RA08.orderedSpectral_exists
#print axioms NLA.RA08.orderedSpectral_exists
#assert_trust kernel NLA.RA08.orderedSpectral_exists
#check @NLA.RA08.orderedSpectral_semantics
#print axioms NLA.RA08.orderedSpectral_semantics
#assert_trust kernel NLA.RA08.orderedSpectral_semantics
#check @NLA.RA08.functionalCalculus_spectral
#print axioms NLA.RA08.functionalCalculus_spectral
#assert_trust kernel NLA.RA08.functionalCalculus_spectral
#check @NLA.RA08.spectral_tail_norms
#print axioms NLA.RA08.spectral_tail_norms
#assert_trust kernel NLA.RA08.spectral_tail_norms
#check @NLA.RA08.operator_rayleigh_bound
#print axioms NLA.RA08.operator_rayleigh_bound
#assert_trust kernel NLA.RA08.operator_rayleigh_bound
#check @NLA.RA08.witness_data
#print axioms NLA.RA08.witness_data
#assert_trust kernel NLA.RA08.witness_data
#check @NLA.RA08.witness_spectral_location
#print axioms NLA.RA08.witness_spectral_location
#assert_trust kernel NLA.RA08.witness_spectral_location
#check @NLA.RA08.minorant_scalar
#print axioms NLA.RA08.minorant_scalar
#assert_trust kernel NLA.RA08.minorant_scalar
#check @NLA.RA08.minorant_functional_calculus
#print axioms NLA.RA08.minorant_functional_calculus
#assert_trust kernel NLA.RA08.minorant_functional_calculus
#check @NLA.RA08.witness_tail_data
#print axioms NLA.RA08.witness_tail_data
#assert_trust kernel NLA.RA08.witness_tail_data
#check @NLA.RA08.witness_rational_certificate
#print axioms NLA.RA08.witness_rational_certificate
#assert_trust kernel NLA.RA08.witness_rational_certificate
#check @NLA.RA08.numerical_gap_positive
#print axioms NLA.RA08.numerical_gap_positive
#assert_trust kernel NLA.RA08.numerical_gap_positive
#check @NLA.RA08.counterexample
#print axioms NLA.RA08.counterexample
#assert_trust kernel NLA.RA08.counterexample
#check @NLA.RA08.not_concaveSpectralTransferConjecture
#print axioms NLA.RA08.not_concaveSpectralTransferConjecture
#assert_trust kernel NLA.RA08.not_concaveSpectralTransferConjecture
set_option pp.proofs true in
#print NLA.RA08.numerical_gap_positive_proved
