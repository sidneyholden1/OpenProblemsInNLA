/- Full arbitrary-complex, all-tie GEPP upper bound for every band width.
The source front-envelope argument is proved for the literal path; it is not a hypothesis.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden with Codex. -/
import NLA.IE13.PathBudget
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma sharpGrowth_one_le (p q : ℕ) : 1 ≤ sharpGrowth p q := by
  simpa using profile_head_bound p q 0 (Nat.zero_le _)

lemma budget_uniform {F : Finset ℕ} {x : ℕ → ℝ} (p : ℕ) (B : ℝ)
    (hx : ∀i∈F,x i ≤ B) : HasBudget F x p 1 B := by
  intro s hs
  calc
    ∑i∈s,x i ≤ ∑i∈s,B := Finset.sum_le_sum (fun i hi => hx i (hs hi))
    _ = _ := by simp [profileSum_first]

lemma budget_single_support {F : Finset ℕ} {x : ℕ → ℝ} (p fresh : ℕ) (B : ℝ)
    (hB : 0 ≤ B) (hx : ∀i∈F,i ≠ fresh → x i=0) (hf : x fresh ≤ B) :
    HasBudget F x p 0 B := by
  intro s hs
  by_cases hsz : s=∅
  · subst s; simp
  have hm : 0 < s.card := Finset.card_pos.mpr (Finset.nonempty_iff_ne_empty.mpr hsz)
  rw [profileSum_initial p s.card hm]
  simp only [Nat.cast_one,one_mul]
  by_cases hfmem : fresh∈s
  · have he : (∑i∈s,x i)=x fresh := by
      apply Finset.sum_eq_single fresh
      · intro i hi hne; exact hx i (hs hi) hne
      · exact fun hn => False.elim (hn hfmem)
    rw [he]; exact hf
  · have he : (∑i∈s,x i)=0 := Finset.sum_eq_zero (fun i hi => hx i (hs hi)
      (fun he => hfmem (he ▸ hi)))
    rw [he]; exact hB

lemma path_budget_iterate {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (j : Fin n) (start t : ℕ)
    (hb : HasBudget (frontSet p start) (rowNorm (S start) j) p t (entryMax A)) :
    ∀d : ℕ, start+d < n → start+d ≤ j.val →
      HasBudget (frontSet p (start+d)) (rowNorm (S (start+d)) j) p (t+d) (entryMax A) := by
  intro d
  induction d with
  | zero => intro hn hj; simpa using hb
  | succ d ih =>
    intro hn hj
    have hprev := ih (by omega) (by omega)
    have hh := path_budget_step A hA S r hp j (start+d) (t+d) (by omega) (by omega) hprev
    simpa [Nat.add_assoc] using hh

lemma path_late_initial_budget {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (j : Fin n) (hj : p+q ≤ j.val) :
    HasBudget (frontSet p (j.val-(p+q))) (rowNorm (S (j.val-(p+q))) j) p 0 (entryMax A) := by
  let k := j.val-(p+q)
  have hk : k < n := by dsimp [k]; omega
  have hkeq : k+p+q=j.val := by dsimp [k]; omega
  apply budget_single_support p (k+p) (entryMax A) (entryMax_nonneg A)
  · intro i hi hne
    have hi' := Finset.mem_Ico.mp hi
    by_cases hin : i < n
    · unfold rowNorm
      rw [dif_pos hin]
      have hh := path_far_column_zero A hA S r hp k hk ⟨i,hin⟩ j
        (by omega) (by dsimp; omega)
      simpa [hh]
    · simp [rowNorm,hin]
  · by_cases hin : k+p < n
    · unfold rowNorm
      rw [dif_pos hin,path_untouched A hA S r hp k hk ⟨k+p,hin⟩ j
        (by simp) (by omega)]
      exact entry_le A _ j
    · simp [rowNorm,hin,entryMax_nonneg]

lemma path_front_entry_bound {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (k i j : Fin n) (hki : k.val ≤ i.val) (hij : i.val < k.val+p)
    (hkj : k.val ≤ j.val) : ‖S k.val i j‖ ≤ sharpGrowth p q*entryMax A := by
  have hiF : i.val∈frontSet p k.val := by simp only [frontSet,Finset.mem_Ico]; omega
  by_cases hj : j.val < p+q
  · have hb0 : HasBudget (frontSet p 0) (rowNorm (S 0) j) p 1 (entryMax A) := by
      rw [hp.1]
      exact budget_uniform p _ (fun i hi => rowNorm_entry_le A j i)
    have hb := path_budget_iterate A hA S r hp j 0 1 hb0 k.val (by simp) (by simpa using hkj)
    have hs := budget_singleton hb (by simpa using hiF)
    simp only [Nat.zero_add,rowNorm_fin] at hs
    have hc := profile_head_bound p q (1+k.val) (by omega)
    exact hs.trans (mul_le_mul_of_nonneg_right hc (entryMax_nonneg A))
  · have hj' : p+q ≤ j.val := by omega
    let start := j.val-(p+q)
    by_cases hk : k.val < start
    · have hz := path_far_column_zero A hA S r hp k.val k.isLt i j
        (by dsimp [start] at hk; omega) (by dsimp [start] at hk; omega)
      rw [hz,norm_zero]
      exact mul_nonneg (le_trans (by norm_num) (sharpGrowth_one_le p q)) (entryMax_nonneg A)
    · have hstart : start ≤ k.val := by omega
      have hb0 := path_late_initial_budget A hA S r hp j hj'
      have hkeq : start+(k.val-start)=k.val := Nat.add_sub_of_le hstart
      have hb := path_budget_iterate A hA S r hp j start 0 hb0 (k.val-start)
        (by omega) (by omega)
      rw [hkeq,Nat.zero_add] at hb
      have hs := budget_singleton hb hiF
      rw [rowNorm_fin] at hs
      have hc := profile_head_bound p q (k.val-start) (by dsimp [start]; omega)
      exact hs.trans (mul_le_mul_of_nonneg_right hc (entryMax_nonneg A))

lemma path_entry_bound {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) (k i j : Fin n) :
    ‖S k.val i j‖ ≤ sharpGrowth p q*entryMax A := by
  by_cases hpad : i < k ∨ j < k
  · rw [path_zero_padding A S r hp k i j hpad,norm_zero]
    exact mul_nonneg (le_trans (by norm_num) (sharpGrowth_one_le p q)) (entryMax_nonneg A)
  have hki : k.val ≤ i.val := by simp only [Fin.lt_def] at hpad; omega
  have hkj : k.val ≤ j.val := by simp only [Fin.lt_def] at hpad; omega
  by_cases hf : k.val+p ≤ i.val
  · rw [path_untouched A hA S r hp k.val k.isLt i j hf hkj]
    exact (entry_le A i j).trans (le_mul_of_one_le_left (entryMax_nonneg A) (sharpGrowth_one_le p q))
  · exact path_front_entry_bound A hA S r hp k i j hki (by omega) hkj

/-- Unconditional upper bound over every literal admissible path and every intermediate entry. -/
theorem upper_bound_proved (p q n : ℕ) (hn : 1+max p q ≤ n)
    (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n)
    (hA : IsBanded p q A) (hpath : isPath A S r) : growth A S ≤ sharpGrowth p q := by
  apply growth_le_of_entry_bounds A S _
    (le_trans (by norm_num) (sharpGrowth_one_le p q))
    (banded_entryMax_pos (by omega) A hA)
  exact path_entry_bound A hA S r hpath

end NLA.IE13
