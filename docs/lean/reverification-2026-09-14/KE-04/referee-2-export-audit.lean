import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
#check @NLA.KE04.real_matrix_semantics
#print axioms NLA.KE04.real_matrix_semantics
#assert_trust kernel NLA.KE04.real_matrix_semantics
#check @NLA.KE04.krylov_range_semantics
#print axioms NLA.KE04.krylov_range_semantics
#assert_trust kernel NLA.KE04.krylov_range_semantics
#check @NLA.KE04.krylov_nesting_and_shift
#print axioms NLA.KE04.krylov_nesting_and_shift
#assert_trust kernel NLA.KE04.krylov_nesting_and_shift
#check @NLA.KE04.fullBlockDimension_iff_independent
#print axioms NLA.KE04.fullBlockDimension_iff_independent
#assert_trust kernel NLA.KE04.fullBlockDimension_iff_independent
#check @NLA.KE04.fullBlockDimension_prefix
#print axioms NLA.KE04.fullBlockDimension_prefix
#assert_trust kernel NLA.KE04.fullBlockDimension_prefix
#check @NLA.KE04.lastFullBlockIteration_exists
#print axioms NLA.KE04.lastFullBlockIteration_exists
#assert_trust kernel NLA.KE04.lastFullBlockIteration_exists
#check @NLA.KE04.krylovBasis_exists
#print axioms NLA.KE04.krylovBasis_exists
#assert_trust kernel NLA.KE04.krylovBasis_exists
#check @NLA.KE04.frameProjection_semantics
#print axioms NLA.KE04.frameProjection_semantics
#assert_trust kernel NLA.KE04.frameProjection_semantics
#check @NLA.KE04.compression_semantics
#print axioms NLA.KE04.compression_semantics
#assert_trust kernel NLA.KE04.compression_semantics
#check @NLA.KE04.orderedSpectrum_semantics
#print axioms NLA.KE04.orderedSpectrum_semantics
#assert_trust kernel NLA.KE04.orderedSpectrum_semantics
#check @NLA.KE04.compression_basis_independent
#print axioms NLA.KE04.compression_basis_independent
#assert_trust kernel NLA.KE04.compression_basis_independent
#check @NLA.KE04.interval_index_validity
#print axioms NLA.KE04.interval_index_validity
#assert_trust kernel NLA.KE04.interval_index_validity
#check @NLA.KE04.quadratic_semantics
#print axioms NLA.KE04.quadratic_semantics
#assert_trust kernel NLA.KE04.quadratic_semantics
#check @NLA.KE04.spectral_gap_quadratic_psd
#print axioms NLA.KE04.spectral_gap_quadratic_psd
#assert_trust kernel NLA.KE04.spectral_gap_quadratic_psd
#check @NLA.KE04.spectral_window_subspace
#print axioms NLA.KE04.spectral_window_subspace
#assert_trust kernel NLA.KE04.spectral_window_subspace
#check @NLA.KE04.krylov_intersection_nonzero
#print axioms NLA.KE04.krylov_intersection_nonzero
#assert_trust kernel NLA.KE04.krylov_intersection_nonzero
#check @NLA.KE04.psd_zero_form_iff_kernel
#print axioms NLA.KE04.psd_zero_form_iff_kernel
#assert_trust kernel NLA.KE04.psd_zero_form_iff_kernel
#check @NLA.KE04.compressedQuadratic_semantics
#print axioms NLA.KE04.compressedQuadratic_semantics
#assert_trust kernel NLA.KE04.compressedQuadratic_semantics
#check @NLA.KE04.quadratic_forms_agree
#print axioms NLA.KE04.quadratic_forms_agree
#assert_trust kernel NLA.KE04.quadratic_forms_agree
#check @NLA.KE04.later_quadratic_identity
#print axioms NLA.KE04.later_quadratic_identity
#assert_trust kernel NLA.KE04.later_quadratic_identity
#check @NLA.KE04.fullRank_quadratic_nonannihilation
#print axioms NLA.KE04.fullRank_quadratic_nonannihilation
#assert_trust kernel NLA.KE04.fullRank_quadratic_nonannihilation
#check @NLA.KE04.strictIntervalOccupancy
#print axioms NLA.KE04.strictIntervalOccupancy
#assert_trust kernel NLA.KE04.strictIntervalOccupancy
#check @NLA.KE04.fullPrefix_implies_canonical
#print axioms NLA.KE04.fullPrefix_implies_canonical
#assert_trust kernel NLA.KE04.fullPrefix_implies_canonical
#check @NLA.KE04.blockLanczosConjecture
#print axioms NLA.KE04.blockLanczosConjecture
#assert_trust kernel NLA.KE04.blockLanczosConjecture
