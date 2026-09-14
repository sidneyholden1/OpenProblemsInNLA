/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance

Formalization of Matthew J. Colbrook's IV-06 counterexample.
Proof-independent mathematical definitions.
-/
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Topology.Connected.Basic
import Mathlib.Data.Set.Card
import Mathlib.Topology.Instances.Real.Lemmas

set_option autoImplicit false
noncomputable section
namespace NLA.IV06

/-- Each matrix entry varies independently in its closed real interval. -/
def intervalFamily {n : ℕ} (L U : Matrix (Fin n) (Fin n) ℝ) :
    Set (Matrix (Fin n) (Fin n) ℝ) := {A | ∀ i j, L i j ≤ A i j ∧ A i j ≤ U i j}

/-- Real eigenvalues, defined by actual nonzero real eigenvectors. -/
def realEigenvalueSet {n : ℕ} (L U : Matrix (Fin n) (Fin n) ℝ) : Set ℝ :=
  {t | ∃ A ∈ intervalFamily L U, ∃ v : Fin n → ℝ,
    v ≠ 0 ∧ A.mulVec v = t • v}

/-- The set of nonempty connected components, with the inherited real topology. -/
def components (S : Set ℝ) : Set (Set ℝ) := connectedComponentIn S '' S

/-- The original all-dimensions component-count assertion. ENat cardinality
also handles an infinite component set, without assigning it cardinality zero. -/
def ComponentBoundConjecture : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∀ L U : Matrix (Fin n) (Fin n) ℝ,
    (∀ i j, L i j ≤ U i j) → (components (realEigenvalueSet L U)).encard ≤ n

def witnessMatrix (a b : ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  !![25, a, b; 1, -1, 0; 1, 0, 1]

def lower : Matrix (Fin 3) (Fin 3) ℝ := witnessMatrix (-166) 9

def upper : Matrix (Fin 3) (Fin 3) ℝ := witnessMatrix (-16) 159

def witnessSpectrum : Set ℝ := realEigenvalueSet lower upper

end NLA.IV06
