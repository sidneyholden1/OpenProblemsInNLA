/- Full original IE-15 target, independent of Challenge.lean.
Mathematical resolution: George Stepaniants. Formalization: Sidney Holden,
with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE15.NormalizedProof
import NLA.IE15.Supremum
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

theorem witness_certificates :
    witnessThree.det = 3 ∧ witnessFour.det = 70/9 ∧
    isPath witnessThree (diagonalStates witnessThree) id id ∧
    isPath witnessFour (diagonalStates witnessFour) id id ∧
    entryMax witnessThree = 1 ∧ entryMax witnessFour = 1 ∧
    growth witnessThree (diagonalStates witnessThree) = 3 ∧
    growth witnessFour (diagonalStates witnessFour) = 14/3 :=
  witness_certificates_proved

theorem upper_three (A : Mat 3) (S : ℕ → Mat 3) (r c : Fin 3 → Fin 3)
    (_hA : A.det ≠ 0) (hpath : isPath A S r c) : growth A S ≤ 3 :=
  reduce_to_normalized_bound (by decide) 3 (by norm_num) normalized_three_bound A S r c hpath

theorem upper_four (A : Mat 4) (S : ℕ → Mat 4) (r c : Fin 4 → Fin 4)
    (_hA : A.det ≠ 0) (hpath : isPath A S r c) : growth A S ≤ 14/3 :=
  reduce_to_normalized_bound (by decide) (14/3) (by norm_num) normalized_four_bound A S r c hpath

theorem sharp_constants :
    (rookGrowths 3).Nonempty ∧ BddAbove (rookGrowths 3) ∧ sSup (rookGrowths 3) = 3 ∧
    (rookGrowths 4).Nonempty ∧ BddAbove (rookGrowths 4) ∧ sSup (rookGrowths 4) = 14/3 :=
  sharp_constants_of_bounds upper_three upper_four

#assert_trust kernel witness_certificates
#assert_trust kernel upper_three
#assert_trust kernel upper_four
#assert_trust kernel sharp_constants
#print axioms witness_certificates
#print axioms upper_three
#print axioms upper_four
#print axioms sharp_constants
end NLA.IE15
