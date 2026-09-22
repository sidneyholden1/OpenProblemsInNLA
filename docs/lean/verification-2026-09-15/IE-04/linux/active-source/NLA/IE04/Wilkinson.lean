import NLA.IE04.Growth
import NLA.IE04.Asymptotic

/-! Exact Wilkinson states for every dimension. Mathematical argument:
George Stepaniants. Formalization: Sidney Holden with Codex assistance. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped BigOperators Classical NNReal
namespace NLA.IE04

lemma reference_zero (n : ℕ) : referenceStates n 0 = wilkinson n := by
  ext i j
  simp [referenceStates, wilkinson]

lemma reference_schur (n k : ℕ) (hk : k < n) :
    schurStep (referenceStates n k) ⟨k,hk⟩ ⟨k,hk⟩ = referenceStates n (k+1) := by
  ext i j
  by_cases hi : k < i.val
  · by_cases hj : k < j.val
    · have hkn : k+1 ≠ n := by omega
      have hik : i ≠ (⟨k,hk⟩ : Fin n) := by intro h; have hh : i.val = k := congrArg Fin.val h; omega
      have hkj : (⟨k,hk⟩ : Fin n) ≠ j := by intro h; have hh : k = j.val := congrArg Fin.val h; omega
      have hij : (⟨k,hk⟩ : Fin n) < i := hi
      have hji : (⟨k,hk⟩ : Fin n) < j := hj
      simp only [schurStep, hij, hji, and_self, ↓reduceIte, Equiv.swap_self, Equiv.refl_apply]
      simp only [referenceStates, show k ≤ i.val by omega, show k ≤ j.val by omega,
        show k ≤ (⟨k,hk⟩ : Fin n).val from le_rfl, show k+1 ≤ i.val by omega,
        show k+1 ≤ j.val by omega, and_self, ↓reduceIte, hkn,
        hik, hkj, hij, show ¬j < (⟨k,hk⟩ : Fin n) by omega]
      by_cases hl : j.val+1 = n
      · simp [hl, pow_succ]; ring
      · simp [hl]
    · have hfj : ¬(⟨k,hk⟩ : Fin n) < j := hj
      simp [schurStep, hfj, referenceStates, show ¬k+1 ≤ j.val by omega]
  · have hfi : ¬(⟨k,hk⟩ : Fin n) < i := hi
    simp [schurStep, hfi, referenceStates, show ¬k+1 ≤ i.val by omega]

lemma wilkinson_states (n k : ℕ) (hk : k ≤ n) :
    states (wilkinson n) id k = referenceStates n k := by
  induction k with
  | zero => exact (reference_zero n).symm
  | succ k ih =>
    have hkn : k < n := by omega
    rw [states, dif_pos hkn, ih (by omega)]
    exact reference_schur n k hkn

lemma reference_column {n : ℕ} (k i : Fin n) (hi : k ≤ i) :
    referenceStates n k.val i k =
      if k.val+1 = n then (3/2 : ℝ)^k.val else if i = k then 1 else -(1/2:ℝ) := by
  by_cases hik : i = k
  · simp [referenceStates, hik]
  · have hki : k < i := lt_of_le_of_ne hi (Ne.symm hik)
    simp [referenceStates, hi, hik, hki]

lemma reference_pivot_pos {n : ℕ} (k : Fin n) :
    0 < referenceStates n k.val k k := by
  rw [reference_column k k le_rfl]
  simp only [ite_true]
  split_ifs <;> positivity

lemma reference_strict {n : ℕ} (k i : Fin n) (hi : k < i) :
    |referenceStates n k.val i k| < |referenceStates n k.val k k| := by
  have hl : k.val+1 ≠ n := by omega
  rw [reference_column k i hi.le, reference_column k k le_rfl]
  simp [hl, ne_of_gt hi]
  norm_num

lemma wilkinson_legal (n : ℕ) : IsLegal (wilkinson n) id := by
  intro k
  rw [wilkinson_states n k.val k.isLt.le]
  refine ⟨le_rfl, ne_of_gt (reference_pivot_pos k), ?_⟩
  intro i hi
  by_cases hik : i = k
  · simp [hik]
  · exact (reference_strict k i (lt_of_le_of_ne hi (Ne.symm hik))).le

lemma wilkinson_unique (n : ℕ) (π : Schedule n) (hπ : IsLegal (wilkinson n) π) : π = id := by
  apply strict_legal_unique _ id (wilkinson_legal n) ?_ π hπ
  intro k i hi hik
  rw [wilkinson_states n k.val k.isLt.le]
  exact reference_strict k i (lt_of_le_of_ne hi (Ne.symm hik))

lemma reference_entry_bound (n k : ℕ) (i j : Fin n) :
    |referenceStates n k i j| ≤ (3/2 : ℝ)^k := by
  have hone : (1 : ℝ) ≤ (3/2:ℝ)^k := one_le_pow₀ (by norm_num)
  unfold referenceStates
  split_ifs <;> simp only [abs_zero, abs_one, abs_neg, abs_of_nonneg (by positivity : 0 ≤ (3/2:ℝ)^k)]
  all_goals norm_num at * <;> linarith

lemma wilkinson_entryMax (n : ℕ) (hn : 0 < n) : entryMax (wilkinson n) = 1 := by
  apply le_antisymm
  · apply entryMax_le _ _ (by norm_num)
    intro i j
    simpa [reference_zero] using reference_entry_bound n 0 i j
  · let z : Fin n := ⟨n-1,by omega⟩
    have h := entry_le (wilkinson n) z z
    simpa [wilkinson, z, show n-1+1=n by omega] using h

lemma wilkinson_growth (n : ℕ) (hn : 1 ≤ n) : ppGrowth (wilkinson n) = highGrowth n := by
  rw [ppGrowth_eq_of_unique _ id (wilkinson_legal n) (wilkinson_unique n)]
  unfold pathGrowth
  rw [wilkinson_entryMax n hn, div_one]
  apply le_antisymm
  · have h : (Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
        ‖states (wilkinson n) id kij.1.val kij.2.1 kij.2.2‖₊) ≤
        (⟨highGrowth n, by unfold highGrowth; positivity⟩ : ℝ≥0) := by
      apply Finset.sup_le
      intro kij _
      have hb := reference_entry_bound n kij.1.val kij.2.1 kij.2.2
      rw [wilkinson_states n kij.1.val kij.1.isLt.le]
      have he : (3/2:ℝ)^kij.1.val ≤ highGrowth n := by
        unfold highGrowth
        exact pow_le_pow_right₀ (by norm_num) (by omega)
      exact_mod_cast hb.trans he
    exact_mod_cast h
  · let z : Fin n := ⟨n-1,by omega⟩
    have h := Finset.le_sup (f := fun kij : Fin n × Fin n × Fin n =>
        ‖states (wilkinson n) id kij.1.val kij.2.1 kij.2.2‖₊)
        (Finset.mem_univ (z,z,z))
    have he : states (wilkinson n) id z.val z z = highGrowth n := by
      rw [wilkinson_states n z.val z.isLt.le, reference_column z z le_rfl]
      simp [z, highGrowth, show n-1+1=n by omega]
    rw [he] at h
    have hh : |highGrowth n| ≤
        (((Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
          ‖states (wilkinson n) id kij.1.val kij.2.1 kij.2.2‖₊) : ℝ≥0) : ℝ) := by exact_mod_cast h
    simpa [abs_of_nonneg (by unfold highGrowth; positivity : 0 ≤ highGrowth n)] using hh

lemma amplification_radius (n : ℕ) (hn : 1 ≤ n) :
    amplification n ^ (n-1) * boxRadius n = 1/8 := by
  have hexp : (n+2)*(n-1)+3 = n^2+n+1 := by
    obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n ≠ 0)
    simp only [Nat.succ_sub_one, Nat.succ_eq_add_one]
    ring
  unfold amplification boxRadius
  rw [← pow_mul, ← hexp, pow_add]
  have hp : (2:ℝ)^((n+2)*(n-1)) ≠ 0 := by positivity
  field_simp
  ring

lemma exact_wilkinson_proved (n : ℕ) (hn : 2 ≤ n) :
    (wilkinson n).det ≠ 0 ∧ entryMax (wilkinson n) = 1 ∧
    IsLegal (wilkinson n) id ∧
    (∀ π : Schedule n, IsLegal (wilkinson n) π → π = id) ∧
    (∀ k : ℕ, k ≤ n → states (wilkinson n) id k = referenceStates n k) ∧
    ppGrowth (wilkinson n) = highGrowth n ∧
    amplification n ^ (n-1) * boxRadius n = 1/8 ∧
    exponentCost n ≤ 3 * n^4 := by
  exact ⟨det_ne_zero_of_pivots _ id (fun k => ⟨(wilkinson_legal n k).1,
      (wilkinson_legal n k).2.1⟩),
    wilkinson_entryMax n (by omega), wilkinson_legal n, wilkinson_unique n,
    wilkinson_states n, wilkinson_growth n (by omega), amplification_radius n (by omega),
    exponentCost_bound n hn⟩

end NLA.IE04
