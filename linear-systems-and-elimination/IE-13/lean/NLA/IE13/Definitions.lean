/- IE-13 statement boundary. Source mathematics attributed to Matthew J. Colbrook,
Cambridge; formalization Sidney Holden with OpenAI Codex assistance. Apache-2.0.
Literal complex padded GEPP layout adapted from the separately reviewed IE-14
boundary; no IE-14 result or proof module is imported. -/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
set_option autoImplicit false
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13
abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℂ

/-- Actual nonsingular complex inputs with bandwidths at most p and q,
in the original ordering. -/
def IsBanded {n : ℕ} (p q : ℕ) (A : Mat n) : Prop :=
  (∀ i j : Fin n, j.val + p < i.val ∨ i.val + q < j.val → A i j = 0) ∧
  A.det ≠ 0

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

/-- The entire admissible dimension/input/path growth set. -/
def bandGrowths (p q : ℕ) : Set ℝ :=
  {t | ∃ n : ℕ, 1 + max p q ≤ n ∧ ∃ A : Mat n,
    ∃ S : ℕ → Mat n, ∃ r : Fin n → Fin n,
      IsBanded p q A ∧ isPath A S r ∧ t = growth A S}

/-- h₀=0; hₜ=1+sum of the previous p values. Truncated natural subtraction
implements the source's zero extension to nonpositive indices. -/
def bandRec (p : ℕ) (t : ℕ) : ℕ :=
  match t with
  | 0 => 0
  | k + 1 => 1 + ∑ r ∈ Finset.range p, bandRec p (k - r)
termination_by t
decreasing_by omega

def sharpGrowth (p q : ℕ) : ℝ :=
  if p = 0 then 1 else (bandRec p (p + q) : ℝ)

def witnessSize (p q : ℕ) : ℕ := 2 * p + q + 1

/-- Unit lower triangular factor with −1 on the first p subdiagonals. -/
def lowerQ (p q : ℕ) : Matrix (Fin (witnessSize p q)) (Fin (witnessSize p q)) ℚ :=
  fun i j => if i = j then 1 else if j.val < i.val ∧ i.val ≤ j.val + p then -1 else 0

/-- Source upper-supported vector for a nonfinal early column; zero-based indices. -/
def earlyColumnQ (p k i : ℕ) : ℚ :=
  if i = 0 ∧ k ≤ p then 1
  else if 1 ≤ i ∧ i ≤ k ∧ k ≤ p then 2 ^ (i - 1)
  else if i = k ∧ p + 1 ≤ k then 1 else 0

/-- Original row → factor row: p→0, i<p→i+1, and i>p→i.
This defines the input; it is not a preliminary GEPP permutation. -/
def factorRow (p q : ℕ) (i : Fin (witnessSize p q)) : Fin (witnessSize p q) :=
  if i.val = p then ⟨0, by unfold witnessSize; omega⟩
  else if h : i.val < p then ⟨i.val + 1, by unfold witnessSize; omega⟩ else i

/-- Exact rational attaining family; identity when p=0. Target column is p+q.
Earlier columns are η Pᵀ L₀ u; later columns are literal identity columns. -/
def witnessQ (p q : ℕ) : Matrix (Fin (witnessSize p q)) (Fin (witnessSize p q)) ℚ :=
  if p = 0 then 1 else fun i j =>
    if j.val < p + q then
      (1 / (2 : ℚ) ^ p) * ∑ a : Fin (witnessSize p q),
        lowerQ p q (factorRow p q i) a * earlyColumnQ p j.val a.val
    else if j.val = p + q then (if p ≤ i.val then 1 else 0)
    else if i = j then 1 else 0

def witness (p q : ℕ) : Mat (witnessSize p q) :=
  fun i j => (witnessQ p q i j : ℂ)

/-- Actual current-position pivots realizing original labels p,0,...,p−1,p+1,... . -/
def witnessPivot (p q : ℕ) (k : Fin (witnessSize p q)) : Fin (witnessSize p q) :=
  if k.val ≤ p then ⟨p, by unfold witnessSize; omega⟩ else k

/-- Literal candidate Schur states; the theorem must establish all pivot legality. -/
def witnessStates (p q : ℕ) : ℕ → Mat (witnessSize p q)
  | 0 => witness p q
  | k + 1 => if h : k < witnessSize p q then
      schurStep (witnessStates p q k) ⟨k,h⟩ (witnessPivot p q ⟨k,h⟩) else 0
end NLA.IE13
