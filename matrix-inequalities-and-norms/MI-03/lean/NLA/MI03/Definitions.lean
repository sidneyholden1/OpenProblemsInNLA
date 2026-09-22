/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance.
Mathematical argument: Matthew J. Colbrook; original question: Bourin and Lee.
This file is the proof-independent mathematical statement boundary.
-/
import Mathlib.Analysis.Matrix.Order
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Order
import Mathlib.LinearAlgebra.Matrix.Notation

set_option autoImplicit false
open scoped BigOperators Classical ComplexOrder MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MI03

/-- The positive matrix square root of the actual Gram matrix. -/
def modulus {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  CFC.abs A

/-- Nonnegative dimension-independent constants for arbitrary complex square
contractions. The norm is Mathlib's Euclidean operator norm, not an entry norm;
the order is positive-semidefinite matrix order, not entrywise order. -/
def admissible (k : ℕ) (c : ℝ) : Prop :=
  0 ≤ c ∧ ∀ n : ℕ, 1 ≤ n → ∀ A : Fin k → Matrix (Fin n) (Fin n) ℂ,
    (∀ j, ‖A j‖ ≤ 1) → modulus (∑ j, A j) ≤ c • (1 : Matrix (Fin n) (Fin n) ℂ) + ∑ j, modulus (A j)

/-- The literal real infimum in the original target. Nonemptiness and lower
boundedness of its defining set are independently advertised theorem claims. -/
def bestConstant (k : ℕ) : ℝ := sInf {c : ℝ | admissible k c}

/-- Source sharpness matrix difference, with real diagonal entries. -/
def sharpGap (k : ℕ) : Matrix (Fin 2) (Fin 2) ℂ :=
  Matrix.diagonal (![((k : ℝ) / 4 : ℂ), (-3 * (k : ℝ) / 4 : ℂ)] : Fin 2 → ℂ)

/-- The complete retained odd-summand question. -/
def oddSharpConstantConjecture : Prop :=
  ∀ k : ℕ, 3 ≤ k → Odd k → bestConstant k = (k : ℝ) / 4

end NLA.MI03
