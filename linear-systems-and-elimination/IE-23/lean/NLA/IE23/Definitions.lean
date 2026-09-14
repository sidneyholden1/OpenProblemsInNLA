/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance

Proof-independent boundary for Matthew J. Colbrook's IE-23 counterexample.
-/
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Complex.Basic

set_option autoImplicit false
open scoped BigOperators
noncomputable section
namespace NLA.IE23

/-- The Euclidean norm, with complex coordinate magnitudes. -/
def euclideanNorm {n : ℕ} (v : Fin n → ℂ) : ℝ :=
  Real.sqrt (∑ i, ‖v i‖ ^ 2)

/-- The ordinary finite p-norm for a real exponent p>2. -/
def pNorm {m : ℕ} (p : ℝ) (v : Fin m → ℂ) : ℝ :=
  (∑ i, ‖v i‖ ^ p) ^ (1 / p)

/-- The exact set of amplification ratios over all nonzero complex vectors. -/
def ratios {n m : ℕ} (p : ℝ) (X : Matrix (Fin n) (Fin m) ℂ) : Set ℝ :=
  {r | ∃ v : Fin m → ℂ, v ≠ 0 ∧ r = euclideanNorm (X.mulVec v) / pNorm p v}

/-- The induced p-to-2 norm in the canonical question. Witness proofs establish
nonemptiness and boundedness of the ratio sets before using this supremum. -/
def inducedNorm {n m : ℕ} (p : ℝ) (X : Matrix (Fin n) (Fin m) ℂ) : ℝ :=
  sSup (ratios p X)

/-- Full row rank, expressed equivalently as surjectivity of the actual matrix map. -/
def FullRowRank {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : Prop :=
  Function.Surjective A.mulVec

/-- The canonical full-row-rank Moore–Penrose formula with conjugate transpose
and the actual square-matrix inverse. -/
def pseudoInverse {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    Matrix (Fin n) (Fin m) ℂ := A.conjTranspose * (A * A.conjTranspose)⁻¹

/-- Complete canonical uniqueness implication for complex inputs and every
finite real exponent p>2. -/
def UniquenessConjecture : Prop :=
  ∀ m n : ℕ, 1 ≤ m → m < n → ∀ A : Matrix (Fin m) (Fin n) ℂ,
    FullRowRank A → ∀ p : ℝ, 2 < p → ∀ X : Matrix (Fin n) (Fin m) ℂ,
      A * X = 1 → X ≠ pseudoInverse A →
      inducedNorm p (pseudoInverse A) < inducedNorm p X

def witnessA : Matrix (Fin 2) (Fin 3) ℂ := !![1, 1, 0; 1, 0, 1]
def witnessB : Matrix (Fin 3) (Fin 2) ℂ :=
  !![1/3, 1/3; 2/3, -1/3; -1/3, 2/3]
def witnessX : Matrix (Fin 3) (Fin 2) ℂ := !![0, 0; 1, 0; 0, 1]

end NLA.IE23
