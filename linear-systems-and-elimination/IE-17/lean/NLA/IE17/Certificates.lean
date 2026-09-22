/- Exact rational certificates for Colbrook's IE-17 counterexample.
Formalization: Sidney Holden, with OpenAI Codex assistance. Apache 2.0. -/
import NLA.IE17.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 4000000
open scoped BigOperators Classical Matrix MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.IE17
def upperE : Matrix (Fin 4) (Fin 3) ℝ := !![-82605007467565780/83605574761527903, 1935141443699540/27868524920509301, 421707455855450/27868524920509301;
  39351326577989/167211149523055806, -11644520940683327/27868524920509301, -17771148162006125/55737049841018602;
  -10780617925213/83605574761527903, 11977623324684560/27868524920509301, 9139875006794090/27868524920509301;
  -6175589313810285/55737049841018602, -12599865024711003/27868524920509301, -19466291678089345/55737049841018602]
def upperL : Matrix (Fin 3) (Fin 3) ℝ := !![1, 0, 0;
  589582761960115650204097482000/32082903136661873741517122683, 1, 0;
  -106612695230984315281013395000/4583271876665981963073874669, 35116855505169327891330000/2526440607887109017861870683, 1]
def upperD : Fin 3 → ℝ := ![32082903136661873741517122683/31584381671763314443807585554000, 4999825963008588746348642081657/64165806273323747483034245366000, 1643701075719490133637293519971/15158643647322654107171224098000]

lemma upper_feasible : feasible witnessA upperE witnessB x1 := by
  ext i; fin_cases i <;>
    norm_num [feasible, witnessA, upperE, witnessB, x1, Matrix.mulVec,
      dotProduct, Fin.sum_univ_succ]

lemma upper_ldl :
    (1979/2000 : ℝ) • (1 : Matrix (Fin 3) (Fin 3) ℝ) - upperEᵀ * upperE =
      upperL * Matrix.diagonal upperD * upperLᵀ := by
  ext i j; fin_cases i <;> fin_cases j <;>
    norm_num [upperE, upperL, upperD, Matrix.mul_apply, Fin.sum_univ_succ,
      Matrix.diagonal_apply, Matrix.vecMul, dotProduct]

lemma upper_psd : ((1979/2000 : ℝ) • (1 : Matrix (Fin 3) (Fin 3) ℝ) -
    upperEᵀ * upperE).PosSemidef := by
  rw [upper_ldl]
  have hd : (Matrix.diagonal upperD).PosSemidef :=
    Matrix.PosSemidef.diagonal (by intro i; fin_cases i <;> norm_num [upperD])
  simpa using hd.conjTranspose_mul_mul_same upperLᵀ

lemma upper_norm_sq : ‖upperE‖^2 ≤ (1979/2000 : ℝ) := by
  have hh : ‖upperE‖ ≤ Real.sqrt (1979/2000) := by
    rw [Matrix.l2_opNorm_def]
    apply ContinuousLinearMap.opNorm_le_bound _ (Real.sqrt_nonneg _)
    intro v
    change ‖WithLp.toLp 2 (upperE *ᵥ v)‖ ≤ Real.sqrt (1979/2000)*‖v‖
    have hp := upper_psd.dotProduct_mulVec_nonneg (v : Fin 3 → ℝ)
    simp only [star_trivial, Matrix.sub_mulVec, dotProduct_sub, Matrix.smul_mulVec,
      Matrix.one_mulVec, dotProduct_smul, ← Matrix.mulVec_mulVec,
      Matrix.dotProduct_transpose_mulVec] at hp
    have hx : (v : Fin 3 → ℝ) ⬝ᵥ v = ‖v‖^2 := by
      simpa [dotProduct, pow_two] using (EuclideanSpace.real_norm_sq_eq v).symm
    have hy : (upperE *ᵥ v) ⬝ᵥ (upperE *ᵥ v) = ‖WithLp.toLp 2 (upperE *ᵥ v)‖^2 := by
      simpa [dotProduct, pow_two] using
        (EuclideanSpace.real_norm_sq_eq (WithLp.toLp 2 (upperE *ᵥ v))).symm
    rw [hx,hy, smul_eq_mul] at hp
    have hs := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 1979/2000)
    have ht := mul_nonneg (Real.sqrt_nonneg (1979/2000)) (norm_nonneg v)
    have hprod : (Real.sqrt (1979/2000)*‖v‖)^2 = (1979/2000)*‖v‖^2 := by
      rw [mul_pow, hs]
    nlinarith [norm_nonneg (WithLp.toLp 2 (upperE *ᵥ v))]
  have hs := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 1979/2000)
  nlinarith [norm_nonneg upperE, Real.sqrt_nonneg (1979/2000)]

def lowerK : Matrix (Fin 4) (Fin 4) ℝ := !![206417059721, -50293465200, 1125984433750, -1435003762500;
  -50293465200, 83658415217471, 206242965000, -26574143750;
  1125984433750, 206242965000, 61800032332121, 80360210700;
  -1435003762500, -26574143750, 80360210700, 11170189945871]

lemma lower_quadratic_nonneg (v : Fin 4 → ℝ) : 0 ≤ v ⬝ᵥ (lowerK *ᵥ v) := by
  have he : v ⬝ᵥ (lowerK *ᵥ v) =
    (16822754757/40 : ℝ)*(v 0)^2 +
    (26121390621221/1 : ℝ)*(v 1)^2 +
    (13486908497877/37 : ℝ)*(v 2)^2 +
    (4437502475659/129 : ℝ)*(v 3)^2 +
    (201173860800000 : ℝ)*(v 0/2000 - v 1/2)^2 +
    (83322848097500000 : ℝ)*(v 0/2000 + v 2/37)^2 +
    (740461941450000000 : ℝ)*(v 0/2000 - v 3/258)^2 +
    (15261979410000 : ℝ)*(v 1/2 + v 2/37)^2 +
    (13712258175000 : ℝ)*(v 1/2 - v 3/258)^2 +
    (767118571342200 : ℝ)*(v 2/37 + v 3/258)^2 := by
    simp [lowerK, Matrix.mulVec, dotProduct, Fin.sum_univ_succ]
    ring
  rw [he]
  positivity

/-- The fixed positive matrix is exactly the separating lower-error form. -/
lemma lower_form (v : Fin 4 → ℝ) :
    (99/100 : ℝ)*(v ⬝ᵥ v) ≤
      (5/6 : ℝ)*((witnessAᵀ *ᵥ v) ⬝ᵥ (witnessAᵀ *ᵥ v)) +
      (1/6 : ℝ)/(x2 ⬝ᵥ x2)*
        (((residual witnessA witnessB x2) ⬝ᵥ (residual witnessA witnessB x2))*(v ⬝ᵥ v) -
          ((residual witnessA witnessB x2) ⬝ᵥ v)^2 + ((witnessA *ᵥ x2) ⬝ᵥ v)^2) := by
  have he :
      (5/6 : ℝ)*((witnessAᵀ *ᵥ v) ⬝ᵥ (witnessAᵀ *ᵥ v)) +
      (1/6 : ℝ)/(x2 ⬝ᵥ x2)*
        (((residual witnessA witnessB x2) ⬝ᵥ (residual witnessA witnessB x2))*(v ⬝ᵥ v) -
          ((residual witnessA witnessB x2) ⬝ᵥ v)^2 + ((witnessA *ᵥ x2) ⬝ᵥ v)^2) -
      (99/100 : ℝ)*(v ⬝ᵥ v) = (v ⬝ᵥ (lowerK *ᵥ v))/2407881992100 := by
    norm_num [witnessA, witnessB, x2, residual, lowerK, Matrix.mulVec, dotProduct,
      Fin.sum_univ_succ]
    ring
  have hp := lower_quadratic_nonneg v
  linarith

#assert_trust kernel upper_feasible
#assert_trust kernel upper_norm_sq
#assert_trust kernel lower_quadratic_nonneg
end NLA.IE17
