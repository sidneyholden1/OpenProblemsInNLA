import NLA.IE15.Definitions
set_option autoImplicit false
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

theorem witness_certificates :
    witnessThree.det = 3 ∧ witnessFour.det = 70/9 ∧
    isPath witnessThree (diagonalStates witnessThree) id id ∧
    isPath witnessFour (diagonalStates witnessFour) id id ∧
    entryMax witnessThree = 1 ∧ entryMax witnessFour = 1 ∧
    growth witnessThree (diagonalStates witnessThree) = 3 ∧
    growth witnessFour (diagonalStates witnessFour) = 14/3 := by sorry

theorem upper_three (A : Mat 3) (S : ℕ → Mat 3) (r c : Fin 3 → Fin 3)
    (hA : A.det ≠ 0) (hpath : isPath A S r c) : growth A S ≤ 3 := by sorry

theorem upper_four (A : Mat 4) (S : ℕ → Mat 4) (r c : Fin 4 → Fin 4)
    (hA : A.det ≠ 0) (hpath : isPath A S r c) : growth A S ≤ 14/3 := by sorry

theorem sharp_constants :
    (rookGrowths 3).Nonempty ∧ BddAbove (rookGrowths 3) ∧ sSup (rookGrowths 3) = 3 ∧
    (rookGrowths 4).Nonempty ∧ BddAbove (rookGrowths 4) ∧ sSup (rookGrowths 4) = 14/3 := by sorry
end NLA.IE15
