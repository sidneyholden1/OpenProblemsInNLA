/- IE-14 proof-independent statement boundary. Mathematics attributed in the
source to Matthew J. Colbrook, Cambridge. Formalization: Sidney Holden with
OpenAI Codex assistance. Apache-2.0. Padded Schur layout studied in IE-15;
here the field is complex and pivoting is COLUMN-only partial pivoting. -/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Data.Nat.Fib.Basic
set_option autoImplicit false
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14
abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℂ

/-- Exactly the ordinary three bands and the two cyclic corners, in the
original ordering; both corners nonzero and actual determinant nonzero. -/
def IsCyclic {n : ℕ} (A : Mat n) : Prop :=
  (∀ i j : Fin n,
    ¬ ((i.val ≤ j.val + 1 ∧ j.val ≤ i.val + 1) ∨
      (i.val = 0 ∧ j.val + 1 = n) ∨ (j.val = 0 ∧ i.val + 1 = n)) → A i j = 0) ∧
  (∃ first last : Fin n, first.val = 0 ∧ last.val + 1 = n ∧
    A first last ≠ 0 ∧ A last first ≠ 0) ∧ A.det ≠ 0

/-- Finite maximum of actual complex moduli. -/
def entryMax {n : ℕ} (A : Mat n) : ℝ :=
  ((Finset.univ.sup fun ij : Fin n × Fin n => ‖A ij.1 ij.2‖₊) : ℝ≥0)

/-- One actual row swap, fixed pivot column, then trailing Schur complement.
Eliminated rows and columns are padded with zero. -/
def schurStep {n : ℕ} (A : Mat n) (k r : Fin n) : Mat n := fun i j =>
  if k < i ∧ k < j then
    A (Equiv.swap k r i) j - A (Equiv.swap k r i) k / A r k * A r j
  else 0

/-- Every allowed largest-modulus active-column pivot, including all ties.
No preliminary permutation, column pivot, front or normalization premise. -/
def isPath {n : ℕ} (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n) : Prop :=
  S 0 = A ∧ ∀ k : Fin n, k ≤ r k ∧ S k.val (r k) k ≠ 0 ∧
    (∀ i : Fin n, k ≤ i → ‖S k.val i k‖ ≤ ‖S k.val (r k) k‖) ∧
    (k.val + 1 < n → S (k.val + 1) = schurStep (S k.val) k (r k))

/-- Every entry of each actual active stage, including the input and final scalar. -/
def growth {n : ℕ} (A : Mat n) (S : ℕ → Mat n) : ℝ :=
  (((Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
    ‖S kij.1.val kij.2.1 kij.2.2‖₊) : ℝ≥0) : ℝ) / entryMax A

def cyclicGrowths (n : ℕ) : Set ℝ :=
  {t | ∃ A : Mat n, ∃ S : ℕ → Mat n, ∃ r : Fin n → Fin n,
    IsCyclic A ∧ isPath A S r ∧ t = growth A S}

def sharpGrowth (n : ℕ) : ℝ := (Nat.fib (n + 1) : ℝ) + 1

/-- The source's explicit rational lower and upper factors. -/
def lowerQ (n : ℕ) : Matrix (Fin n) (Fin n) ℚ := fun i j =>
  if i = j then 1 else if j.val + 1 = i.val ∨ j.val + 2 = i.val then -1 else 0

def upperQ (n : ℕ) : Matrix (Fin n) (Fin n) ℚ := fun i j =>
  if j.val + 1 = n then (Nat.fib (i.val + 2) : ℚ) + (if i.val + 1 = n then 1 else 0)
  else if (i.val = 0 ∧ j.val = 1) ∨ (i.val = 1 ∧ j.val = 1) then 1/2
  else if i = j then 1 else 0

/-- Original row → factor row. For n≥4: 0→0, n−1→1, i→i + 1 otherwise.
This defines the input matrix; it is not an extra operation in the GEPP run. -/
def factorRow {n : ℕ} (i : Fin n) : Fin n :=
  if i.val = 0 then i else if h : i.val + 1 < n then ⟨i.val + 1,h⟩
  else if h : 1 < n then ⟨1,h⟩ else i

def witnessQ (n : ℕ) : Matrix (Fin n) (Fin n) ℚ := fun i j =>
  (lowerQ n * upperQ n) (factorRow i) j

def witness (n : ℕ) : Mat n := fun i j => (witnessQ n i j : ℂ)

/-- Actual current-position pivot: first row at stage zero, last row thereafter. -/
def witnessPivot {n : ℕ} (k : Fin n) : Fin n :=
  if k.val = 0 then k else ⟨n - 1,by have hk := k.isLt; omega⟩

/-- Candidate states computed by the literal complex Schur recurrence.
The attainment theorem must prove pivot legality and all input conditions. -/
def witnessStates (n : ℕ) : ℕ → Mat n
  | 0 => witness n
  | k + 1 => if h : k < n then
      schurStep (witnessStates n k) ⟨k,h⟩ (witnessPivot ⟨k,h⟩) else 0
end NLA.IE14
