/- Lifting exact integer QR/LU certificates to the actual real matrices.
Stepaniants's counterexample, formalized by Sidney Holden with Codex. Apache 2.0. -/
import NLA.IE05.Bounds
import NLA.IE05.IntegerCertificates
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 4000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE05

def realL (b : Bool) := if b then witnessLower else lowerMatrix 8
def realQ (b : Bool) := normalized (intH b) (intD b)
def realStates (b : Bool) := luStates (realL b) (intT b) (intD b)

lemma realL_cast (b : Bool) (i j : Fin 8) : realL b i j = (intL b i j : ℝ) := by
  cases b <;> simp [realL, intL, witnessLower, lowerMatrix]

lemma root_pos (b : Bool) (i : Fin 8) : 0 < Real.sqrt (intD b i : ℝ) := by
  apply Real.sqrt_pos.mpr
  exact_mod_cast (int_diag_pos b i).1
lemma root_sq (b : Bool) (i : Fin 8) : (Real.sqrt (intD b i : ℝ))^2 = (intD b i : ℝ) :=
  Real.sq_sqrt (by exact_mod_cast (int_diag_pos b i).1.le)

lemma realStates_cast (b : Bool) (k : ℕ) (i j : Fin 8) :
    realStates b k i j = (intState b k i j : ℝ)/Real.sqrt (intD b j : ℝ) := by
  simp only [realStates, luStates, intState]
  split_ifs with h
  · congr 1
    push_cast
    apply Finset.sum_congr rfl
    intro ell _
    split_ifs <;> simp [realL_cast]
  · simp

lemma real_orthogonal (b : Bool) : orthogonal (realQ b) := by
  ext i j
  change (∑ k : Fin 8, ((intH b k i : ℝ)/Real.sqrt (intD b i : ℝ))*
    ((intH b k j : ℝ)/Real.sqrt (intD b j : ℝ))) = (1 : Matrix (Fin 8) (Fin 8) ℝ) i j
  have hs : (∑ k : Fin 8, (intH b k i : ℝ)*(intH b k j : ℝ)) =
      if i=j then (intD b i : ℝ) else 0 := by exact_mod_cast int_gram b i j
  calc
    (∑ k : Fin 8, ((intH b k i : ℝ)/Real.sqrt (intD b i : ℝ))*
        ((intH b k j : ℝ)/Real.sqrt (intD b j : ℝ))) =
      (∑ k : Fin 8, (intH b k i : ℝ)*(intH b k j : ℝ)) /
        (Real.sqrt (intD b i : ℝ)*Real.sqrt (intD b j : ℝ)) := by
          rw [Finset.sum_div]
          apply Finset.sum_congr rfl
          intro k _
          ring
    _ = (1 : Matrix (Fin 8) (Fin 8) ℝ) i j := by
      rw [hs]
      by_cases hij : i=j
      · subst j
        have hd : (0 : ℝ) < intD b i := by exact_mod_cast (int_diag_pos b i).1
        simp [Real.mul_self_sqrt hd.le, ne_of_gt hd]
      · simp [hij]

lemma qr_entry (b : Bool) (i j : Fin 8) :
    ((realQ b)ᵀ * realL b) i j =
      (∑ k : Fin 8, (intH b k i : ℝ)*(intL b k j : ℝ))/Real.sqrt (intD b i : ℝ) := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, realQ, normalized, realL_cast]
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro k _
  ring

lemma real_qr (b : Bool) : positiveQR (realL b) (realQ b) ((realQ b)ᵀ * realL b) := by
  refine ⟨real_orthogonal b, ?_, ?_, ?_⟩
  · rw [← Matrix.mul_assoc, mul_eq_one_comm.mp (real_orthogonal b), Matrix.one_mul]
  · intro i j hij
    rw [qr_entry]
    have hs : (∑ k : Fin 8, (intH b k i : ℝ)*(intL b k j : ℝ)) = 0 := by
      exact_mod_cast int_qr_upper b i j hij
    simp [hs]
  · intro i
    rw [qr_entry]
    apply div_pos _ (root_pos b i)
    exact_mod_cast int_qr_pos b i

theorem qr_certificates :
    positiveQR (lowerMatrix 8) candidateQ candidateR ∧
    positiveQR witnessLower witnessQ witnessR := by
  exact ⟨real_qr false, real_qr true⟩

lemma real_initial (b : Bool) : realStates b 0 = realQ b := by
  ext i j
  rw [realStates_cast, int_state_initial]
  rfl
lemma real_pivot (b : Bool) (k i : Fin 8) (hi : k ≤ i) :
    realStates b k.val i k = (intL b i k : ℝ) *
      ((intT b k k : ℝ)/Real.sqrt (intD b k : ℝ)) := by
  rw [realStates_cast, int_state_pivot b k i hi]
  push_cast
  ring
lemma real_pivot_diag (b : Bool) (k : Fin 8) :
    realStates b k.val k k = (intT b k k : ℝ)/Real.sqrt (intD b k : ℝ) := by
  rw [real_pivot b k k le_rfl, int_lower_diag]
  simp
lemma real_pivot_pos (b : Bool) (k : Fin 8) : 0 < realStates b k.val k k := by
  rw [real_pivot_diag]
  apply div_pos _ (root_pos b k)
  exact_mod_cast (int_diag_pos b k).2

lemma real_recurrence (b : Bool) (k : Fin 8) (hk : k.val+1 < 8) :
    realStates b (k.val+1) = schurStep (realStates b k.val) k k := by
  let f : Fin 7 := ⟨k.val,by omega⟩
  have hf : f.castSucc = k := by ext; rfl
  ext i j
  rw [realStates_cast, schurStep]
  simp only [Equiv.swap_self, Equiv.refl_apply]
  have hr := int_state_recurrence b f i j
  change intState b (k.val+1) i j = _ at hr
  rw [hf] at hr
  rw [hr]
  split_ifs with hij
  · rw [real_pivot b k i hij.1.le, real_pivot_diag, realStates_cast, realStates_cast]
    push_cast
    have hp := ne_of_gt (real_pivot_pos b k)
    rw [real_pivot_diag] at hp
    have ht : (intT b k k : ℝ) ≠ 0 := ne_of_gt (by exact_mod_cast (int_diag_pos b k).2)
    dsimp [f]
    field_simp [ht, ne_of_gt (root_pos b k), ne_of_gt (root_pos b j)]
  · simp

lemma real_first_path (b : Bool) : isFirstPath (realQ b) (realStates b) (fun k => k) := by
  refine ⟨⟨real_initial b, ?_⟩, ?_⟩
  · intro k
    refine ⟨le_rfl, ne_of_gt (real_pivot_pos b k), ?_, real_recurrence b k⟩
    intro i hi
    rw [real_pivot b k i hi, real_pivot_diag, abs_mul]
    have hl : |(intL b i k : ℝ)| ≤ 1 := by exact_mod_cast int_lower_bound b i k
    nlinarith [abs_nonneg ((intT b k k : ℝ)/Real.sqrt (intD b k : ℝ))]
  · intro k i hi _
    exact hi

theorem pivot_certificates :
    isFirstPath candidateQ candidateStates (fun k => k) ∧
    isFirstPath witnessQ witnessStates (fun k => k) :=
  ⟨real_first_path false, real_first_path true⟩

#assert_trust kernel qr_certificates
#assert_trust kernel pivot_certificates
end NLA.IE05
