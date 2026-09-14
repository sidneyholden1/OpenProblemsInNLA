import NLA.IE05.Definitions
set_option autoImplicit false
open scoped BigOperators Classical Matrix
noncomputable section
namespace NLA.IE05

theorem qr_certificates :
    positiveQR (lowerMatrix 8) candidateQ candidateR ∧
    positiveQR witnessLower witnessQ witnessR := by sorry

theorem pivot_certificates :
    isFirstPath candidateQ candidateStates (fun k => k) ∧
    isFirstPath witnessQ witnessStates (fun k => k) := by sorry

theorem growth_separation :
    (orthogonalGrowths 8).Nonempty ∧ BddAbove (orthogonalGrowths 8) ∧
    growth candidateQ candidateStates ≤ Real.sqrt (17948132/2601) ∧
    (5272/63 : ℝ) ≤ growth witnessQ witnessStates ∧
    growth candidateQ candidateStates < growth witnessQ witnessStates ∧
    growth candidateQ candidateStates < sSup (orthogonalGrowths 8) := by sorry

theorem counterexample : ¬ ExtremizerConjecture := by sorry
end NLA.IE05
