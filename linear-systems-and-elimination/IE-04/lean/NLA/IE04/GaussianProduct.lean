import NLA.IE04.GaussianBox
import NLA.IE04.Robustness
set_option autoImplicit false
set_option backward.isDefEq.respectTransparency false
noncomputable section
open scoped BigOperators
open MeasureTheory ProbabilityTheory
namespace NLA.IE04
lemma noiseBox_rectangle (n : ℕ) : noiseBox n =
    Set.univ.pi (fun i : Fin n => Set.univ.pi (fun j : Fin n =>
      Set.Icc (wilkinson n i j - (1 : Mat n) i j - boxRadius n)
        (wilkinson n i j - (1 : Mat n) i j + boxRadius n))) := by
  ext G
  change (∀ i j, |((1 : Mat n) + (1 : ℝ) • G) i j - wilkinson n i j| ≤ boxRadius n) ↔ (∀ i : Fin n, i ∈ Set.univ → ∀ j : Fin n, j ∈ Set.univ → wilkinson n i j - (1 : Mat n) i j - boxRadius n ≤ G i j ∧ G i j ≤ wilkinson n i j - (1 : Mat n) i j + boxRadius n)
  simp only [Set.mem_pi, Set.mem_univ, forall_true_left, Set.mem_Icc, Matrix.add_apply,
    Matrix.smul_apply, one_smul, abs_le]
  constructor <;> intro h i j <;> obtain ⟨h1,h2⟩ := h i j <;> constructor <;> linarith
lemma noiseBox_measurable (n : ℕ) : MeasurableSet (noiseBox n) := by
  rw [noiseBox_rectangle]
  exact MeasurableSet.univ_pi (fun _ => MeasurableSet.univ_pi (fun _ => measurableSet_Icc))
lemma noiseBox_measure_product (n : ℕ) : (gaussianMatrix n).real (noiseBox n) =
    ∏ i : Fin n, ∏ j : Fin n, (gaussianReal 0 1).real
      (Set.Icc (wilkinson n i j - (1 : Mat n) i j - boxRadius n)
        (wilkinson n i j - (1 : Mat n) i j + boxRadius n)) := by
  rw [noiseBox_rectangle]
  change ((Measure.pi (fun _ : Fin n => Measure.pi (fun _ : Fin n => gaussianReal 0 1)))
    (Set.univ.pi (fun i : Fin n => Set.univ.pi (fun j : Fin n => _)))).toReal = _
  simp only [Measure.pi_pi, ENNReal.toReal_prod, Measure.real]
lemma noise_center_bounds (n : ℕ) (i j : Fin n) :
    -1 ≤ wilkinson n i j - (1 : Mat n) i j ∧ wilkinson n i j - (1 : Mat n) i j ≤ 1 := by
  simp only [wilkinson, Matrix.one_apply]
  split_ifs <;> norm_num
lemma noiseBox_measure_lower (n : ℕ) (hn : 2 ≤ n) :
    (boxRadius n / 16)^(n*n) ≤ (gaussianMatrix n).real (noiseBox n) := by
  rw [noiseBox_measure_product]
  have he : (boxRadius n/16)^(n*n) = ∏ _i : Fin n, ∏ _j : Fin n, boxRadius n/16 := by
    simp only [Finset.prod_const, Finset.card_univ, Fintype.card_fin, pow_mul]
  rw [he]
  apply Finset.prod_le_prod (fun _ _ => by
    apply Finset.prod_nonneg
    intro _ _
    exact div_nonneg (boxRadius_pos n).le (by norm_num))
  intro i _
  apply Finset.prod_le_prod (fun _ _ => div_nonneg (boxRadius_pos n).le (by norm_num))
  intro j _
  have hc := noise_center_bounds n i j
  have hr := boxRadius_le_eighth n (by omega)
  exact gaussian_interval_lower _ _ (boxRadius_pos n).le (by linarith) (by linarith)
lemma gaussian_box_lower_proved (n : ℕ) (hn : 2 ≤ n) :
    MeasurableSet (noiseBox n) ∧
    Real.rpow 2 (-(exponentCost n : ℝ)) ≤ (gaussianMatrix n).real (noiseBox n) := by
  refine ⟨noiseBox_measurable n, ?_⟩
  have hr : boxRadius n / 16 = ((2 : ℝ)^(n^2+n+5))⁻¹ := by
    unfold boxRadius
    have he : n^2+n+5 = (n^2+n+1)+4 := by omega
    rw [he, pow_add]
    norm_num
    ring
  have he : Real.rpow 2 (-(exponentCost n : ℝ)) = (boxRadius n/16)^(n*n) := by
    simp only [Real.rpow_eq_pow]
    rw [Real.rpow_neg (by norm_num), Real.rpow_natCast, hr, inv_pow, ← pow_mul]
    congr 2
    unfold exponentCost
    ring
  rw [he]
  exact noiseBox_measure_lower n hn
end NLA.IE04
