/- MI-04: collinear spectrum and normality give an affine Hermitian operator.
Source mathematics: Matthew J. Colbrook. Formalization: Sidney Holden with Codex. -/
import NLA.MI04.SpectralGeometry
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Basic
import Mathlib.Analysis.CStarAlgebra.ContinuousLinearMap
set_option autoImplicit false
noncomputable section
open scoped ComplexConjugate
namespace NLA.MI04

lemma collinear_set_line (s : Set ℂ)
    (h : ∀ a ∈ s, ∀ b ∈ s, ∀ c ∈ s, ((a-c)*star (b-c)).im = 0) :
    ∃ α β : ℂ, α ≠ 0 ∧ ∀ z ∈ s, ((z-β)/α).im = 0 := by
  classical
  by_cases he : s.Nonempty
  · obtain ⟨β,hβ⟩ := he
    by_cases hs : ∀ z ∈ s, z=β
    · exact ⟨1,β,one_ne_zero,fun z hz => by simp [hs z hz]⟩
    · push Not at hs
      obtain ⟨γ,hγ,hγβ⟩ := hs
      refine ⟨γ-β,β,sub_ne_zero.mpr hγβ,?_⟩
      intro z hz
      have hh := h z hz γ hγ β hβ
      rw [Complex.div_im]
      have hn : (z-β).im*(γ-β).re-(z-β).re*(γ-β).im = 0 := by
        simp [Complex.mul_im] at hh ⊢
        linear_combination hh
      rw [← sub_div,hn,zero_div]
  · refine ⟨1,0,one_ne_zero,?_⟩
    intro z hz
    exact (he ⟨z,hz⟩).elim

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E] [CompleteSpace E]

theorem pair_operator_affine_hermitian (T : E →L[ℂ] E) (hT : OperatorPairSymmetry T) :
    ∃ K : E →L[ℂ] E, ∃ α β : ℂ, IsSelfAdjoint K ∧ T = α • K + β • 1 := by
  letI : IsStarNormal T := pair_symmetry_normal hT
  obtain ⟨α,β,hα,hline⟩ := collinear_set_line (spectrum ℂ T)
    (fun a ha b hb c hc => spectrum_triples_collinear T hT a b c ha hb hc)
  let K : E →L[ℂ] E := α⁻¹ • (T - algebraMap ℂ (E →L[ℂ] E) β)
  have hKnormal : IsStarNormal K := by
    letI := normal_sub_scalar T β
    exact IsStarNormal.smul _ _
  have hrep : T = α • K + β • (1 : E →L[ℂ] E) := by
    simp [K,smul_smul,hα,Algebra.algebraMap_eq_smul_one]
  have hreal : ∀ z ∈ spectrum ℂ K, z.im=0 := by
    intro z hz
    obtain ⟨u,hu,hKu⟩ := spectrum_unit_eigenvector K z hz
    have hun : u ≠ 0 := by intro he; simp [he] at hu
    have hTu : T u=(α*z+β) • u := by
      rw [hrep]
      simp [hKu,add_smul,smul_smul]
    have heigen : Module.End.HasEigenvector (T : Module.End ℂ E) (α*z+β) u :=
      ⟨Module.End.mem_eigenspace_iff.mpr hTu,hun⟩
    have hzT : α*z+β ∈ spectrum ℂ T := by
      rw [ContinuousLinearMap.spectrum_eq]
      exact (Module.End.hasEigenvalue_of_hasEigenvector heigen).mem_spectrum
    have hh := hline (α*z+β) hzT
    have he : (α*z+β-β)/α=z := by field_simp; ring
    rwa [he] at hh
  refine ⟨K,α,β,?_,hrep⟩
  apply isSelfAdjoint_iff_isStarNormal_and_quasispectrumRestricts.mpr
  refine ⟨hKnormal,?_⟩
  apply SpectrumRestricts.of_rightInvOn Complex.ofReal_re
  intro z hz
  change (z.re : ℂ) = z
  apply Complex.ext
  · rfl
  · simpa using (hreal z hz).symm

theorem pair_implies_essential {n : ℕ} (X : Mat n) (hX : PairModulusSymmetry X) :
    EssentiallyHermitian X := by
  let F : Mat n ≃⋆ₐ[ℂ] (Vec n →L[ℂ] Vec n) := Matrix.toEuclideanCLM
  obtain ⟨K,α,β,hK,he⟩ := pair_operator_affine_hermitian (F X) hX
  refine ⟨F.symm K,α,β,?_,?_⟩
  · change star (F.symm K) = F.symm K
    apply F.injective
    change F (star (F.symm K)) = F (F.symm K)
    simpa only [map_star,StarAlgEquiv.apply_symm_apply] using hK.star_eq
  · apply F.injective
    change F X = F (α • F.symm K + β • 1)
    simpa only [map_add,map_smul,map_one,StarAlgEquiv.apply_symm_apply] using he

#assert_trust kernel pair_implies_essential
#print axioms pair_implies_essential
end NLA.MI04
