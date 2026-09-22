import NLA.IE04.Tail
import NLA.IE04.GenericMeasure
import NLA.IE04.Measurability
import NLA.IE04.GaussianBounds
import LeanCert.Tactic.Verification

/-! Exact exports of the independently reviewed IE-04 statements.
Mathematical source: George Stepaniants. Formalization: Sidney Holden with Codex assistance. -/
set_option autoImplicit false
set_option leancert.trust "kernel"
noncomputable section
open scoped BigOperators Classical NNReal
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

theorem gaussian_model (n : ℕ) :
    IsProbabilityMeasure (gaussianMatrix n) ∧
    iIndepFun (fun ij : Fin n × Fin n => fun G : Mat n => G ij.1 ij.2) (gaussianMatrix n) ∧
    (∀ i j : Fin n, (gaussianMatrix n).map (fun G => G i j) = gaussianReal 0 1) := by
  exact gaussian_model_proved n

theorem growth_semantics {n : ℕ} (hn : 1 ≤ n) (A : Mat n) (hA : A.det ≠ 0) :
    0 < entryMax A ∧ (growthValues A).Nonempty ∧ (growthValues A).Finite ∧
    BddAbove (growthValues A) ∧ IsGreatest (growthValues A) (ppGrowth A) ∧
    1 ≤ ppGrowth A ∧ (∃! π : Schedule n, IsFirstLegal A π) ∧
    (∀ t : ℝ, t < ppGrowth A ↔ ∃ π : Schedule n, IsLegal A π ∧ t < pathGrowth A π) := by
  exact growth_semantics_proved hn A hA

/-- For every Gaussian-smoothed center, including singular deterministic centers,
the extension at singular inputs and convention on ties are probability-null. -/
theorem gaussian_generic {n : ℕ} (hn : 1 ≤ n) (center : Mat n) (σ : ℝ) (hσ : 0 < σ) :
    ∀ᵐ G ∂gaussianMatrix n,
      (perturb center σ G).det ≠ 0 ∧ ∃! π : Schedule n, IsLegal (perturb center σ G) π := by
  exact gaussian_generic_proved hn center σ hσ

theorem measurable_tail {n : ℕ} (center : Mat n) (σ t : ℝ) :
    MeasurableSet (tailEvent center σ t) := by
  exact measurable_tail_proved center σ t

theorem exact_wilkinson (n : ℕ) (hn : 2 ≤ n) :
    (wilkinson n).det ≠ 0 ∧ entryMax (wilkinson n) = 1 ∧
    IsLegal (wilkinson n) id ∧
    (∀ π : Schedule n, IsLegal (wilkinson n) π → π = id) ∧
    (∀ k : ℕ, k ≤ n → states (wilkinson n) id k = referenceStates n k) ∧
    ppGrowth (wilkinson n) = highGrowth n ∧
    amplification n ^ (n-1) * boxRadius n = 1/8 ∧
    exponentCost n ≤ 3 * n^4 := by
  exact exact_wilkinson_proved n hn

/-- The entire closed box in all n² real entries, for every n≥2. -/
theorem full_box_robustness (n : ℕ) (hn : 2 ≤ n) (A : Mat n) (hA : A ∈ inputBox n) :
    A.det ≠ 0 ∧ IsLegal A id ∧
    (∀ π : Schedule n, IsLegal A π → π = id) ∧
    (∀ k : Fin n, ∀ i : Fin n, k < i →
      |states A id k.val i k| < |states A id k.val k k|) ∧
    (∀ k : ℕ, k < n →
      entryMax (states A id k - referenceStates n k) ≤ amplification n ^ k * boxRadius n) ∧
    highGrowth n / 2 < ppGrowth A := by
  exact full_box_robustness_proved n hn A hA

/-- A material density bound on the whole scalar interval, for the actual
standard Gaussian density. It must not be replaced by a sampled grid. -/
theorem gaussian_density_lower (x : ℝ) (hx : x ∈ Set.Icc (-2 : ℝ) 2) :
    (1/32 : ℝ) < gaussianPDFReal 0 1 x := by
  exact gaussian_density_lower_proved x hx

theorem gaussian_box_lower (n : ℕ) (hn : 2 ≤ n) :
    MeasurableSet (noiseBox n) ∧
    Real.rpow 2 (-(exponentCost n : ℝ)) ≤ (gaussianMatrix n).real (noiseBox n) := by
  exact gaussian_box_lower_proved n hn

theorem gaussian_tail_lower (n : ℕ) (hn : 2 ≤ n) :
    Real.rpow 2 (-(exponentCost n : ℝ)) ≤
      tailProbability (1 : Mat n) 1 (highGrowth n / 2) := by
  exact gaussian_tail_lower_proved n hn

theorem asymptotic_escape (c₁ c₂ : ℝ) (h₁ : 0 < c₁) (h₂ : 0 < c₂) :
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
      2 ≤ n ∧ 1 ≤ threshold n c₁ ∧ (exponentCost n : ℝ) < c₂ * threshold n c₁ := by
  exact asymptotic_escape_proved c₁ c₂ h₁ h₂

theorem every_pair_violated (c₁ c₂ : ℝ) (h₁ : 0 < c₁) (h₂ : 0 < c₂) :
    ∃ n : ℕ, 2 ≤ n ∧ spectralNorm (1 : Mat n) = 1 ∧ 1 ≤ threshold n c₁ ∧
      Real.rpow 2 (-c₂ * threshold n c₁) <
        tailProbability (1 : Mat n) 1 (threshold n c₁ * Real.rpow n c₁) := by
  exact every_pair_violated_proved c₁ c₂ h₁ h₂

theorem not_exponentialTailConjecture : ¬ ExponentialTailConjecture := by
  exact not_exponentialTailConjecture_proved

#assert_trust kernel gaussian_model
#assert_trust kernel growth_semantics
#assert_trust kernel gaussian_generic
#assert_trust kernel measurable_tail
#assert_trust kernel exact_wilkinson
#assert_trust kernel full_box_robustness
#assert_trust kernel gaussian_density_lower
#assert_trust kernel gaussian_box_lower
#assert_trust kernel gaussian_tail_lower
#assert_trust kernel asymptotic_escape
#assert_trust kernel every_pair_violated
#assert_trust kernel not_exponentialTailConjecture

end NLA.IE04
