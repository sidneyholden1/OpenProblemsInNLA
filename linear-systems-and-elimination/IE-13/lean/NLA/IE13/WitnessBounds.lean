/- Original-order sparsity and exact normalization of the IE-13 witness.
Source mathematics: Matthew J. Colbrook. Formalization: Sidney Holden with
OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.WitnessAlgebra
import NLA.IE13.Base
set_option autoImplicit false
set_option maxHeartbeats 2500000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma witnessQ_of_ne_zero (p q : ℕ) (hp : p ≠ 0) :
    witnessQ p q = fun i j =>
      if j.val < p+q then (1/(2:ℚ)^p) *
        ∑ a : Fin (witnessSize p q), lowerQ p q (factorRow p q i) a * earlyColumnQ p j.val a.val
      else if j.val=p+q then (if p ≤ i.val then 1 else 0)
      else if i=j then 1 else 0 := by
  exact if_neg hp

lemma factorRow_val (p q : ℕ) (i : Fin (witnessSize p q)) :
    (factorRow p q i).val = if i.val=p then 0 else if i.val<p then i.val+1 else i.val := by
  simp only [factorRow]
  split_ifs <;> rfl

lemma early_input_below (p q : ℕ) (i j : Fin (witnessSize p q))
    (h : j.val+p < i.val) :
    (∑ a : Fin (witnessSize p q), lowerQ p q (factorRow p q i) a *
      earlyColumnQ p j.val a.val) = 0 := by
  have hf : factorRow p q i = i := by
    simp [factorRow,show i.val ≠ p by omega,show ¬i.val < p by omega]
  rw [hf]
  apply Finset.sum_eq_zero
  intro a _
  by_cases ha : j.val < a.val
  · rw [earlyColumnQ_zero_above p j.val a.val ha,mul_zero]
  · have hia : i ≠ a := by intro he; have := congrArg Fin.val he; omega
    have hb : ¬(a.val < i.val ∧ i.val ≤ a.val+p) := by omega
    simp only [lowerQ,if_neg hia,if_neg hb,zero_mul]

lemma early_input_above (p q : ℕ) (i j : Fin (witnessSize p q))
    (h : i.val < j.val) :
    (∑ a : Fin (witnessSize p q), lowerQ p q (factorRow p q i) a *
      earlyColumnQ p j.val a.val) = 0 := by
  have hf := factorRow_val p q i
  by_cases hj : j.val ≤ p
  · have hi : i.val < p := by omega
    have hfi : (factorRow p q i).val = i.val+1 := by
      simpa [show i.val ≠ p by omega,hi] using hf
    exact lowerQ_early_cancel p q j.val _ hj (by omega) (by omega)
  · rw [lowerQ_late_column p q j.val _ (by omega) j.isLt]
    have hfi : (factorRow p q i).val < j.val := by
      split_ifs at hf <;> omega
    have hne : factorRow p q i ≠ j := ne_of_lt hfi
    have hb : ¬(j.val < (factorRow p q i).val ∧ (factorRow p q i).val ≤ j.val+p) := by omega
    change lowerQ p q (factorRow p q i) j = 0
    simp only [lowerQ,if_neg hne,if_neg hb]

lemma witness_pattern (p q : ℕ) (i j : Fin (witnessSize p q))
    (h : j.val+p < i.val ∨ i.val+q < j.val) : witness p q i j = 0 := by
  by_cases hp : p=0
  · have hij : i ≠ j := by intro he; have := congrArg Fin.val he; omega
    simp [witness,witnessQ,hp,Matrix.one_apply,hij]
  · simp only [witness,witnessQ_of_ne_zero p q hp]
    by_cases hj : j.val < p+q
    · rw [if_pos hj]
      have he : (∑ a : Fin (witnessSize p q), lowerQ p q (factorRow p q i) a *
          earlyColumnQ p j.val a.val) = 0 := by
        rcases h with h | h
        · exact early_input_below p q i j h
        · exact early_input_above p q i j (by omega)
      simp [he]
    · rw [if_neg hj]
      by_cases he : j.val=p+q
      · rw [if_pos he]
        have hip : ¬p ≤ i.val := by
          have hin := i.isLt
          unfold witnessSize at hin
          omega
        simp [hip]
      · rw [if_neg he]
        have hij : i ≠ j := by intro hij; have := congrArg Fin.val hij; omega
        simp [hij]

lemma witnessQ_abs_le_one (p q : ℕ) (i j : Fin (witnessSize p q)) :
    |witnessQ p q i j| ≤ 1 := by
  by_cases hp : p=0
  · by_cases he : i=j <;> simp [witnessQ,hp,Matrix.one_apply,he]
  · simp only [witnessQ_of_ne_zero p q hp]
    split_ifs
    · rw [abs_mul,abs_of_nonneg (by positivity : (0:ℚ) ≤ 1/2^p)]
      calc
        _ ≤ (1/(2:ℚ)^p) * (2:ℚ)^p :=
          mul_le_mul_of_nonneg_left ((lowerQ_sum_abs_le_total p q j.val _).trans
            (earlyColumnQ_total_le p q j.val j.isLt)) (by positivity)
        _ = 1 := by field_simp
    all_goals norm_num

lemma witness_entry_le_one (p q : ℕ) (i j : Fin (witnessSize p q)) :
    ‖witness p q i j‖ ≤ 1 := by
  rw [witness,Complex.norm_ratCast]
  exact_mod_cast witnessQ_abs_le_one p q i j

lemma witness_target_one (p q : ℕ) (hp : 0 < p) :
    witness p q ⟨p,by unfold witnessSize; omega⟩ ⟨p+q,by unfold witnessSize; omega⟩ = 1 := by
  simp [witness,witnessQ,show p ≠ 0 by omega]

lemma witness_entryMax (p q : ℕ) : entryMax (witness p q) = 1 := by
  apply le_antisymm
  · exact entryMax_le _ 1 (by norm_num) (witness_entry_le_one p q)
  · by_cases hp : p=0
    · subst p
      let z : Fin (witnessSize 0 q) := ⟨0,by unfold witnessSize; omega⟩
      have h := entry_le (witness 0 q) z z
      simpa [witness,witnessQ,Matrix.one_apply] using h
    · have h := entry_le (witness p q) ⟨p,by unfold witnessSize; omega⟩
        ⟨p+q,by unfold witnessSize; omega⟩
      rw [witness_target_one p q (by omega),norm_one] at h
      exact h

end NLA.IE13
