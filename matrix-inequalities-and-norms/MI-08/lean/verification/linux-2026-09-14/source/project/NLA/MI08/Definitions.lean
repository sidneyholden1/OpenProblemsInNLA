import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.LinearAlgebra.Matrix.HadamardMatrix
import Mathlib.Data.Real.Basic
import Mathlib.Order.ConditionallyCompleteLattice.Basic
set_option autoImplicit false
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MI08
abbrev Mat (d : ℕ) := Matrix (Fin d) (Fin d) ℝ

def pinching {d : ℕ} (X : Mat d) : Mat d := Matrix.diagonal fun j => X j j

def FixedPinching {q d : ℕ} (U : Fin q → Mat d) : Prop :=
  0 < q ∧ (∀ r, (U r).transpose * U r = 1) ∧
  ∀ X : Mat d, pinching X = (1 / (q : ℝ)) • ∑ r, U r * X * (U r).transpose

def SignDesign {q d : ℕ} (H : Matrix (Fin q) (Fin d) ℤ) : Prop :=
  (∀ r j, H r j = 1 ∨ H r j = -1) ∧ H.transpose * H = (q : ℤ) • 1

def pinchingLengths (d : ℕ) : Set ℕ := {q | ∃ U : Fin q → Mat d, FixedPinching U}

def phi (d : ℕ) : ℕ := sInf (pinchingLengths d)

/-- Source Paley matrix, with an all-one first row and column. -/
def hadamardTwelve : Matrix (Fin 12) (Fin 12) ℤ := fun i j =>
  if i = 0 ∨ j = 0 then 1 else if i = j then -1 else
  if (i.val + 11 - j.val) % 11 ∈ ({1,3,4,5,9} : Finset ℕ) then 1 else -1
end NLA.MI08
