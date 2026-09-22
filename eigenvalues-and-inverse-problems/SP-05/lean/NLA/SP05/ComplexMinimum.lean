/- The complex PSD minimizing eigenmatrix, derived from the actual inverse. -/
import NLA.SP05.SpectralMaximum
import NLA.SP05.ConeEigen
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Order
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Kronecker ComplexOrder MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.SP05

lemma inverse_cap_lower {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]
    (K : Matrix ι ι ℂ) (hK : K.PosDef) (r : ℝ) (hr : 0 < r)
    (hcap : ((r:ℂ) • (1 : Matrix ι ι ℂ)-K⁻¹).PosSemidef) :
    (K-((1/r:ℝ):ℂ) • (1 : Matrix ι ι ℂ)).PosSemidef := by
  let u := hK.isUnit.unit
  have hu : (u : Matrix ι ι ℂ) = K := hK.isUnit.unit_spec
  let v : (Matrix ι ι ℂ)ˣ :=
    ⟨(r:ℂ) • 1,((1/r:ℝ):ℂ) • 1,by
      simp only [smul_mul_assoc,mul_smul_comm,mul_one,smul_smul]
      norm_cast
      simp [hr.ne'],by
      simp only [smul_mul_assoc,mul_smul_comm,mul_one,smul_smul]
      norm_cast
      simp [hr.ne']⟩
  have hpU : 0 ≤ (u : Matrix ι ι ℂ) := by rw [hu]; exact hK.posSemidef.nonneg
  have hpV : 0 ≤ (v : Matrix ι ι ℂ) := by
    change 0 ≤ (r:ℂ) • (1 : Matrix ι ι ℂ)
    exact smul_nonneg (by exact_mod_cast hr.le) zero_le_one
  have hh : (↑u⁻¹ : Matrix ι ι ℂ) ≤ (v : Matrix ι ι ℂ) := by
    rw [Matrix.coe_units_inv,hu]
    exact sub_nonneg.mp hcap.nonneg
  have hout := (CStarAlgebra.inv_le_iff hpU hpV).mp hh
  change ((1/r:ℝ):ℂ) • (1 : Matrix ι ι ℂ) ≤ (u : Matrix ι ι ℂ) at hout
  rw [hu] at hout
  exact hout

/-- A nonzero complex PSD matrix at the global minimum, expressed by an
actual eigenvector and an actual PSD spectral lower bound. -/
theorem complex_psd_minimum {n : ℕ} (hn : 0 < n) (A B : CMat n)
    (hA : A.PosDef) (hB : B.PosDef) :
    ∃ (μ : ℝ) (X : CMat n), 0 < μ ∧ X.PosSemidef ∧ X ≠ 0 ∧
      (cJordan A B).mulVec (vecM X) = (μ:ℂ) • vecM X ∧
      (cJordan A B-(μ:ℂ) • (1 : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ)).PosSemidef := by
  letI : Nonempty (Fin n) := ⟨⟨0,hn⟩⟩
  let K := cJordan A B
  have hK : K.PosDef := cJordan_posDef A B hA hB
  obtain ⟨r,Z,hr,hZ,hZ0,he,hcap⟩ := hermitian_top_data hn K⁻¹ hK.inv
    (fun X => inverseMap_conjTranspose A B X hA hB)
  have he' : K⁻¹.mulVec (vecM Z) = (r:ℂ) • vecM Z := congrArg vecM he
  obtain ⟨X,hX,hX0,hXe⟩ := cone_eigen_of_hermitian K⁻¹ r Z hZ hZ0 he' hcap
    (fun P hP => inverseMap_posSemidef A B P hA hB hP)
  refine ⟨1/r,X,by positivity,hX,hX0,?_,inverse_cap_lower K hK r hr hcap⟩
  have heig := congrArg K.mulVec hXe
  rw [Matrix.mulVec_mulVec,Matrix.mul_nonsing_inv _ (K.isUnit_iff_isUnit_det.mp hK.isUnit),
    Matrix.one_mulVec,Matrix.mulVec_smul] at heig
  have hh := congrArg (fun v : CVec n => ((1/r:ℝ):ℂ) • v) heig
  have hs : ((1/r:ℝ):ℂ)*(r:ℂ) = 1 := by norm_cast; field_simp
  simpa only [smul_smul,hs,one_smul] using hh.symm

#assert_trust kernel complex_psd_minimum
end NLA.SP05
