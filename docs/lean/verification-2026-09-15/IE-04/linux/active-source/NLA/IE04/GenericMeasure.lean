import NLA.IE04.Generic
import NLA.IE04.GaussianModel

/-! Transfer the checked finite-coordinate genericity result to the actual
nested matrix Gaussian law used in the frozen statement. -/
set_option autoImplicit false
noncomputable section
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

lemma gaussian_generic_proved {n : ℕ} (_hn : 1 ≤ n) (center : Mat n) (σ : ℝ) (hσ : 0 < σ) :
    ∀ᵐ G ∂gaussianMatrix n,
      (perturb center σ G).det ≠ 0 ∧ ∃! π : Schedule n, IsLegal (perturb center σ G) π := by
  have h := gaussian_generic_flat center σ hσ
  rw [← gaussian_flatten_map n] at h
  have hh := ae_of_ae_map
    (f := fun G : Mat n => fun ij : Fin n × Fin n => G ij.1 ij.2)
    (by exact (by fun_prop : Measurable (fun G : Mat n => fun ij : Fin n × Fin n => G ij.1 ij.2)).aemeasurable) h
  exact hh

end NLA.IE04
