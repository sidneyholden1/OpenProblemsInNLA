/- Positive-cone conversion of a Hermitian top eigenmatrix. The source's
absolute-value argument is implemented using the positive/negative CFC parts.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.SP05.Geometry
import Mathlib.Analysis.Matrix.Order
import Mathlib.Tactic
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Matrix
open scoped BigOperators ComplexOrder MatrixOrder
noncomputable section
namespace NLA.SP05

lemma psd_trace_mul_nonneg {n : ℕ} (P Q : Matrix (Fin n) (Fin n) ℂ)
    (hP : P.PosSemidef) (hQ : Q.PosSemidef) : 0 ≤ (P*Q).trace := by
  obtain ⟨U, hU⟩ : ∃ U : Matrix (Fin n) (Fin n) ℂ, P = star U*U :=
    CStarAlgebra.nonneg_iff_eq_star_mul_self.mp hP.nonneg
  rw [hU, Matrix.trace_mul_cycle, Matrix.trace_mul_cycle Q]
  exact (hQ.mul_mul_conjTranspose_same U).trace_nonneg

lemma vecM_pair {n : ℕ} (P Q : Matrix (Fin n) (Fin n) ℂ) :
    star (vecM P) ⬝ᵥ vecM Q = (P.conjTranspose*Q).trace := by
  exact Matrix.star_vec_dotProduct_vec P Q

/-- Convert full spectral maximum data to a PSD eigenmatrix. The spectrum
and the cone-preserving property remain obligations for the actual operator. -/
theorem cone_eigen_of_hermitian {n : ℕ}
    (K : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ) (r : ℝ)
    (Z : Matrix (Fin n) (Fin n) ℂ) (hZ : Z.IsHermitian) (hZ0 : Z ≠ 0)
    (he : K.mulVec (vecM Z) = (r:ℂ) • vecM Z)
    (hd : ((r:ℂ) • (1 : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ)-K).PosSemidef)
    (hc : ∀ P : Matrix (Fin n) (Fin n) ℂ, P.PosSemidef →
      (unvecM (K.mulVec (vecM P))).PosSemidef) :
    ∃ X : Matrix (Fin n) (Fin n) ℂ, X.PosSemidef ∧ X ≠ 0 ∧
      K.mulVec (vecM X) = (r:ℂ) • vecM X := by
  let P := Z⁺
  let N := Z⁻
  have hP : P.PosSemidef := (CFC.posPart_nonneg Z).posSemidef
  have hN : N.PosSemidef := (CFC.negPart_nonneg Z).posSemidef
  have hPN : P-N = Z := CFC.posPart_sub_negPart Z hZ.isSelfAdjoint
  have hortho : star (vecM P) ⬝ᵥ vecM N = 0 := by
    rw [vecM_pair, hP.isHermitian.eq]
    change (Z⁺*Z⁻).trace = 0
    rw [CFC.posPart_mul_negPart,Matrix.trace_zero]
  by_cases hP0 : P = 0
  · have hnz : N ≠ 0 := by intro hn; simp [hP0,hn] at hPN; exact hZ0 hPN.symm
    refine ⟨N,hN,hnz,?_⟩
    have hz : Z = -N := by simpa [hP0] using hPN.symm
    rw [hz] at he
    change K.mulVec (-vecM N) = (r:ℂ) • (-vecM N) at he
    simpa only [Matrix.mulVec_neg,smul_neg,neg_inj] using he
  · refine ⟨P,hP,hP0,?_⟩
    have he' : K.mulVec (vecM P) - K.mulVec (vecM N) =
        (r:ℂ) • vecM P - (r:ℂ) • vecM N := by
      rw [← Matrix.mulVec_sub, ← smul_sub]
      change K.mulVec (vecM (P-N)) = (r:ℂ) • vecM (P-N)
      rw [hPN]; exact he
    have hcross : 0 ≤ star (vecM P) ⬝ᵥ K.mulVec (vecM N) := by
      have ht := psd_trace_mul_nonneg P (unvecM (K.mulVec (vecM N))) hP (hc N hN)
      rw [← hP.isHermitian.eq, ← vecM_pair,vecM_unvecM] at ht
      exact ht
    have hzero : star (vecM P) ⬝ᵥ
        (((r:ℂ) • (1 : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ)-K).mulVec (vecM P)) = 0 := by
      apply le_antisymm _ (hd.dotProduct_mulVec_nonneg _)
      have hp := congrArg (fun v => star (vecM P) ⬝ᵥ v) he'
      simp only [dotProduct_sub,dotProduct_smul,hortho,smul_zero,sub_zero] at hp
      simp only [Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,dotProduct_sub,
        dotProduct_smul]
      rw [← hp]
      simpa only [sub_sub_cancel_left] using neg_nonpos.mpr hcross
    have hz := (hd.dotProduct_mulVec_zero_iff _).mp hzero
    have hh : (r:ℂ) • vecM P = K.mulVec (vecM P) := by
      simpa only [Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,sub_eq_zero] using hz
    exact hh.symm
end NLA.SP05
