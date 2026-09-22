/- MF-12 proof-independent statements. Source mathematics: Matthew J. Colbrook.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Topology.Order.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12
abbrev Mat (d : ℕ) := Matrix (Fin d) (Fin d) ℝ

/-- Products are in list order. Since every word is allowed, reversing every
word gives the A_k ⋯ A_1 convention of the canonical statement. -/
def wordProduct {d k : ℕ} (w : Fin k → Mat d) : Mat d := (List.ofFn w).prod

/-- All actual spectral norms of all words of exactly the given length. -/
def productNorms {d : ℕ} (M : Set (Mat d)) (k : ℕ) : Set ℝ :=
  {t | ∃ w : Fin k → Mat d, (∀ i, w i ∈ M) ∧ t = ‖wordProduct w‖}

def maximalProductNorm {d : ℕ} (M : Set (Mat d)) (k : ℕ) : ℝ :=
  sSup (productNorms M k)

/-- Full growth contract, with attained genuine maxima and the actual
nth-root limit equal to one, the joint spectral radius. -/
def RealizesExponent {d : ℕ} (M : Set (Mat d)) (γ : ℝ) : Prop :=
  M.Finite ∧ M.Nonempty ∧ ∃ c C : ℝ, 0 < c ∧ c ≤ C ∧
    (∀ k : ℕ, 1 ≤ k →
      IsGreatest (productNorms M k) (maximalProductNorm M k) ∧
      c * (k : ℝ) ^ γ ≤ maximalProductNorm M k ∧
      maximalProductNorm M k ≤ C * (k : ℝ) ^ γ) ∧
    Filter.Tendsto (fun k : ℕ => (maximalProductNorm M k) ^ (1 / (k : ℝ)))
      Filter.atTop (nhds 1)

/-- Source six-dimensional generator with λ=1/4. -/
def seed (μ : ℝ) : Mat 6 := !![
  1,0,0,0,0,0;
  0,1/4,1/4,0,0,0;
  0,0,1/4,0,0,0;
  0,0,0,μ,μ,0;
  0,0,0,0,μ,0;
  0,0,0,0,0,1]
def reset : Mat 6 := !![
  1,-1,0,1,0,0;
  0,0,0,0,0,0;
  1,-1,0,1,0,0;
  0,0,0,0,0,0;
  0,0,0,0,0,1;
  0,0,0,0,0,1]
def compressU : Matrix (Fin 2) (Fin 6) ℝ := !![1,-1,0,1,0,0;0,0,0,0,0,1]
def embedV : Matrix (Fin 6) (Fin 2) ℝ := !![1,0;0,0;1,0;0,0;0,1;0,1]
def fractionalParameter (α : ℝ) : ℝ := (4 : ℝ) ^ (α-1)
end NLA.MF12
