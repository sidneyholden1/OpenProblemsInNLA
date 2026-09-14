/- Complete exports independent of the trusted Challenge environment. -/
import NLA.IE23.Proof
set_option autoImplicit false
namespace NLA.IE23

theorem witness_algebra :
    FullRowRank witnessA ∧ pseudoInverse witnessA = witnessB ∧
    witnessA * witnessB = 1 ∧ witnessA * witnessX = 1 ∧ witnessX ≠ witnessB := witness_algebra_proved

theorem norm_certificates :
    (ratios 4 witnessB).Nonempty ∧ BddAbove (ratios 4 witnessB) ∧
    (ratios 4 witnessX).Nonempty ∧ BddAbove (ratios 4 witnessX) ∧
    inducedNorm 4 witnessB = (2 : ℝ) ^ (1 / 4 : ℝ) ∧
    inducedNorm 4 witnessX = (2 : ℝ) ^ (1 / 4 : ℝ) := norm_certificates_proved

theorem not_uniquenessConjecture : ¬ UniquenessConjecture := not_uniquenessConjecture_proved

#assert_trust kernel witness_algebra
#assert_trust kernel norm_certificates
#assert_trust kernel not_uniquenessConjecture
end NLA.IE23
