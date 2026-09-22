/- Exact operator-norm bounds for MF-22. Formalization: Sidney Holden with Codex.
Standard finite Schur/Cauchy–Schwarz argument; Mathlib supplies the actual L2 norm. -/
import NLA.MF22.Definitions
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22

lemma spectral_norm_le_row_col {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℂ) (D : ℝ) (hD : 0 ≤ D)
    (hr : ∀ i, ∑ j, ‖A i j‖ ≤ D) (hc : ∀ j, ∑ i, ‖A i j‖ ≤ D) :
    ‖A‖ ≤ D := by
  change ‖Matrix.toEuclideanCLM (n := ι) (𝕜 := ℂ) A‖ ≤ D
  apply ContinuousLinearMap.opNorm_le_bound _ hD
  intro x
  apply (sq_le_sq₀ (norm_nonneg _) (mul_nonneg hD (norm_nonneg _))).mp
  rw [mul_pow, EuclideanSpace.norm_sq_eq, EuclideanSpace.norm_sq_eq]
  have hrow (i : ι) :
      ‖(A *ᵥ x) i‖ ^ 2 ≤ D * ∑ j, ‖A i j‖ * ‖x j‖ ^ 2 := by
    have ht : ‖(A *ᵥ x) i‖ ≤ ∑ j, ‖A i j‖ * ‖x j‖ := by
      simpa [Matrix.mulVec, dotProduct, norm_mul] using
        (norm_sum_le (Finset.univ : Finset ι) (fun j => A i j * x j))
    have hw := Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul (Finset.univ : Finset ι)
      (r := fun j => ‖A i j‖ * ‖x j‖)
      (f := fun j => ‖A i j‖) (g := fun j => ‖A i j‖ * ‖x j‖ ^ 2)
      (fun j _ => norm_nonneg _) (fun j _ => mul_nonneg (norm_nonneg _) (sq_nonneg _))
      (fun j _ => by ring_nf; exact le_rfl)
    calc
      ‖(A *ᵥ x) i‖ ^ 2 ≤ (∑ j, ‖A i j‖ * ‖x j‖) ^ 2 :=
        pow_le_pow_left₀ (norm_nonneg _) ht 2
      _ ≤ (∑ j, ‖A i j‖) * ∑ j, ‖A i j‖ * ‖x j‖ ^ 2 := hw
      _ ≤ D * ∑ j, ‖A i j‖ * ‖x j‖ ^ 2 :=
        mul_le_mul_of_nonneg_right (hr i) (Finset.sum_nonneg fun j _ => by positivity)
  change ∑ i, ‖(A *ᵥ x) i‖ ^ 2 ≤ D ^ 2 * ∑ i, ‖x i‖ ^ 2
  calc
    ∑ i, ‖(A *ᵥ x) i‖ ^ 2 ≤ ∑ i, D * ∑ j, ‖A i j‖ * ‖x j‖ ^ 2 :=
      Finset.sum_le_sum fun i _ => hrow i
    _ = D * ∑ j, (∑ i, ‖A i j‖) * ‖x j‖ ^ 2 := by
      rw [← Finset.mul_sum, Finset.sum_comm]; simp_rw [Finset.sum_mul]
    _ ≤ D * ∑ j, D * ‖x j‖ ^ 2 := by
      gcongr with j
      exact hc j
    _ = D ^ 2 * ∑ j, ‖x j‖ ^ 2 := by rw [← Finset.mul_sum]; ring

lemma spectral_norm_le_card_entry {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℂ) (C : ℝ) (hC : 0 ≤ C) (h : ∀ i j, ‖A i j‖ ≤ C) :
    ‖A‖ ≤ (Fintype.card ι : ℝ) * C := by
  apply spectral_norm_le_row_col A _ (by positivity)
  · intro i; simpa using Finset.sum_le_sum (s := Finset.univ) (fun j _ => h i j)
  · intro j; simpa using Finset.sum_le_sum (s := Finset.univ) (fun i _ => h i j)

lemma spectral_norm_le_sparse {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι ℂ) (C : ℝ) (hC : 0 ≤ C) (s : ℕ)
    (h : ∀ i j, ‖A i j‖ ≤ C)
    (hr : ∀ i, (Finset.univ.filter fun j => A i j ≠ 0).card ≤ s)
    (hc : ∀ j, (Finset.univ.filter fun i => A i j ≠ 0).card ≤ s) :
    ‖A‖ ≤ (s : ℝ) * C := by
  have hb (f : ι → ℂ) (hf : ∀ i, ‖f i‖ ≤ C)
      (hs : (Finset.univ.filter fun i => f i ≠ 0).card ≤ s) : ∑ i, ‖f i‖ ≤ s*C := by
    have he : ∑ i, ‖f i‖ = ∑ i ∈ Finset.univ.filter (fun i => f i ≠ 0), ‖f i‖ := by
      symm
      apply Finset.sum_subset (Finset.filter_subset _ _)
      intro i _ hi
      have : f i = 0 := by simpa using hi
      simp [this]
    rw [he]
    calc
      _ ≤ ∑ i ∈ Finset.univ.filter (fun i => f i ≠ 0), C := Finset.sum_le_sum fun i _ => hf i
      _ = ((Finset.univ.filter fun i => f i ≠ 0).card : ℝ)*C := by simp
      _ ≤ s*C := mul_le_mul_of_nonneg_right (by exact_mod_cast hs) hC
  exact spectral_norm_le_row_col A _ (by positivity)
    (fun i => hb (A i) (h i) (hr i))
    (fun j => hb (fun i => A i j) (fun i => h i j) (hc j))

#assert_trust kernel spectral_norm_le_row_col
end NLA.MF22
