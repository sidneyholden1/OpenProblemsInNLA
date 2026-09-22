/- Sparse rational column calculations for the exact IE-13 construction.
Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.WitnessScalar
set_option autoImplicit false
set_option maxHeartbeats 2500000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma fin_sum_below {R : Type*} [AddCommMonoid R] (n t : ℕ) (ht : t ≤ n) (f : ℕ → R) :
    (∑ a : Fin n, if a.val < t then f a.val else 0) = ∑ a ∈ Finset.range t, f a := by
  rw [Fin.sum_univ_eq_sum_range (fun a => if a < t then f a else 0)]
  have hsub := Finset.range_mono ht
  calc
    _ = ∑ a ∈ Finset.range t, if a < t then f a else 0 := by
      symm
      apply Finset.sum_subset hsub
      intro a _ ha
      simp [show ¬a<t from fun h => ha (Finset.mem_range.mpr h)]
    _ = _ := by apply Finset.sum_congr rfl; intro a ha; simp [Finset.mem_range.mp ha]

lemma lowerQ_sum (p q : ℕ) (i : Fin (witnessSize p q)) (v : ℕ → ℚ) :
    (∑ a : Fin (witnessSize p q), lowerQ p q i a * v a.val) =
      v i.val - ∑ a ∈ Finset.range i.val, if i.val ≤ a+p then v a else 0 := by
  have he : ∀ a : Fin (witnessSize p q), lowerQ p q i a =
      (if a=i then 1 else 0) - (if a.val < i.val ∧ i.val ≤ a.val+p then 1 else 0) := by
    intro a
    by_cases ha : a=i
    · subst a; simp [lowerQ]
    · simp only [lowerQ,ha,Ne.symm ha,if_false,zero_sub]
      split_ifs <;> norm_num
  simp only [he,sub_mul,Finset.sum_sub_distrib,ite_mul,one_mul,zero_mul]
  rw [Finset.sum_ite_eq']
  simp only [Finset.mem_univ,ite_true]
  congr 1
  have hrewrite : ∀ a : Fin (witnessSize p q),
      (if a.val < i.val ∧ i.val ≤ a.val+p then v a.val else 0) =
      if a.val < i.val then (if i.val ≤ a.val+p then v a.val else 0) else 0 := by
    intro a; split_ifs <;> simp_all
  simp only [hrewrite]
  exact fin_sum_below _ i.val (Nat.le_of_lt i.isLt)
    (fun a => if i.val ≤ a+p then v a else 0)

lemma earlyColumnQ_total (p q k : ℕ) (hk : k < witnessSize p q) :
    (∑ a : Fin (witnessSize p q), earlyColumnQ p k a.val) =
      if k ≤ p then (2 : ℚ)^k else 1 := by
  by_cases hp : k ≤ p
  · simp only [if_pos hp,earlyColumnQ_early p k _ hp]
    have he : ∀ a : Fin (witnessSize p q),
        (if a.val ≤ k then (targetRec p a.val : ℚ) else 0) =
        if a.val < k+1 then (targetRec p a.val : ℚ) else 0 := by
      intro a
      by_cases h : a.val ≤ k
      · simp [h,show a.val < k+1 by omega]
      · simp [h,show ¬a.val < k+1 by omega]
    simp only [he]
    rw [fin_sum_below (witnessSize p q) (k+1) (by omega) (fun a => (targetRec p a : ℚ))]
    exact_mod_cast targetRec_prefix p k hp
  · simp only [if_neg hp,earlyColumnQ_late p k _ (by omega)]
    let f : Fin (witnessSize p q) := ⟨k,hk⟩
    have he : ∀ a : Fin (witnessSize p q), (a.val=k) ↔ a=f := by
      intro a
      constructor
      · exact fun h => Fin.ext h
      · exact fun h => congrArg Fin.val h
    simp [he]

lemma earlyColumnQ_total_le (p q k : ℕ) (hk : k < witnessSize p q) :
    (∑ a : Fin (witnessSize p q), earlyColumnQ p k a.val) ≤ (2:ℚ)^p := by
  rw [earlyColumnQ_total p q k hk]
  split_ifs with h
  · exact pow_le_pow_right₀ (by norm_num) h
  · exact one_le_pow₀ (by norm_num)

lemma lowerQ_sum_abs_le_total (p q k : ℕ) (i : Fin (witnessSize p q)) :
    |∑ a : Fin (witnessSize p q), lowerQ p q i a * earlyColumnQ p k a.val| ≤
      ∑ a : Fin (witnessSize p q), earlyColumnQ p k a.val := by
  calc
    _ ≤ ∑ a : Fin (witnessSize p q), |lowerQ p q i a * earlyColumnQ p k a.val| :=
      Finset.abs_sum_le_sum_abs _ _
    _ ≤ _ := by
      apply Finset.sum_le_sum
      intro a _
      rw [abs_mul,abs_of_nonneg (earlyColumnQ_nonneg p k a.val)]
      have hl : |lowerQ p q i a| ≤ 1 := by unfold lowerQ; split_ifs <;> norm_num
      exact mul_le_of_le_one_left (earlyColumnQ_nonneg p k a.val) hl

lemma lowerQ_early_cancel (p q k : ℕ) (i : Fin (witnessSize p q))
    (hk : k ≤ p) (hi : 0 < i.val) (hik : i.val ≤ k) :
    (∑ a : Fin (witnessSize p q), lowerQ p q i a * earlyColumnQ p k a.val) = 0 := by
  rw [lowerQ_sum]
  rw [earlyColumnQ_early p k i.val hk,if_pos hik]
  have hs : (∑ a ∈ Finset.range i.val, if i.val ≤ a+p then earlyColumnQ p k a else 0) =
      ((∑ a ∈ Finset.range i.val, if i.val ≤ a+p then targetRec p a else 0 : ℕ) : ℚ) := by
    push_cast
    apply Finset.sum_congr rfl
    intro a ha
    have ha' := Finset.mem_range.mp ha
    rw [earlyColumnQ_early p k a hk,if_pos (show a ≤ k by omega)]
  rw [hs]
  have he := targetRec_forward p i.val
  have hic : ¬(i.val=0 ∨ p < i.val) := by omega
  simp only [hic,if_false,zero_add] at he
  exact sub_eq_zero.mpr (by exact_mod_cast he)

lemma lowerQ_late_column (p q k : ℕ) (i : Fin (witnessSize p q))
    (hk : p < k) (hkn : k < witnessSize p q) :
    (∑ a : Fin (witnessSize p q), lowerQ p q i a * earlyColumnQ p k a.val) =
      lowerQ p q i ⟨k,hkn⟩ := by
  simp only [earlyColumnQ_late p k _ hk]
  have he : ∀ a : Fin (witnessSize p q), (a.val=k) ↔ a=⟨k,hkn⟩ := by
    intro a
    constructor
    · exact fun h => Fin.ext h
    · exact fun h => congrArg Fin.val h
  simp [he]

end NLA.IE13
