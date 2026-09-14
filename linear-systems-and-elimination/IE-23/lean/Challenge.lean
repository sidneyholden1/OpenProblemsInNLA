/- Trusted reviewed statements; deliberate placeholders never imported by Solution. -/
import NLA.IE23.Definitions
set_option autoImplicit false
namespace NLA.IE23

theorem witness_algebra :
    FullRowRank witnessA ∧ pseudoInverse witnessA = witnessB ∧
    witnessA * witnessB = 1 ∧ witnessA * witnessX = 1 ∧ witnessX ≠ witnessB := by sorry

theorem norm_certificates :
    (ratios 4 witnessB).Nonempty ∧ BddAbove (ratios 4 witnessB) ∧
    (ratios 4 witnessX).Nonempty ∧ BddAbove (ratios 4 witnessX) ∧
    inducedNorm 4 witnessB = (2 : ℝ) ^ (1 / 4 : ℝ) ∧
    inducedNorm 4 witnessX = (2 : ℝ) ^ (1 / 4 : ℝ) := by sorry

theorem not_uniquenessConjecture : ¬ UniquenessConjecture := by sorry
end NLA.IE23
