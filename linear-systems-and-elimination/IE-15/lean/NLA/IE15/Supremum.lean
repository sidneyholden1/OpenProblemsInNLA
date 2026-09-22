/- Attainment and the genuine real suprema for IE-15. Apache-2.0. -/
import NLA.IE15.Witnesses
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

lemma three_mem : (3 : ℝ) ∈ rookGrowths 3 := by
  refine ⟨witnessThree,diagonalStates witnessThree,id,id,?_,witnessThree_path,witnessThree_growth.symm⟩
  rw [witnessThree_det]; norm_num
lemma four_mem : (14/3 : ℝ) ∈ rookGrowths 4 := by
  refine ⟨witnessFour,diagonalStates witnessFour,id,id,?_,witnessFour_path,witnessFour_growth.symm⟩
  rw [witnessFour_det]; norm_num

lemma sharp_constants_of_bounds
    (h3 : ∀ (A : Mat 3) (S : ℕ → Mat 3) (r c : Fin 3 → Fin 3),
      A.det ≠ 0 → isPath A S r c → growth A S ≤ 3)
    (h4 : ∀ (A : Mat 4) (S : ℕ → Mat 4) (r c : Fin 4 → Fin 4),
      A.det ≠ 0 → isPath A S r c → growth A S ≤ 14/3) :
    (rookGrowths 3).Nonempty ∧ BddAbove (rookGrowths 3) ∧ sSup (rookGrowths 3) = 3 ∧
    (rookGrowths 4).Nonempty ∧ BddAbove (rookGrowths 4) ∧ sSup (rookGrowths 4) = 14/3 := by
  have hb3 : ∀ x ∈ rookGrowths 3, x ≤ 3 := by
    rintro x ⟨A,S,r,c,hA,hpath,rfl⟩
    exact h3 A S r c hA hpath
  have hb4 : ∀ x ∈ rookGrowths 4, x ≤ 14/3 := by
    rintro x ⟨A,S,r,c,hA,hpath,rfl⟩
    exact h4 A S r c hA hpath
  have b3 : BddAbove (rookGrowths 3) := ⟨3,hb3⟩
  have b4 : BddAbove (rookGrowths 4) := ⟨14/3,hb4⟩
  have n3 : (rookGrowths 3).Nonempty := ⟨3,three_mem⟩
  have n4 : (rookGrowths 4).Nonempty := ⟨14/3,four_mem⟩
  exact ⟨n3,b3,le_antisymm (csSup_le n3 hb3) (le_csSup b3 three_mem),
    n4,b4,le_antisymm (csSup_le n4 hb4) (le_csSup b4 four_mem)⟩

#assert_trust kernel three_mem
#assert_trust kernel four_mem
#assert_trust kernel sharp_constants_of_bounds
end NLA.IE15
