/- IE-15 proof-independent statement boundary. Mathematical resolution:
George Stepaniants, Caltech. Formalization: Sidney Holden with OpenAI Codex
assistance. Apache-2.0. Active-path layout adapted from the local IE-05 project. -/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
set_option autoImplicit false
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15
abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℝ

def entryMax {n : ℕ} (A : Mat n) : ℝ :=
  ((Finset.univ.sup fun ij : Fin n × Fin n => ‖A ij.1 ij.2‖₊) : ℝ≥0)

/-- Actual row and column swaps followed by the trailing Schur complement. -/
def schurStep {n : ℕ} (A : Mat n) (k r c : Fin n) : Mat n := fun i j =>
  if k < i ∧ k < j then
    A (Equiv.swap k r i) (Equiv.swap k c j) -
      A (Equiv.swap k r i) c / A r c * A r (Equiv.swap k c j)
  else 0

/-- All admissible rook choices, including ties. The pivot is maximal in
its entire active row AND active column; no global maximum is required. -/
def isPath {n : ℕ} (A : Mat n) (S : ℕ → Mat n)
    (r c : Fin n → Fin n) : Prop :=
  S 0 = A ∧ ∀ k : Fin n,
    k ≤ r k ∧ k ≤ c k ∧ S k.val (r k) (c k) ≠ 0 ∧
    (∀ i : Fin n, k ≤ i → |S k.val i (c k)| ≤ |S k.val (r k) (c k)|) ∧
    (∀ j : Fin n, k ≤ j → |S k.val (r k) j| ≤ |S k.val (r k) (c k)|) ∧
    (k.val+1 < n → S (k.val+1) = schurStep (S k.val) k (r k) (c k))

/-- Actual maximum over every entry of every active matrix, divided by the
original maximum. Zero padding has no effect on any nonempty active stage. -/
def growth {n : ℕ} (A : Mat n) (S : ℕ → Mat n) : ℝ :=
  (((Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
    ‖S kij.1.val kij.2.1 kij.2.2‖₊) : ℝ≥0) : ℝ) / entryMax A

def rookGrowths (n : ℕ) : Set ℝ :=
  {t | ∃ A : Mat n, ∃ S : ℕ → Mat n, ∃ r c : Fin n → Fin n,
    A.det ≠ 0 ∧ isPath A S r c ∧ t = growth A S}

def witnessThree : Mat 3 := !![1,0,-1; 0,1,-1; 1,1,1]
def witnessFour : Mat 4 := !![1,0,1,1; 0,1,1/3,-1; -1/3,-1,1,-1; -1,1,1,1]

/-- Exact successive diagonal-pivot Schur steps. These are candidate states;
the witness theorem must separately establish every rook admissibility condition. -/
def diagonalStates {n : ℕ} (A : Mat n) : ℕ → Mat n
  | 0 => A
  | k+1 => if h : k < n then
      schurStep (diagonalStates A k) ⟨k,h⟩ ⟨k,h⟩ ⟨k,h⟩ else 0
end NLA.IE15
