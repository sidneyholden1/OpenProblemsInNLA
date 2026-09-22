/- MI-04: transport coordinate symmetry to actual orthonormal pairs.
Formalization: Sidney Holden with OpenAI Codex. Apache-2.0. -/
import NLA.MI04.Definitions
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Tactic
set_option autoImplicit false
noncomputable section
open scoped Matrix ComplexConjugate
namespace NLA.MI04

theorem basis_pair_extension {n : ℕ} (u v : Vec n) (hu : ‖u‖ = 1)
    (hv : ‖v‖ = 1) (huv : inner ℂ u v = 0) :
    ∃ b : OrthonormalBasis (Fin n) ℂ (Vec n), ∃ i j : Fin n,
      i ≠ j ∧ b i = u ∧ b j = v := by
  classical
  have hne : u ≠ v := by
    intro h
    have hz := huv
    rw [h, inner_self_eq_norm_sq_to_K, hv] at hz
    norm_num at hz
  have hpair : Orthonormal ℂ (![u,v] : Fin 2 → Vec n) := by
    rw [orthonormal_iff_ite]
    intro i j
    fin_cases i <;> fin_cases j
    · simp [inner_self_eq_norm_sq_to_K, hu]
    · simpa using huv
    · simpa only [Matrix.cons_val_one, Matrix.cons_val_zero, Fin.zero_eta,
        Fin.isValue, Matrix.head_cons, Fin.mk_one, one_ne_zero, ite_false]
        using (inner_eq_zero_symm.mp huv)
    · simp [inner_self_eq_norm_sq_to_K, hv]
  have hrange : Orthonormal ℂ ((↑) : Set.range (![u,v] : Fin 2 → Vec n) → Vec n) :=
    (orthonormal_subtype_range hpair.linearIndependent.injective).mpr hpair
  obtain ⟨s,b,hs,hb⟩ := hrange.exists_orthonormalBasis_extension
  have hus : u ∈ s := hs ⟨0, rfl⟩
  have hvs : v ∈ s := hs ⟨1, rfl⟩
  let e := b.toBasis.indexEquiv (EuclideanSpace.basisFun (Fin n) ℂ).toBasis
  refine ⟨b.reindex e, e ⟨u,hus⟩, e ⟨v,hvs⟩, ?_, ?_, ?_⟩
  · intro h
    exact hne (congrArg Subtype.val (e.injective h))
  · simpa using congrFun hb ⟨u,hus⟩
  · simpa using congrFun hb ⟨v,hvs⟩

theorem orthonormal_change_entry {n : ℕ} (X : Mat n)
    (b : OrthonormalBasis (Fin n) ℂ (Vec n)) (i j : Fin n) :
    let U := (EuclideanSpace.basisFun (Fin n) ℂ).toBasis.toMatrix b
    (Uᴴ * X * U) i j = inner ℂ (b i) (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) X (b j)) := by
  classical
  dsimp
  simp only [Matrix.mul_apply, Matrix.conjTranspose_apply, Module.Basis.toMatrix_apply,
    OrthonormalBasis.coe_toBasis_repr, OrthonormalBasis.repr_apply_apply]
  simp [EuclideanSpace.inner_single_left, EuclideanSpace.basisFun_apply,
    PiLp.inner_apply, Matrix.ofLp_toEuclideanCLM, Matrix.mulVec, dotProduct,
    Finset.mul_sum, Finset.sum_mul, mul_assoc]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro x _
  apply Finset.sum_congr rfl
  intro y _
  ring

theorem coordinate_symmetry_to_pair {n : ℕ} (X : Mat n)
    (h : ∀ U : Mat n, U ∈ Matrix.unitaryGroup (Fin n) ℂ →
      ∀ i j : Fin n, i ≠ j → ‖(Uᴴ * X * U) i j‖ = ‖(Uᴴ * X * U) j i‖) :
    PairModulusSymmetry X := by
  intro u v hu hv huv
  obtain ⟨b,i,j,hij,hi,hj⟩ := basis_pair_extension u v hu hv huv
  let U := (EuclideanSpace.basisFun (Fin n) ℂ).toBasis.toMatrix b
  have hh := h U ((EuclideanSpace.basisFun (Fin n) ℂ).toMatrix_orthonormalBasis_mem_unitary b) i j hij
  simpa [U, orthonormal_change_entry, hi, hj] using hh

end NLA.MI04
