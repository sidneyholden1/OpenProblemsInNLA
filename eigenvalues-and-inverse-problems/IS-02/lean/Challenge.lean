import NLA.IS02.Definitions
set_option autoImplicit false
open scoped BigOperators Matrix
noncomputable section
namespace NLA.IS02

theorem witness_certificates :
    witness ∈ stochasticSet 4 ∧
    witness.charpoly = Polynomial.X * (Polynomial.X-1)^2 * (Polynomial.X+1) ∧
    Matrix.trace witness = 1 ∧ 0 < Matrix.trace witness := by sorry

theorem spectral_uniqueness : spectrallyUnique witness := by sorry

theorem locus_exclusion :
    endpointLeft ∈ stochasticSet 4 ∧ endpointRight ∈ stochasticSet 4 ∧
    endpointLeft ≠ endpointRight ∧
    witness = (1/2 : ℝ) • endpointLeft + (1/2 : ℝ) • endpointRight ∧
    witness ∉ (stochasticSet 4).extremePoints ℝ ∧
    witness ∉ proposedLocus 4 := by sorry

theorem counterexample : ¬ LocusConjecture := by sorry
end NLA.IS02
