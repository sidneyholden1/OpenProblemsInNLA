/- Colbrook's actual projected-residual approximation for IE-17.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache 2.0. -/
import NLA.IE17.Proof
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.IE17

def scaledStack (t : ℝ) : Matrix (Fin 4 ⊕ Fin 3) (Fin 3) ℝ :=
  Matrix.fromRows witnessA (t • (1 : Matrix (Fin 3) (Fin 3) ℝ))
def gramDiagonal (t : ℝ) : Fin 3 → ℝ := ![1+t^2,36+t^2,25+t^2]
def gramInverse (t : ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  Matrix.diagonal (fun i => (gramDiagonal t i)⁻¹)

lemma stack_gram (t : ℝ) :
    (scaledStack t)ᵀ * scaledStack t = Matrix.diagonal (gramDiagonal t) := by
  rw [scaledStack, Matrix.transpose_fromRows, Matrix.fromCols_mul_fromRows]
  ext i j; fin_cases i <;> fin_cases j <;>
    norm_num [gramDiagonal, witnessA, Matrix.mul_apply, Matrix.vecMul, dotProduct,
      Fin.sum_univ_succ, Matrix.diagonal_apply] <;> ring

lemma gram_nonzero (t : ℝ) (i : Fin 3) : gramDiagonal t i ≠ 0 := by
  fin_cases i <;> simp [gramDiagonal] <;> nlinarith [sq_nonneg t]

lemma stack_gram_right_inverse (t : ℝ) :
    ((scaledStack t)ᵀ * scaledStack t) * gramInverse t = 1 := by
  rw [stack_gram, gramInverse, Matrix.diagonal_mul_diagonal]
  simp [gram_nonzero]

lemma stack_pseudo (t : ℝ) : leftPseudo (scaledStack t) = gramInverse t * (scaledStack t)ᵀ := by
  rw [leftPseudo, Matrix.inv_eq_right_inv (stack_gram_right_inverse t)]

lemma stack_pseudo_left (t : ℝ) : leftPseudo (scaledStack t) * scaledStack t = 1 := by
  rw [stack_pseudo, Matrix.mul_assoc, stack_gram, gramInverse, Matrix.diagonal_mul_diagonal]
  simp [gram_nonzero]

lemma stack_penrose (t : ℝ) : moorePenrose (scaledStack t) (leftPseudo (scaledStack t)) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [Matrix.mul_assoc, stack_pseudo_left, Matrix.mul_one]
  · rw [stack_pseudo_left, Matrix.one_mul]
  · rw [stack_pseudo]
    simp [Matrix.transpose_mul, gramInverse, Matrix.mul_assoc]
  · rw [stack_pseudo_left, Matrix.transpose_one]

lemma projector_norm_sq (t : ℝ) (r : Fin 4 → ℝ) :
    vnorm ((scaledStack t * leftPseudo (scaledStack t)) *ᵥ
      Sum.elim r (0 : Fin 3 → ℝ))^2 =
      (r 0)^2/(1+t^2)+(6*r 1)^2/(36+t^2)+(5*r 2)^2/(25+t^2) := by
  rw [stack_pseudo, ← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec]
  simp only [scaledStack, Matrix.transpose_fromRows, Matrix.fromCols_mulVec,
    Matrix.fromRows_mulVec]
  simp [vnorm_sq, Fintype.sum_sum_type, gramInverse, gramDiagonal, witnessA,
    Matrix.mulVec, Matrix.vecMul, dotProduct, Fin.sum_univ_succ]
  have h1 : (1 : ℝ)+t^2 ≠ 0 := by nlinarith [sq_nonneg t]
  have h36 : (36 : ℝ)+t^2 ≠ 0 := by nlinarith [sq_nonneg t]
  have h25 : (25 : ℝ)+t^2 ≠ 0 := by nlinarith [sq_nonneg t]
  field_simp
  ring

lemma approximate_formula (x : Fin 3 → ℝ) (hx : x ≠ 0)
    (hn : normalResidual witnessA witnessB x ≠ 0) :
    (approxError witnessA witnessB x)^2 =
      ((residual witnessA witnessB x) 0)^2 /
        (vnorm x^2 + vnorm (residual witnessA witnessB x)^2) +
      (6*(residual witnessA witnessB x) 1)^2 /
        (36*vnorm x^2 + vnorm (residual witnessA witnessB x)^2) +
      (5*(residual witnessA witnessB x) 2)^2 /
        (25*vnorm x^2 + vnorm (residual witnessA witnessB x)^2) := by
  let t := vnorm (residual witnessA witnessB x) / vnorm x
  have hk : stacked witnessA witnessB x = scaledStack t := rfl
  rw [approxError, if_neg hn, hk, div_pow, projector_norm_sq]
  have hs : 0 < vnorm x^2 := sq_pos_of_pos (vnorm_pos hx)
  have hr : 0 ≤ vnorm (residual witnessA witnessB x)^2 := sq_nonneg _
  dsimp [t]
  simp only [div_pow]
  field_simp [ne_of_gt (vnorm_pos hx)]

lemma approximation_nonneg (x : Fin 3 → ℝ) : 0 ≤ approxError witnessA witnessB x := by
  unfold approxError
  split_ifs
  · exact le_rfl
  · exact div_nonneg (vnorm_nonneg _) (vnorm_nonneg _)

theorem approximation_increase :
    moorePenrose (stacked witnessA witnessB x1) (leftPseudo (stacked witnessA witnessB x1)) ∧
    moorePenrose (stacked witnessA witnessB x2) (leftPseudo (stacked witnessA witnessB x2)) ∧
    (approxError witnessA witnessB x1)^2 = approxSquared1 ∧
    (approxError witnessA witnessB x2)^2 = approxSquared2 ∧
    approxError witnessA witnessB x1 < approxError witnessA witnessB x2 := by
  have h1 : (approxError witnessA witnessB x1)^2 = approxSquared1 := by
    rw [approximate_formula x1 iterates.2.2.2.1 iterates.2.2.2.2.2.1]
    rw [residual_one]
    norm_num [approxSquared1, vnorm_sq, x1, Fin.sum_univ_succ, Matrix.cons_val_two]
  have h2 : (approxError witnessA witnessB x2)^2 = approxSquared2 := by
    rw [approximate_formula x2 iterates.2.2.2.2.1 iterates.2.2.2.2.2.2]
    rw [residual_two]
    norm_num [approxSquared2, vnorm_sq, x2, Fin.sum_univ_succ, Matrix.cons_val_two]
  refine ⟨stack_penrose _, stack_penrose _, h1,h2, ?_⟩
  have hcut1 : approxSquared1 < (503/500 : ℝ) := by
    unfold approxSquared1
    interval_decide (trust := kernel)
  have hcut2 : (1007/1000 : ℝ) < approxSquared2 := by
    unfold approxSquared2
    interval_decide (trust := kernel)
  nlinarith [approximation_nonneg x1, approximation_nonneg x2]

#assert_trust kernel approximation_increase
end NLA.IE17
