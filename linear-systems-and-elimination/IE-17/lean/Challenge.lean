import NLA.IE17.Definitions
set_option autoImplicit false
open scoped BigOperators Classical Matrix MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.IE17

theorem iterates :
    Function.Injective witnessA.mulVec ∧
    isLSMRIterate witnessA witnessB 1 x1 ∧ isLSMRIterate witnessA witnessB 2 x2 ∧
    x1 ≠ 0 ∧ x2 ≠ 0 ∧ normalResidual witnessA witnessB x1 ≠ 0 ∧
    normalResidual witnessA witnessB x2 ≠ 0 := by sorry

theorem backward_increase :
    (∃ E, feasible witnessA E witnessB x1 ∧ backwardError witnessA witnessB x1 = ‖E‖) ∧
    (∃ E, feasible witnessA E witnessB x2 ∧ backwardError witnessA witnessB x2 = ‖E‖) ∧
    backwardError witnessA witnessB x1 ≤ Real.sqrt (1979/2000) ∧
    Real.sqrt (99/100) ≤ backwardError witnessA witnessB x2 ∧
    backwardError witnessA witnessB x1 < backwardError witnessA witnessB x2 := by sorry

theorem approximation_increase :
    moorePenrose (stacked witnessA witnessB x1) (leftPseudo (stacked witnessA witnessB x1)) ∧
    moorePenrose (stacked witnessA witnessB x2) (leftPseudo (stacked witnessA witnessB x2)) ∧
    (approxError witnessA witnessB x1)^2 = approxSquared1 ∧
    (approxError witnessA witnessB x2)^2 = approxSquared2 ∧
    approxError witnessA witnessB x1 < approxError witnessA witnessB x2 := by sorry

/-- Separate negative answers to both counted-together original questions. -/
theorem counterexample : ¬ monotonicError (@backwardError) ∧ ¬ monotonicError (@approxError) := by sorry
end NLA.IE17
