/- IS-02: the original spectral-uniqueness locus conjecture.
Mathematical counterexample: Matthew J. Colbrook. Formalization: Sidney Holden
with OpenAI Codex assistance. Apache 2.0. -/
import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.Matrix.Charpoly.Coeff
import Mathlib.Analysis.Convex.Extreme
import Mathlib.LinearAlgebra.Matrix.Notation
set_option autoImplicit false
open scoped BigOperators Matrix
noncomputable section
namespace NLA.IS02

/-- Real symmetric, entrywise nonnegative, row-stochastic matrices. Symmetry
also forces column sums one. -/
def stochasticSet (n : ℕ) : Set (Matrix (Fin n) (Fin n) ℝ) :=
  {A | Aᵀ = A ∧ (∀ i j, 0 ≤ A i j) ∧ ∀ i, ∑ j, A i j = 1}

/-- Simultaneous permutation of rows and columns, i.e. permutation similarity. -/
def permSimilar {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∃ σ : Equiv.Perm (Fin n), B = A.submatrix σ σ

/-- Characteristic-polynomial equality records all eigenvalues with their
algebraic multiplicities. There is no restriction on the competing input B. -/
def spectrallyUnique {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∀ B ∈ stochasticSet n, B.charpoly = A.charpoly → permSimilar A B

def center (n : ℕ) : Matrix (Fin n) (Fin n) ℝ :=
  fun i j => if i=j then 0 else 1 / ((n : ℝ)-1)

/-- Actual closed real line segments and actual extreme points of the whole
symmetric stochastic polytope. Vertices are not restricted to permutations. -/
def proposedLocus (n : ℕ) : Set (Matrix (Fin n) (Fin n) ℝ) :=
  segment ℝ 1 (center n) ∪
    {A | ∃ V ∈ (stochasticSet n).extremePoints ℝ,
      A ∈ segment ℝ 1 V ∪ segment ℝ (center n) V}

def LocusConjecture : Prop :=
  ∀ n : ℕ, 4 ≤ n → ∀ A ∈ stochasticSet n,
    spectrallyUnique A → 0 < Matrix.trace A → A ∈ proposedLocus n

def witness : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0,1,0,0; 1,0,0,0; 0,0,1/2,1/2; 0,0,1/2,1/2]

def endpointLeft : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0,1,0,0; 1,0,0,0; 0,0,1,0; 0,0,0,1]
def endpointRight : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0,1,0,0; 1,0,0,0; 0,0,0,1; 0,0,1,0]
end NLA.IS02
