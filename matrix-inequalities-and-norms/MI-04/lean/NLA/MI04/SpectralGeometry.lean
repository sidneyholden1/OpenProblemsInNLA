/- MI-04: exact spectral geometry of orthogonal-pair symmetry.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden with Codex. -/
import NLA.MI04.PairGeometry
import NLA.MI04.ScalarGeometry
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Instances
import Mathlib.Analysis.Normed.Operator.Banach
import Mathlib.LinearAlgebra.Eigenspace.Basic
set_option autoImplicit false
noncomputable section
open scoped ComplexConjugate
namespace NLA.MI04
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E] [CompleteSpace E]

theorem normal_sub_scalar (T : E →L[ℂ] E) [IsStarNormal T] (a : ℂ) :
    IsStarNormal (T - algebraMap ℂ (E →L[ℂ] E) a) := by
  have hn : IsStarNormal (algebraMap ℂ (E →L[ℂ] E) a) := by
    rw [Algebra.algebraMap_eq_smul_one]
    infer_instance
  letI := hn
  apply Commute.isStarNormal_sub
  rw [Algebra.algebraMap_eq_smul_one, star_smul, star_one]
  exact (Commute.one_right T).smul_right (star a)

theorem normal_eigenvectors_orthogonal (T : E →L[ℂ] E) [IsStarNormal T]
    (a b : ℂ) (hab : a ≠ b) (u v : E) (hu : T u = a • u) (hv : T v = b • v) :
    inner ℂ u v = 0 := by
  let S := T - algebraMap ℂ (E →L[ℂ] E) a
  have hS : IsStarNormal S := normal_sub_scalar T a
  have hSu : S u = 0 := by simp [S, Algebra.algebraMap_eq_smul_one, hu]
  have hSstar : S.adjoint u = 0 :=
    (ContinuousLinearMap.IsStarNormal.adjoint_apply_eq_zero_iff hS u).mpr hSu
  have heq : (b-a) * inner ℂ u v = 0 := by
    calc
      _ = inner ℂ u (S v) := by
        simp [S, Algebra.algebraMap_eq_smul_one, hv, inner_sub_right,
          inner_smul_right, sub_mul]
      _ = inner ℂ (S.adjoint u) v := (S.adjoint_inner_left v u).symm
      _ = 0 := by rw [hSstar, inner_zero_left]
  exact (mul_eq_zero.mp heq).resolve_left (sub_ne_zero.mpr hab.symm)

theorem spectrum_unit_eigenvector (T : E →L[ℂ] E) (a : ℂ)
    (ha : a ∈ spectrum ℂ T) : ∃ u : E, ‖u‖ = 1 ∧ T u = a • u := by
  rw [ContinuousLinearMap.spectrum_eq] at ha
  obtain ⟨u,hu⟩ := (Module.End.hasEigenvalue_iff_mem_spectrum.mpr ha).exists_hasEigenvector
  have hn : ‖u‖ ≠ 0 := norm_ne_zero_iff.mpr hu.2
  refine ⟨(‖u‖⁻¹ : ℂ) • u, ?_, ?_⟩
  · simp [norm_smul, hn]
  · have he : T u = a • u := hu.apply_eq_smul
    rw [map_smul, he, smul_smul, smul_smul, mul_comm]

theorem eigen_triple_collinear (T : E →L[ℂ] E) (hT : OperatorPairSymmetry T)
    (a b c : ℂ) (u v w : E) (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (hw : ‖w‖ = 1)
    (huv : inner ℂ u v = 0) (huw : inner ℂ u w = 0) (hvw : inner ℂ v w = 0)
    (hTu : T u = a • u) (hTv : T v = b • v) (hTw : T w = c • w) :
    ((a-c)*star (b-c)).im = 0 := by
  have hvu := inner_eq_zero_symm.mp huv
  have hwu := inner_eq_zero_symm.mp huw
  have hwv := inner_eq_zero_symm.mp hvw
  have hoo : inner ℂ (u+v+w) (u+omega • v+star omega • w) = 0 := by
    simpa [inner_add_left,inner_add_right,inner_smul_left,inner_smul_right,
      inner_self_eq_norm_sq_to_K,hu,hv,hw,huv,huw,hvw,hvu,hwu,hwv] using omega_sum
  have hp := pair_symmetry_orthogonal hT (u+v+w) (u+omega • v+star omega • w) hoo
  have hleft : inner ℂ (u+v+w) (T (u+omega • v+star omega • w)) =
      a+omega*b+star omega*c := by
    simp [map_add,map_smul,hTu,hTv,hTw,inner_add_left,inner_add_right,
      inner_smul_left,inner_smul_right,inner_self_eq_norm_sq_to_K,
      hu,hv,hw,huv,huw,hvw,hvu,hwu,hwv,mul_comm]
  have hright : inner ℂ (u+omega • v+star omega • w) (T (u+v+w)) =
      a+star omega*b+omega*c := by
    simp [map_add,map_smul,hTu,hTv,hTw,inner_add_left,inner_add_right,
      inner_smul_left,inner_smul_right,inner_self_eq_norm_sq_to_K,
      hu,hv,hw,huv,huw,hvw,hvu,hwu,hwv,mul_comm]
  rw [hleft,hright] at hp
  exact fourier_equal_im_zero a b c hp

theorem spectrum_triples_collinear (T : E →L[ℂ] E) (hT : OperatorPairSymmetry T)
    (a b c : ℂ) (ha : a ∈ spectrum ℂ T) (hb : b ∈ spectrum ℂ T)
    (hc : c ∈ spectrum ℂ T) : ((a-c)*star (b-c)).im = 0 := by
  by_cases hac : a=c
  · simp [hac]
  by_cases hbc : b=c
  · simp [hbc]
  by_cases hab : a=b
  · simp [hab,Complex.mul_im]
    ring
  letI : IsStarNormal T := pair_symmetry_normal hT
  obtain ⟨u,hu,hTu⟩ := spectrum_unit_eigenvector T a ha
  obtain ⟨v,hv,hTv⟩ := spectrum_unit_eigenvector T b hb
  obtain ⟨w,hw,hTw⟩ := spectrum_unit_eigenvector T c hc
  exact eigen_triple_collinear T hT a b c u v w hu hv hw
    (normal_eigenvectors_orthogonal T a b hab u v hTu hTv)
    (normal_eigenvectors_orthogonal T a c hac u w hTu hTw)
    (normal_eigenvectors_orthogonal T b c hbc v w hTv hTw) hTu hTv hTw

#assert_trust kernel spectrum_triples_collinear
end NLA.MI04
