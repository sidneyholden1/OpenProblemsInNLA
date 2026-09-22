import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.Probability.Independence.Basic
import Mathlib.MeasureTheory.Constructions.Pi

/-!
IE-04 statement draft only. Mathematical proof: George Stepaniants, California
Institute of Technology, 11 September 2026. Original conjecture: Spielman–Teng.
Prepared by Codex at Sidney Holden's request. No proof implementation yet.

The row-swap / padded-Schur convention follows the existing IE-05 formalization
(Sidney Holden, Codex assistance), but no theorem from that project is imported.
All pivot schedules are retained. Growth is an actual supremum of their actual
finite entry maxima, not a prescribed scalar recurrence. Noise is the complete
finite product of standard real Gaussian measures.
-/
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical NNReal
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
abbrev Schedule (n : ℕ) := Fin n → Fin n

/-- The ordinary finite product Borel measurable space on real entries. -/
instance (n : ℕ) : MeasurableSpace (Mat n) :=
  inferInstanceAs (MeasurableSpace (Fin n → Fin n → ℝ))

/-- Finite maximum of absolute entries; zero for an empty matrix. -/
def entryMax {n : ℕ} (A : Mat n) : ℝ :=
  ((Finset.univ.sup fun ij : Fin n × Fin n => ‖A ij.1 ij.2‖₊) : ℝ≥0)

/-- Swap the current row k with r, take the actual trailing Schur complement,
and pad discarded rows and columns with zeros. No column swap is performed. -/
def schurStep {n : ℕ} (A : Mat n) (k r : Fin n) : Mat n := fun i j =>
  if k < i ∧ k < j then
    A (Equiv.swap k r i) j - A (Equiv.swap k r i) k / A r k * A r j
  else 0

/-- Actual recursive states for a given schedule. State zero is the input;
the n states counted in growth are indexed 0,...,n-1. -/
def states {n : ℕ} (A : Mat n) (π : Schedule n) : ℕ → Mat n
  | 0 => A
  | k + 1 => if h : k < n then
      schurStep (states A π k) ⟨k,h⟩ (π ⟨k,h⟩) else 0

/-- Every largest-magnitude active-column choice, including ties, with an
explicit nonzero pivot at every stage. -/
def IsLegal {n : ℕ} (A : Mat n) (π : Schedule n) : Prop :=
  ∀ k : Fin n, k ≤ π k ∧ states A π k.val (π k) k ≠ 0 ∧
    ∀ i : Fin n, k ≤ i → |states A π k.val i k| ≤ |states A π k.val (π k) k|

/-- The first available row convention is an auxiliary deterministic selector;
it does not restrict the schedules used by the main growth definition. -/
def IsFirstLegal {n : ℕ} (A : Mat n) (π : Schedule n) : Prop :=
  IsLegal A π ∧ ∀ k i : Fin n, k ≤ i →
    |states A π k.val i k| = |states A π k.val (π k) k| → π k ≤ i

def pathGrowth {n : ℕ} (A : Mat n) (π : Schedule n) : ℝ :=
  (((Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
    ‖states A π kij.1.val kij.2.1 kij.2.2‖₊) : ℝ≥0) : ℝ) / entryMax A

def growthValues {n : ℕ} (A : Mat n) : Set ℝ :=
  {g | ∃ π : Schedule n, IsLegal A π ∧ g = pathGrowth A π}

/-- The full all-tie GEPP growth supremum. Its nonempty, finite, attained
maximum semantics for nonsingular inputs is an explicit Challenge obligation. -/
def ppGrowth {n : ℕ} (A : Mat n) : ℝ := sSup (growthValues A)

/-- Euclidean operator norm, explicitly independent of Matrix's default norm. -/
def spectralNorm {n : ℕ} (A : Mat n) : ℝ :=
  ‖Matrix.toEuclideanCLM (𝕜 := ℝ) (n := Fin n) A‖

/-- All n² entries are independent N(0,1); gaussianReal's second parameter is
variance. The nested Pi measure is on the complete real matrix space. -/
def gaussianMatrix (n : ℕ) : Measure (Mat n) :=
  Measure.pi fun _ : Fin n => Measure.pi fun _ : Fin n => gaussianReal 0 1

def perturb {n : ℕ} (center : Mat n) (σ : ℝ) (G : Mat n) : Mat n := center + σ • G

/-- A precise extension of the original event: singular matrices are omitted.
The Challenge requires they have Gaussian probability zero for every center
and every positive noise level, and that all pivot ties are null as well. -/
def tailEvent {n : ℕ} (center : Mat n) (σ t : ℝ) : Set (Mat n) :=
  {G | (perturb center σ G).det ≠ 0 ∧ t < ppGrowth (perturb center σ G)}

def tailProbability {n : ℕ} (center : Mat n) (σ t : ℝ) : ℝ :=
  (gaussianMatrix n).real (tailEvent center σ t)

/-- Complete canonical existential assertion with all real parameters and
unrestricted x≥1, arbitrary admissible deterministic centers, and every n≥1. -/
def ExponentialTailConjecture : Prop :=
  ∃ c₁ c₂ : ℝ, 0 < c₁ ∧ 0 < c₂ ∧
    ∀ n : ℕ, 1 ≤ n → ∀ center : Mat n, spectralNorm center ≤ 1 →
      ∀ σ : ℝ, 0 < σ → σ ≤ 1 → ∀ x : ℝ, 1 ≤ x →
        tailProbability center σ (x * Real.rpow ((n : ℝ) / σ) c₁) ≤
          Real.rpow 2 (-c₂ * x)

def wilkinson (n : ℕ) : Mat n := fun i j =>
  if j.val + 1 = n then 1 else if i = j then 1 else if j < i then -(1/2 : ℝ) else 0

def referenceStates (n k : ℕ) : Mat n := fun i j =>
  if k ≤ i.val ∧ k ≤ j.val then
    if j.val + 1 = n then (3/2 : ℝ)^k
    else if i = j then 1 else if j < i then -(1/2 : ℝ) else 0
  else 0

def highGrowth (n : ℕ) : ℝ := (3/2 : ℝ)^(n-1)
def amplification (n : ℕ) : ℝ := (2 : ℝ)^(n+2)
def boxRadius (n : ℕ) : ℝ := 1 / (2 : ℝ)^(n^2+n+1)
def exponentCost (n : ℕ) : ℕ := n^2 * (n^2+n+5)
def inputBox (n : ℕ) : Set (Mat n) :=
  {A | ∀ i j, |A i j - wilkinson n i j| ≤ boxRadius n}
def noiseBox (n : ℕ) : Set (Mat n) :=
  {G | perturb (1 : Mat n) 1 G ∈ inputBox n}
def threshold (n : ℕ) (c₁ : ℝ) : ℝ := highGrowth n / (2 * Real.rpow n c₁)

end NLA.IE04
