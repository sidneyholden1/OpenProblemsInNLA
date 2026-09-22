/- Uniform spectral norm from the exact finite band, no boundary correction. -/
import NLA.MF22.NormBounds
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22

def blockEntry (ρ : ℝ) (l : ℤ) (a b : Fin 2) : ℂ :=
  Complex.I * B l a b - (ρ : ℂ) * C l a b

def coefficientBound (ρ : ℝ) : ℝ :=
  1 + ∑ l ∈ Finset.Icc (-1 : ℤ) 2, ∑ a : Fin 2, ∑ b : Fin 2, ‖blockEntry ρ l a b‖

lemma coefficientBound_pos (ρ : ℝ) : 0 < coefficientBound ρ := by
  unfold coefficientBound
  positivity

lemma H_support {ρ : ℝ} {n : ℕ} {j k : Ix n} (h : H ρ n j k ≠ 0) :
    -1 ≤ (j.1.val : ℤ) - k.1.val ∧ (j.1.val : ℤ) - k.1.val ≤ 2 := by
  by_contra hbad
  have h1 : (j.1.val : ℤ)-k.1.val ≠ -1 := by omega
  have h2 : (j.1.val : ℤ)-k.1.val ≠ 0 := by omega
  have h3 : (j.1.val : ℤ)-k.1.val ≠ 1 := by omega
  have h4 : (j.1.val : ℤ)-k.1.val ≠ 2 := by omega
  simp [H,B,C,h1,h2,h3,h4] at h

lemma H_entry_bound (ρ : ℝ) (n : ℕ) (j k : Ix n) :
    ‖H ρ n j k‖ ≤ coefficientBound ρ := by
  by_cases hz : H ρ n j k = 0
  · rw [hz,norm_zero]; exact (coefficientBound_pos ρ).le
  have hm : (j.1.val : ℤ)-k.1.val ∈ Finset.Icc (-1 : ℤ) 2 := Finset.mem_Icc.mpr (H_support hz)
  have h1 := Finset.single_le_sum (fun b (_ : b ∈ (Finset.univ : Finset (Fin 2))) =>
    norm_nonneg (blockEntry ρ ((j.1.val : ℤ)-k.1.val) j.2 b)) (Finset.mem_univ k.2)
  have h2 : (∑ b : Fin 2, ‖blockEntry ρ ((j.1.val : ℤ)-k.1.val) j.2 b‖) ≤
      ∑ a : Fin 2, ∑ b : Fin 2, ‖blockEntry ρ ((j.1.val : ℤ)-k.1.val) a b‖ :=
    Finset.single_le_sum (fun a _ => Finset.sum_nonneg fun b _ => norm_nonneg _) (Finset.mem_univ j.2)
  have h3 : (∑ a : Fin 2, ∑ b : Fin 2, ‖blockEntry ρ ((j.1.val : ℤ)-k.1.val) a b‖) ≤
      ∑ l ∈ Finset.Icc (-1 : ℤ) 2, ∑ a : Fin 2, ∑ b : Fin 2, ‖blockEntry ρ l a b‖ :=
    Finset.single_le_sum (fun l _ => Finset.sum_nonneg fun a _ =>
      Finset.sum_nonneg fun b _ => norm_nonneg _) hm
  have he : H ρ n j k = blockEntry ρ ((j.1.val : ℤ)-k.1.val) j.2 k.2 := rfl
  rw [he]
  unfold coefficientBound
  linarith [h1.trans (h2.trans h3)]

lemma H_row_card (ρ : ℝ) (n : ℕ) (j : Ix n) :
    (Finset.univ.filter fun k => H ρ n j k ≠ 0).card ≤ 8 := by
  let f : Ix n → ℤ × Fin 2 := fun k => ((j.1.val : ℤ)-k.1.val,k.2)
  have hc := Finset.card_le_card_of_injOn f
    (s := Finset.univ.filter fun k => H ρ n j k ≠ 0)
    (t := Finset.Icc (-1 : ℤ) 2 ×ˢ (Finset.univ : Finset (Fin 2)))
    (by intro k hk; exact Finset.mem_product.mpr ⟨Finset.mem_Icc.mpr (H_support (Finset.mem_filter.mp hk).2), Finset.mem_univ _⟩)
    (by
      intro a ha b hb hab
      have he := congrArg Prod.fst hab
      have h2 := congrArg Prod.snd hab
      apply Prod.ext
      · apply Fin.ext; dsimp [f] at he; omega
      · exact h2)
  norm_num at hc
  exact hc

lemma H_col_card (ρ : ℝ) (n : ℕ) (k : Ix n) :
    (Finset.univ.filter fun j => H ρ n j k ≠ 0).card ≤ 8 := by
  let f : Ix n → ℤ × Fin 2 := fun j => ((j.1.val : ℤ)-k.1.val,j.2)
  have hc := Finset.card_le_card_of_injOn f
    (s := Finset.univ.filter fun j => H ρ n j k ≠ 0)
    (t := Finset.Icc (-1 : ℤ) 2 ×ˢ (Finset.univ : Finset (Fin 2)))
    (by intro j hj; exact Finset.mem_product.mpr ⟨Finset.mem_Icc.mpr (H_support (Finset.mem_filter.mp hj).2), Finset.mem_univ _⟩)
    (by
      intro a ha b hb hab
      have he := congrArg Prod.fst hab
      have h2 := congrArg Prod.snd hab
      apply Prod.ext
      · apply Fin.ext; dsimp [f] at he; omega
      · exact h2)
  norm_num at hc
  exact hc

lemma uniform_norm_bound_proved (ρ : ℝ) (_hρ : 0 < ρ) :
    ∃ D : ℝ, 0 < D ∧ ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D := by
  refine ⟨8 * coefficientBound ρ, mul_pos (by norm_num) (coefficientBound_pos ρ), ?_⟩
  intro n _
  exact spectral_norm_le_sparse (H ρ n) (coefficientBound ρ) (coefficientBound_pos ρ).le 8
    (H_entry_bound ρ n) (H_row_card ρ n) (H_col_card ρ n)

#assert_trust kernel uniform_norm_bound_proved
end NLA.MF22
