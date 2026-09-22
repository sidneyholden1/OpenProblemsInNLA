/- Complexification and realification preserve the actual matrix positivity
and real-coefficient eigen-equations used by SP-05. -/
import NLA.SP05.Geometry
import Mathlib.Analysis.Matrix.Order
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Matrix
open scoped BigOperators ComplexOrder MatrixOrder
noncomputable section
namespace NLA.SP05

lemma real_posDef_complex {n : Type*} [Fintype n] [DecidableEq n]
    (A : Matrix n n ℝ) (hA : A.PosDef) : (A.map Complex.ofReal).PosDef := by
  obtain ⟨U,hU,hAU⟩ : ∃ U : Matrix n n ℝ, IsUnit U ∧ A=star U*U :=
    CStarAlgebra.isStrictlyPositive_iff_eq_star_mul_self.mp hA.isStrictlyPositive
  let f : Matrix n n ℝ →+* Matrix n n ℂ := Complex.ofRealHom.mapMatrix
  have hUc : IsUnit (f U) := hU.map f
  have hstar : f (star U) = star (f U) := by ext i j; simp [f]
  have hAc : A.map Complex.ofReal = star (f U)*(f U) := by
    change f A = _
    rw [hAU,map_mul,hstar]
  rw [hAc]
  simpa using hUc.posDef_star_left_conjugate_iff.mpr (Matrix.PosDef.one : (1 : Matrix n n ℂ).PosDef)

lemma complex_posSemidef_real {n : Type*} [Fintype n] [DecidableEq n]
    (X : Matrix n n ℂ) (hX : X.PosSemidef) : (X.map Complex.re).PosSemidef := by
  rw [Matrix.posSemidef_iff_dotProduct_mulVec]
  refine ⟨hX.isHermitian.map Complex.re (by intro z; simp),?_⟩
  intro v
  have h := hX.re_dotProduct_nonneg (fun i => (v i : ℂ))
  simpa [dotProduct,Matrix.mulVec,Complex.mul_re,Finset.mul_sum] using h

lemma complex_psd_real_ne_zero {n : Type*} [Fintype n] [DecidableEq n]
    (X : Matrix n n ℂ) (hX : X.PosSemidef) (hx : X ≠ 0) : X.map Complex.re ≠ 0 := by
  intro hr
  apply hx
  apply hX.trace_eq_zero_iff.mp
  apply Complex.ext
  · have hi : ∀ i, (X i i).re = 0 := fun i => congrFun (congrFun hr i) i
    simp [Matrix.trace,Matrix.diag,hi]
  · exact (RCLike.nonneg_iff.mp hX.trace_nonneg).2

lemma real_eigen_transport {n : ℕ} (K : BigMat n) (X : Matrix (Fin n) (Fin n) ℂ) (μ : ℝ)
    (he : (K.map Complex.ofReal).mulVec (vecM X) = (μ:ℂ) • vecM X) :
    K.mulVec (columnVec (X.map Complex.re)) = μ • columnVec (X.map Complex.re) := by
  funext i
  have hi := congrArg Complex.re (congrFun he i)
  simpa [Matrix.mulVec,dotProduct,vecM,columnVec,Complex.mul_re] using hi

#assert_trust kernel real_posDef_complex
#assert_trust kernel complex_posSemidef_real
#assert_trust kernel complex_psd_real_ne_zero
#assert_trust kernel real_eigen_transport
end NLA.SP05
