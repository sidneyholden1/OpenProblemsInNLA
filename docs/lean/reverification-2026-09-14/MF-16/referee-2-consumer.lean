import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.MF16.word_semantics
#print axioms NLA.MF16.word_semantics
#assert_trust kernel NLA.MF16.word_semantics
#check @NLA.MF16.source_data
#print axioms NLA.MF16.source_data
#assert_trust kernel NLA.MF16.source_data
#check @NLA.MF16.twelfth_power_reduction
#print axioms NLA.MF16.twelfth_power_reduction
#assert_trust kernel NLA.MF16.twelfth_power_reduction
#check @NLA.MF16.polynomial_word_equivalence
#print axioms NLA.MF16.polynomial_word_equivalence
#assert_trust kernel NLA.MF16.polynomial_word_equivalence
#check @NLA.MF16.krawczyk_certificate
#print axioms NLA.MF16.krawczyk_certificate
#assert_trust kernel NLA.MF16.krawczyk_certificate
#check @NLA.MF16.certified_root
#print axioms NLA.MF16.certified_root
#assert_trust kernel NLA.MF16.certified_root
#check @NLA.MF16.root_to_matrix
#print axioms NLA.MF16.root_to_matrix
#assert_trust kernel NLA.MF16.root_to_matrix
#check @NLA.MF16.counterexample
#print axioms NLA.MF16.counterexample
#assert_trust kernel NLA.MF16.counterexample
#check @NLA.MF16.not_wordUniquenessConjecture
#print axioms NLA.MF16.not_wordUniquenessConjecture
#assert_trust kernel NLA.MF16.not_wordUniquenessConjecture
#print NLA.MF16.actual_krawczyk_checked
#print axioms NLA.MF16.actual_krawczyk_checked
#assert_trust kernel NLA.MF16.actual_krawczyk_checked
#print NLA.MF16.preconditioner_det_exact
#print axioms NLA.MF16.preconditioner_det_exact
#assert_trust kernel NLA.MF16.preconditioner_det_exact
#print NLA.MF16.box_radius_exact
#print axioms NLA.MF16.box_radius_exact
#assert_trust kernel NLA.MF16.box_radius_exact
#print NLA.MF16.contraction_bound_small
#print axioms NLA.MF16.contraction_bound_small
#assert_trust kernel NLA.MF16.contraction_bound_small
#print NLA.MF16.certified_root_proved
#print axioms NLA.MF16.certified_root_proved
#assert_trust kernel NLA.MF16.certified_root_proved
