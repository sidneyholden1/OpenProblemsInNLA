/- MI-04: orthogonal-pair symmetry, normality and spectral geometry.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden with
OpenAI Codex assistance. Apache-2.0. -/
import NLA.MI04.Definitions
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Tactic

set_option autoImplicit false
noncomputable section
open scoped ComplexConjugate
namespace NLA.MI04

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E] [CompleteSpace E]

def OperatorPairSymmetry (T : E →L[ℂ] E) : Prop :=
  ∀ u v : E, ‖u‖ = 1 → ‖v‖ = 1 → inner ℂ u v = 0 →
    ‖inner ℂ u (T v)‖ = ‖inner ℂ v (T u)‖

theorem pair_symmetry_orthogonal {T : E →L[ℂ] E} (hT : OperatorPairSymmetry T)
    (u v : E) (huv : inner ℂ u v = 0) :
    ‖inner ℂ u (T v)‖ = ‖inner ℂ v (T u)‖ := by
  by_cases hu : u = 0
  · simp [hu]
  by_cases hv : v = 0
  · simp [hv]
  have hun : ‖u‖ ≠ 0 := norm_ne_zero_iff.mpr hu
  have hvn : ‖v‖ ≠ 0 := norm_ne_zero_iff.mpr hv
  have h := hT ((‖u‖⁻¹ : ℂ) • u) ((‖v‖⁻¹ : ℂ) • v)
    (by simp [norm_smul, Complex.norm_real, abs_of_nonneg (norm_nonneg u), hun])
    (by simp [norm_smul, Complex.norm_real, abs_of_nonneg (norm_nonneg v), hvn])
    (by simp [inner_smul_left, inner_smul_right, huv])
  simp [map_smul, inner_smul_left, inner_smul_right, norm_mul] at h
  field_simp at h
  nlinarith

theorem pair_symmetry_normal {T : E →L[ℂ] E} (hT : OperatorPairSymmetry T) :
    IsStarNormal T := by
  classical
  apply ContinuousLinearMap.isStarNormal_iff_norm_eq_adjoint.mpr
  have hunit : ∀ u : E, ‖u‖ = 1 → ‖T u‖ = ‖T.adjoint u‖ := by
    intro u hu
    have hon : Orthonormal ℂ ((↑) : ({u} : Set E) → E) := by
      rw [orthonormal_subsingleton_iff]
      intro x
      have hx : (x : E) = u := Set.mem_singleton_iff.mp x.property
      simpa [hx] using hu
    obtain ⟨s, b, hs, hb⟩ := hon.exists_orthonormalBasis_extension
    have hus : u ∈ s := hs (Set.mem_singleton u)
    let k : s := ⟨u, hus⟩
    have hbk : b k = u := congrFun hb k
    have hsum : ∀ j, ‖inner ℂ (b j) (T u)‖ = ‖inner ℂ (b j) (T.adjoint u)‖ := by
      intro j
      rw [T.adjoint_inner_right, norm_inner_symm (T (b j)) u]
      by_cases hj : j = k
      · simp [hj, hbk]
      · exact hT (b j) u (b.orthonormal.norm_eq_one j) hu
          (by rw [← hbk]; exact b.orthonormal.inner_eq_zero hj)
    have heq : ‖T u‖ ^ 2 = ‖T.adjoint u‖ ^ 2 := by
      rw [← b.sum_sq_norm_inner_right, ← b.sum_sq_norm_inner_right]
      exact Finset.sum_congr rfl (fun j _ => congrArg (fun t : ℝ => t ^ 2) (hsum j))
    nlinarith [norm_nonneg (T u), norm_nonneg (T.adjoint u)]
  intro u
  by_cases hu : u = 0
  · simp [hu]
  have hun : ‖u‖ ≠ 0 := norm_ne_zero_iff.mpr hu
  have h := hunit ((‖u‖⁻¹ : ℂ) • u)
    (by simp [norm_smul, Complex.norm_real, abs_of_nonneg (norm_nonneg u), hun])
  simp [map_smul, norm_smul] at h
  exact h.resolve_right hu

end NLA.MI04
