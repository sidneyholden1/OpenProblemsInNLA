/- Bounded stable remainder in the exact four-mode decomposition.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.SpectralAdjugate
set_option autoImplicit false
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF22

lemma basis_bounded_remainder (T : FourMat) (ev : Fin 4 → ℂ)
    (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ))
    (he : ∀ i, T *ᵥ b i=ev i • b i) (hn : ∀ i, i ≠ 0 → ‖ev i‖ ≤ 1) :
    ∃ R : ℕ → FourMat, ∃ C : ℝ, 0<C ∧
      (∀ k, T^k=ev 0^k • basisProjector b 0+R k) ∧
      ∀ k i j, ‖R k i j‖ ≤ C := by
  classical
  let R : ℕ → FourMat := fun k i j =>
    ∑ a ∈ Finset.univ.erase 0, ev a^k*basisProjector b a i j
  let C : ℝ := 1+∑ a : Fin 4, ∑ i : Fin 4, ∑ j : Fin 4, ‖basisProjector b a i j‖
  have hc : 0<C := by dsimp [C]; positivity
  refine ⟨R,C,hc,?_,?_⟩
  · intro k
    ext i j
    rw [basis_power_entries T ev b he]
    simp only [Matrix.add_apply,Matrix.smul_apply,smul_eq_mul,R]
    exact (Finset.add_sum_erase _ _ (Finset.mem_univ 0)).symm
  · intro k i j
    change ‖∑ a ∈ Finset.univ.erase 0, ev a^k*basisProjector b a i j‖ ≤ C
    calc
      _ ≤ ∑ a ∈ Finset.univ.erase 0, ‖ev a^k*basisProjector b a i j‖ := norm_sum_le _ _
      _ ≤ ∑ a ∈ Finset.univ.erase 0, ‖basisProjector b a i j‖ := by
        apply Finset.sum_le_sum
        intro a ha
        rw [norm_mul,norm_pow]
        exact mul_le_of_le_one_left (norm_nonneg _) (pow_le_one₀ (norm_nonneg _) (hn a (Finset.mem_erase.mp ha).1))
      _ ≤ ∑ a : Fin 4, ‖basisProjector b a i j‖ := by
        exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.erase_subset _ _) (by intros; positivity)
      _ ≤ ∑ a : Fin 4, ∑ i : Fin 4, ∑ j : Fin 4, ‖basisProjector b a i j‖ := by
        apply Finset.sum_le_sum
        intro a _
        calc
          _ ≤ ∑ jj : Fin 4, ‖basisProjector b a i jj‖ := Finset.single_le_sum (f := fun jj : Fin 4 => ‖basisProjector b a i jj‖) (by intros; positivity) (Finset.mem_univ j)
          _ ≤ ∑ ii : Fin 4, ∑ jj : Fin 4, ‖basisProjector b a ii jj‖ := Finset.single_le_sum (f := fun ii : Fin 4 => ∑ jj : Fin 4, ‖basisProjector b a ii jj‖) (by intros; positivity) (Finset.mem_univ i)
      _ ≤ C := by dsimp [C]; linarith
end NLA.MF22
