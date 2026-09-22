/- Actual diagonal-path recurrence and elementary stage bounds. Apache-2.0. -/
import NLA.IE15.SignScaling
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

lemma path_entry_step {n : ℕ} (T : ℕ → Mat n) (h : isPath (T 0) T id id)
    (k i j : Fin n) (hk : k.val+1 < n) (hi : k < i) (hj : k < j) :
    T (k.val+1) i j = T k.val i j - T k.val i k / T k.val k k * T k.val k j := by
  rw [(h.2 k).2.2.2.2.2 hk]
  simp [schurStep, hi, hj]

lemma path_zero_padding {n : ℕ} (T : ℕ → Mat n) (h : isPath (T 0) T id id)
    (k i j : Fin n) (hi : i < k ∨ j < k) : T k.val i j = 0 := by
  cases hk : k.val with
  | zero => rcases hi with hi | hj <;> simp [Fin.lt_def,hk] at *
  | succ m =>
    let p : Fin n := ⟨m,by omega⟩
    have he := (h.2 p).2.2.2.2.2 (by dsimp [p]; omega)
    change T (m+1) = _ at he
    rw [he]
    simp only [schurStep, id_eq, Equiv.swap_self, Equiv.refl_apply]
    have hh : ¬(p < i ∧ p < j) := by
      dsimp [p]
      rcases hi with hi | hj <;> simp only [Fin.lt_def] at * <;> omega
    simp [hh]

lemma path_col_multiplier {n : ℕ} (T : ℕ → Mat n) (h : isPath (T 0) T id id)
    (k i : Fin n) (hi : k ≤ i) : |T k.val i k / T k.val k k| ≤ 1 := by
  rw [abs_div]
  exact (div_le_one (abs_pos.mpr (h.2 k).2.2.1)).mpr ((h.2 k).2.2.2.1 i hi)

lemma path_row_multiplier {n : ℕ} (T : ℕ → Mat n) (h : isPath (T 0) T id id)
    (k j : Fin n) (hj : k ≤ j) : |T k.val k j / T k.val k k| ≤ 1 := by
  rw [abs_div]
  exact (div_le_one (abs_pos.mpr (h.2 k).2.2.1)).mpr ((h.2 k).2.2.2.2.1 j hj)

lemma diagonal_schur_entry_bound {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (k i j : Fin n) :
    |schurStep (T k.val) k k k i j| ≤ 2*entryMax (T k.val) := by
  unfold schurStep
  simp only [Equiv.swap_self,Equiv.refl_apply]
  split_ifs with hij
  · calc
      |T k.val i j - T k.val i k / T k.val k k * T k.val k j|
          ≤ |T k.val i j| + |T k.val i k / T k.val k k| * |T k.val k j| := by
            simpa only [abs_mul] using abs_sub (T k.val i j) (T k.val i k / T k.val k k * T k.val k j)
      _ ≤ entryMax (T k.val) + 1*entryMax (T k.val) :=
        add_le_add (entry_le _ _ _) (mul_le_mul (path_col_multiplier T h k i hij.1.le)
          (entry_le _ _ _) (abs_nonneg _) (by norm_num))
      _ = 2*entryMax (T k.val) := by ring
  · simpa using mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) (entryMax_nonneg _)

lemma path_stage_bound {n : ℕ} (T : ℕ → Mat n) (h : isPath (T 0) T id id) :
    ∀ k : ℕ, k < n → entryMax (T k) ≤ 2^k * entryMax (T 0) := by
  intro k
  induction k with
  | zero => intro hk; simp
  | succ k ih =>
    intro hk
    let f : Fin n := ⟨k,by omega⟩
    have hh := h.2 f
    have he : T (k+1) = schurStep (T k) f f f := hh.2.2.2.2.2 hk
    rw [he]
    have hb := entryMax_le (schurStep (T k) f f f) (2*entryMax (T k))
      (mul_nonneg (by norm_num) (entryMax_nonneg _))
      (diagonal_schur_entry_bound T h f)
    have hi := ih (by omega)
    calc
      entryMax (schurStep (T k) f f f) ≤ 2*entryMax (T k) := hb
      _ ≤ 2*(2^k*entryMax (T 0)) := by gcongr
      _ = 2^(k+1)*entryMax (T 0) := by ring

lemma normalized_stage_entry_bound {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (hinit : ∀ i j, |T 0 i j| ≤ 1)
    (k i j : Fin n) : |T k.val i j| ≤ 2^k.val := by
  have hi := entryMax_le (T 0) 1 (by norm_num) hinit
  calc
    |T k.val i j| ≤ entryMax (T k.val) := entry_le _ _ _
    _ ≤ 2^k.val*entryMax (T 0) := path_stage_bound T h k.val k.isLt
    _ ≤ 2^k.val*1 := mul_le_mul_of_nonneg_left hi (by positivity)
    _ = 2^k.val := mul_one _

end NLA.IE15
