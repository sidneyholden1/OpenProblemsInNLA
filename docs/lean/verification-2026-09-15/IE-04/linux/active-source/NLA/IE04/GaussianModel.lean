import Mathlib
import NLA.IE04.Definitions
set_option autoImplicit false
set_option backward.isDefEq.respectTransparency false
noncomputable section
open scoped BigOperators
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

instance gaussianMatrix_probability (n : ℕ) : IsProbabilityMeasure (gaussianMatrix n) := by
  change IsProbabilityMeasure (Measure.pi (fun _ : Fin n => Measure.pi (fun _ : Fin n => gaussianReal 0 1)))
  infer_instance

lemma gaussian_entry_map (n : ℕ) (i j : Fin n) :
    (gaussianMatrix n).map (fun G => G i j) = gaussianReal 0 1 := by
  exact ((measurePreserving_eval (fun _ : Fin n => gaussianReal 0 1) j).comp
    (measurePreserving_eval (fun _ : Fin n => Measure.pi (fun _ : Fin n => gaussianReal 0 1)) i)).map_eq

lemma gaussian_flatten_map (n : ℕ) :
    (gaussianMatrix n).map (fun G : Mat n => fun ij : Fin n × Fin n => G ij.1 ij.2) =
      Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1) := by
  apply (Measure.pi_eq _).symm
  intro s hs
  rw [Measure.map_apply (by fun_prop) (MeasurableSet.univ_pi hs)]
  have he : (fun G : Mat n => fun ij : Fin n × Fin n => G ij.1 ij.2) ⁻¹' Set.univ.pi s =
      Set.univ.pi (fun i : Fin n => Set.univ.pi (fun j : Fin n => s (i,j))) := by
    ext G
    change (∀ ij, ij ∈ Set.univ → G ij.1 ij.2 ∈ s ij) ↔ (∀ i, i ∈ Set.univ → ∀ j, j ∈ Set.univ → G i j ∈ s (i,j))
    simp
  rw [he]
  change (Measure.pi (fun _ : Fin n => Measure.pi (fun _ : Fin n => gaussianReal 0 1))) (Set.univ.pi (fun i : Fin n => Set.univ.pi (fun j : Fin n => s (i,j)))) = _
  simp only [Measure.pi_pi]
  exact (Finset.prod_product Finset.univ Finset.univ (fun ij : Fin n × Fin n => (gaussianReal 0 1) (s ij))).symm

lemma gaussian_model_proved (n : ℕ) :
    IsProbabilityMeasure (gaussianMatrix n) ∧
    iIndepFun (fun ij : Fin n × Fin n => fun G : Mat n => G ij.1 ij.2) (gaussianMatrix n) ∧
    (∀ i j : Fin n, (gaussianMatrix n).map (fun G => G i j) = gaussianReal 0 1) := by
  refine ⟨inferInstance,?_,gaussian_entry_map n⟩
  apply (iIndepFun_iff_map_fun_eq_pi_map (f := fun ij : Fin n × Fin n => fun G : Mat n => G ij.1 ij.2) (μ := gaussianMatrix n) (fun ij => (by fun_prop : Measurable (fun G : Mat n => G ij.1 ij.2)).aemeasurable)).mpr
  simpa only [gaussian_entry_map] using gaussian_flatten_map n

end NLA.IE04
