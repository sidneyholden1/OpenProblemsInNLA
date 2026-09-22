import NLA.IE04.Wilkinson

/-! Uniform robustness over the entire closed n²-dimensional box.
The scalar error propagation is the exact argument of George Stepaniants;
formalization by Sidney Holden with Codex assistance. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped BigOperators Classical NNReal
namespace NLA.IE04

lemma scalar_schur_error (a b c d A D e M : ℝ)
    (he : 0 ≤ e) (he8 : e ≤ 1/8) (_hM : 0 ≤ M)
    (ha : |a-A| ≤ e) (hb : |b+1/2| ≤ e)
    (hc : |c-1| ≤ e) (hd : |d-D| ≤ e) (hD : |D| ≤ M) :
    |(a-b/c*d)-(A+1/2*D)| ≤ (2+2*M)*e := by
  have hcl : 1-e ≤ c := by have := (abs_le.mp hc).1; linarith
  have hcp : 0 < c := by linarith
  have hcb : 7/8 ≤ c := by linarith
  have hbb : |b| ≤ 1/2+e := by
    calc
      |b| = |(b+1/2)-(1/2)| := by ring_nf
      _ ≤ |b+1/2|+|(1/2:ℝ)| := abs_sub _ _
      _ ≤ e+1/2 := by norm_num; linarith
      _ = 1/2+e := by ring
  have hq : |b/c| ≤ 1 := by
    rw [abs_div, abs_of_pos hcp, div_le_one hcp]
    linarith
  have hq' : |b/c+1/2| ≤ 2*e := by
    have heq : b/c+1/2 = ((b+1/2)+(c-1)/2)/c := by field_simp; ring
    rw [heq, abs_div, abs_of_pos hcp]
    apply (div_le_iff₀ hcp).mpr
    have hab : |(b+1/2)+(c-1)/2| ≤ e+e/2 := by
      calc
        _ ≤ |b+1/2|+|(c-1)/2| := abs_add_le _ _
        _ ≤ e+e/2 := by rw [abs_div]; norm_num; linarith
    nlinarith
  have heq : (a-b/c*d)-(A+1/2*D) = (a-A)-(b/c)*(d-D)-(b/c+1/2)*D := by ring
  rw [heq]
  calc
    _ ≤ |a-A|+|b/c*(d-D)|+|(b/c+1/2)*D| := (abs_sub _ _).trans (add_le_add (abs_sub _ _) le_rfl)
    _ = |a-A|+|b/c| *|d-D|+|b/c+1/2| *|D| := by simp only [abs_mul]
    _ ≤ e+1*e+(2*e)*M := by
      gcongr
    _ = (2+2*M)*e := by ring

lemma boxRadius_pos (n : ℕ) : 0 < boxRadius n := by unfold boxRadius; positivity
lemma amplification_ge_one (n : ℕ) : 1 ≤ amplification n := by
  unfold amplification
  exact one_le_pow₀ (by norm_num)

lemma propagated_error_bound (n k : ℕ) (hn : 1 ≤ n) (hk : k < n) :
    amplification n ^ k * boxRadius n ≤ 1/8 := by
  rw [← amplification_radius n hn]
  exact mul_le_mul_of_nonneg_right
    (pow_le_pow_right₀ (amplification_ge_one n) (by omega)) (boxRadius_pos n).le

lemma boxRadius_le_eighth (n : ℕ) (hn : 1 ≤ n) : boxRadius n ≤ 1/8 := by
  simpa using propagated_error_bound n 0 hn hn

lemma reference_entry_bound_two (n k : ℕ) (hk : k ≤ n) (i j : Fin n) :
    |referenceStates n k i j| ≤ (2:ℝ)^n := by
  calc
    _ ≤ (3/2:ℝ)^k := reference_entry_bound n k i j
    _ ≤ (2:ℝ)^k := pow_le_pow_left₀ (by norm_num) (by norm_num) _
    _ ≤ (2:ℝ)^n := pow_le_pow_right₀ (by norm_num) hk

lemma error_schur_step (n k : ℕ) (hk : k+1 < n) (A : Mat n)
    (e : ℝ) (he : 0 ≤ e) (he8 : e ≤ 1/8)
    (hA : entryMax (A-referenceStates n k) ≤ e) :
    entryMax (schurStep A ⟨k,by omega⟩ ⟨k,by omega⟩ - referenceStates n (k+1)) ≤
      amplification n * e := by
  apply entryMax_le _ _ (mul_nonneg (le_trans (by norm_num) (amplification_ge_one n)) he)
  intro i j
  have herr (u v : Fin n) : |A u v-referenceStates n k u v| ≤ e :=
    (entry_le (A-referenceStates n k) u v).trans hA
  let f : Fin n := ⟨k,by omega⟩
  change |schurStep A f f i j-referenceStates n (k+1) i j| ≤ amplification n*e
  by_cases hi : f < i
  · by_cases hj : f < j
    · have hrf : referenceStates n k f f = 1 := by
        simpa [f, show k+1≠n by omega] using reference_column f f le_rfl
      have hri : referenceStates n k i f = -(1/2:ℝ) := by
        simpa [f, show k+1≠n by omega, ne_of_gt hi] using reference_column f i hi.le
      have hrec : referenceStates n (k+1) i j =
          referenceStates n k i j + 1/2*referenceStates n k f j := by
        have hh := congrArg (fun C : Mat n => C i j) (reference_schur n k (by omega))
        simpa [schurStep, f, hi, hj, hrf, hri] using hh.symm
      have hb := scalar_schur_error (A i j) (A i f) (A f f) (A f j)
        (referenceStates n k i j) (referenceStates n k f j) e ((2:ℝ)^n)
        he he8 (by positivity) (herr i j)
        (by simpa [hri, sub_neg_eq_add] using herr i f)
        (by simpa [hrf] using herr f f) (herr f j)
        (reference_entry_bound_two n k (by omega) f j)
      have hcoef : 2+2*(2:ℝ)^n ≤ amplification n := by
        unfold amplification
        rw [show n+2=n+1+1 by omega, pow_succ, pow_succ]
        have hp : (1:ℝ) ≤ 2^n := one_le_pow₀ (by norm_num)
        nlinarith
      have hh : |schurStep A f f i j-referenceStates n (k+1) i j| ≤ amplification n*e := by
        simp only [schurStep, hi, hj, and_self, ↓reduceIte, Equiv.swap_self, Equiv.refl_apply]
        rw [hrec]
        exact hb.trans (mul_le_mul_of_nonneg_right hcoef he)
      exact hh
    · have hj' : ¬k+1 ≤ j.val := by have hh : ¬k < j.val := hj; omega
      simp [schurStep, hj, referenceStates, hj', mul_nonneg (le_trans (by norm_num) (amplification_ge_one n)) he]
  · have hi' : ¬k+1 ≤ i.val := by have hh : ¬k < i.val := hi; omega
    simp [schurStep, hi, referenceStates, hi', mul_nonneg (le_trans (by norm_num) (amplification_ge_one n)) he]

lemma box_state_error (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n) :
    ∀ k : ℕ, k < n →
      entryMax (states A id k-referenceStates n k) ≤ amplification n^k*boxRadius n := by
  intro k
  induction k with
  | zero =>
    intro hk
    simp only [states, pow_zero, one_mul, reference_zero]
    exact entryMax_le _ _ (boxRadius_pos n).le hA
  | succ k ih =>
    intro hk
    rw [states, dif_pos (show k<n by omega)]
    have hh := error_schur_step n k hk (states A id k) (amplification n^k*boxRadius n)
      (mul_nonneg (pow_nonneg (le_trans (by norm_num) (amplification_ge_one n)) k) (boxRadius_pos n).le) (propagated_error_bound n k (by omega) (by omega)) (ih (by omega))
    calc
      _ ≤ amplification n*(amplification n^k*boxRadius n) := hh
      _ = amplification n^(k+1)*boxRadius n := by ring

lemma box_pivot_close (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n)
    (k i j : Fin n) : |states A id k.val i j-referenceStates n k.val i j| ≤ 1/8 := by
  exact ((entry_le (states A id k.val-referenceStates n k.val) i j).trans
    (box_state_error n hn A hA k.val k.isLt)).trans
    (propagated_error_bound n k.val (by omega) k.isLt)

lemma box_pivot_positive (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n)
    (k : Fin n) : 0 < states A id k.val k k := by
  have hh := (abs_le.mp (box_pivot_close n hn A hA k k k)).1
  have hr : 1 ≤ referenceStates n k.val k k := by
    rw [reference_column k k le_rfl]
    simp only [ite_true]
    split_ifs
    · exact one_le_pow₀ (by norm_num)
    · simp
  linarith

lemma box_strict_column (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n)
    (k i : Fin n) (hi : k < i) :
    |states A id k.val i k| < |states A id k.val k k| := by
  have hp := box_pivot_close n hn A hA k k k
  have hi' := box_pivot_close n hn A hA k i k
  have hl : k.val+1 ≠ n := by omega
  rw [reference_column k k le_rfl] at hp
  rw [reference_column k i hi.le] at hi'
  simp only [hl, ↓reduceIte, ne_of_gt hi, sub_neg_eq_add] at hp hi'
  have hpl := (abs_le.mp hp).1
  have hil := (abs_le.mp hi').1
  have hiu := (abs_le.mp hi').2
  rw [abs_of_pos (box_pivot_positive n hn A hA k)]
  exact abs_lt.mpr ⟨by linarith, by linarith⟩

lemma box_legal (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n) :
    IsLegal A id := by
  intro k
  refine ⟨le_rfl, ne_of_gt (box_pivot_positive n hn A hA k), ?_⟩
  intro i hi
  by_cases hik : i = k
  · simp [hik]
  · exact (box_strict_column n hn A hA k i (lt_of_le_of_ne hi (Ne.symm hik))).le

lemma box_unique (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n)
    (π : Schedule n) (hp : IsLegal A π) : π = id := by
  apply strict_legal_unique A id (box_legal n hn A hA) ?_ π hp
  intro k i hi hik
  exact box_strict_column n hn A hA k i (lt_of_le_of_ne hi (Ne.symm hik))

lemma box_growth_lower (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n) :
    highGrowth n/2 < ppGrowth A := by
  have hleg := box_legal n hn A hA
  have hap := path_input_pos (by omega) A id hleg
  rw [ppGrowth_eq_of_unique A id hleg (box_unique n hn A hA)]
  let z : Fin n := ⟨n-1,by omega⟩
  have herr := box_pivot_close n hn A hA z z z
  have hlast : referenceStates n z.val z z = highGrowth n := by
    rw [reference_column z z le_rfl]
    simp [z, highGrowth, show n-1+1=n by omega]
  rw [hlast] at herr
  have hinput : entryMax A ≤ 9/8 := by
    apply entryMax_le _ _ (by norm_num)
    intro i j
    have hab := hA i j
    have hw : |wilkinson n i j| ≤ 1 := by
      simpa [wilkinson_entryMax n (by omega)] using entry_le (wilkinson n) i j
    have hd := boxRadius_le_eighth n (by omega)
    calc
      |A i j| = |(A i j-wilkinson n i j)+wilkinson n i j| := by ring_nf
      _ ≤ |A i j-wilkinson n i j|+|wilkinson n i j| := abs_add_le _ _
      _ ≤ 9/8 := by linarith
  have hc : 1 ≤ highGrowth n := one_le_pow₀ (by norm_num)
  have hcl : highGrowth n-1/8 ≤ states A id z.val z z := by
    have := (abs_le.mp herr).1
    linarith
  have hlastp := box_pivot_positive n hn A hA z
  have hdiv : highGrowth n/2 < |states A id z.val z z| / entryMax A := by
    apply (lt_div_iff₀ hap).mpr
    rw [abs_of_pos hlastp]
    nlinarith
  exact hdiv.trans_le (pathGrowth_ge_entry A id hap z z z)

lemma full_box_robustness_proved (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n) :
    A.det ≠ 0 ∧ IsLegal A id ∧
    (∀ π : Schedule n, IsLegal A π → π = id) ∧
    (∀ k : Fin n, ∀ i : Fin n, k < i →
      |states A id k.val i k| < |states A id k.val k k|) ∧
    (∀ k : ℕ, k < n →
      entryMax (states A id k-referenceStates n k) ≤ amplification n^k*boxRadius n) ∧
    highGrowth n/2 < ppGrowth A := by
  have hl := box_legal n hn A hA
  exact ⟨det_ne_zero_of_pivots A id (fun k => ⟨(hl k).1,(hl k).2.1⟩), hl,
    box_unique n hn A hA, box_strict_column n hn A hA,
    box_state_error n hn A hA, box_growth_lower n hn A hA⟩

end NLA.IE04
