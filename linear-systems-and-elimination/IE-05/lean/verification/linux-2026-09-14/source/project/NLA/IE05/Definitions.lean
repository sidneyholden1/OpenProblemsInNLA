/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance.
Mathematical counterexample: George Stepaniants. Original conjecture: John Peca-Medlin.
This file is the proof-independent statement boundary.
-/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Analysis.Real.Sqrt
set_option autoImplicit false
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE05

/-- The actual maximum absolute entry, with zero for an empty matrix. -/
def entryMax {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ((Finset.univ.sup fun ij : Fin n × Fin n => ‖A ij.1 ij.2‖₊) : ℝ≥0)

/-- Exact row swap followed by trailing Schur complement, padded by zeros.
The pivot is selected in active column k. No column swap is performed. -/
def schurStep {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (k p : Fin n) :
    Matrix (Fin n) (Fin n) ℝ := fun i j =>
  if k < i ∧ k < j then
    A (Equiv.swap k p i) j - A (Equiv.swap k p i) k / A p k * A p j
  else 0

/-- Every permitted partial-pivoting path, including all ties. States are
actual active matrices padded with zeros; states at indices ≥n are irrelevant. -/
def isPath {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (p : Fin n → Fin n) : Prop :=
  S 0 = A ∧ ∀ k : Fin n,
    k ≤ p k ∧ S k.val (p k) k ≠ 0 ∧
    (∀ i : Fin n, k ≤ i → |S k.val i k| ≤ |S k.val (p k) k|) ∧
    (k.val+1 < n → S (k.val+1) = schurStep (S k.val) k (p k))

/-- First available row among ties, in the current active ordering. -/
def isFirstPath {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (p : Fin n → Fin n) : Prop :=
  isPath A S p ∧ ∀ k i : Fin n, k ≤ i →
    |S k.val i k| = |S k.val (p k) k| → p k ≤ i

/-- Maximum across all actual active entries, divided by the input maximum. -/
def growth {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  (((Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
    ‖S kij.1.val kij.2.1 kij.2.2‖₊) : ℝ≥0) : ℝ) / entryMax A

def orthogonal {n : ℕ} (Q : Matrix (Fin n) (Fin n) ℝ) : Prop := Qᵀ * Q = 1

/-- The prescribed QR convention, expressed by its defining properties. -/
def positiveQR {n : ℕ} (L Q R : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  orthogonal Q ∧ Q * R = L ∧ (∀ i j, j < i → R i j = 0) ∧ ∀ i, 0 < R i i

def lowerMatrix (n : ℕ) : Matrix (Fin n) (Fin n) ℝ :=
  fun i j => if i = j then 1 else if j < i then -1 else 0

/-- The full set of growth factors, over all orthogonal matrices and every
admissible tie path. The advertised theorem verifies nonempty/bounded at n=8. -/
def orthogonalGrowths (n : ℕ) : Set ℝ :=
  {t | ∃ Q : Matrix (Fin n) (Fin n) ℝ, ∃ S : ℕ → Matrix (Fin n) (Fin n) ℝ,
    ∃ p : Fin n → Fin n, orthogonal Q ∧ isPath Q S p ∧ t = growth Q S}

/-- The complete original universal extremizer equality. Positive QR factors
and the first-row path are specified by their actual defining relations. -/
def ExtremizerConjecture : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∀ Q R : Matrix (Fin n) (Fin n) ℝ,
    ∀ S : ℕ → Matrix (Fin n) (Fin n) ℝ, ∀ p : Fin n → Fin n,
      positiveQR (lowerMatrix n) Q R → isFirstPath Q S p →
        sSup (orthogonalGrowths n) = growth Q S

def candidateH : Matrix (Fin 8) (Fin 8) ℤ := !![1, -5, -8, -12, -16, -16, 0, 64;
  -1, 13, -4, -6, -8, -8, 0, 32;
  -1, -3, 51, -3, -4, -4, 0, 16;
  -1, -3, -11, 169, -2, -2, 0, 8;
  -1, -3, -11, -43, 511, -1, 0, 4;
  -1, -3, -11, -43, -171, 1365, 0, 2;
  -1, -3, -11, -43, -171, -683, 1, 1;
  -1, -3, -11, -43, -171, -683, -1, 1]

def candidateT : Matrix (Fin 8) (Fin 8) ℤ := !![1, -5, -8, -12, -16, -16, 0, 64;
  0, 8, -12, -18, -24, -24, 0, 96;
  0, 0, 31, -33, -44, -44, 0, 176;
  0, 0, 0, 106, -86, -86, 0, 344;
  0, 0, 0, 0, 341, -171, 0, 684;
  0, 0, 0, 0, 0, 1024, 0, 1366;
  0, 0, 0, 0, 0, 0, 1, 2731;
  0, 0, 0, 0, 0, 0, 0, 5462]

def candidateD : Fin 8 → ℤ := ![8, 248, 3286, 36146, 349184, 2796544, 2, 5462]

def witnessH : Matrix (Fin 8) (Fin 8) ℤ := !![1, -1, -3, -21, -41, -101, -325, 63;
  -1, 3, 1, 17, 71, 291, 1179, 31;
  -1, -1, 13, -19, -56, -196, -752, 16;
  -1, -1, -3, 189, -28, -98, -376, 8;
  -1, -1, -3, -51, 581, -49, -188, 4;
  -1, -1, -3, -51, -213, 1507, -94, 2;
  -1, -1, -3, -51, -213, -873, 2589, 1;
  -1, 1, -5, -55, -183, -683, -2683, 1]

def witnessT : Matrix (Fin 8) (Fin 8) ℤ := !![1, -1, -3, -21, -41, -101, -325, 63;
  0, 2, -2, -4, 30, 190, 854, 94;
  0, 0, 8, -44, -67, -107, -223, 173;
  0, 0, 0, 120, -106, -116, -70, 338;
  0, 0, 0, 0, 397, -183, 48, 672;
  0, 0, 0, 0, 0, 1190, 190, 1342;
  0, 0, 0, 0, 0, 0, 3063, 2683;
  0, 0, 0, 0, 0, 0, 0, 5272]

def witnessD : Fin 8 → ℤ := ![8, 16, 240, 47640, 472430, 3644970, 16148136, 5272]

def witnessLower : Matrix (Fin 8) (Fin 8) ℝ :=
  fun i j => if i = 7 ∧ j = 1 then 0 else lowerMatrix 8 i j

/-- Integer columns are normalized by their genuine positive square-root lengths. -/
def normalized (H : Matrix (Fin 8) (Fin 8) ℤ) (D : Fin 8 → ℤ) :
    Matrix (Fin 8) (Fin 8) ℝ := fun i j => (H i j : ℝ) / Real.sqrt (D j : ℝ)
def candidateQ := normalized candidateH candidateD
def witnessQ := normalized witnessH witnessD
def candidateR := candidateQᵀ * lowerMatrix 8
def witnessR := witnessQᵀ * witnessLower

/-- Source's exact trailing LU formula, not a replacement for the path relation.
The exported path theorem must prove every actual Schur recurrence and pivot. -/
def luStates (L : Matrix (Fin 8) (Fin 8) ℝ) (T : Matrix (Fin 8) (Fin 8) ℤ)
    (D : Fin 8 → ℤ) (k : ℕ) : Matrix (Fin 8) (Fin 8) ℝ := fun i j =>
  if k ≤ i.val ∧ k ≤ j.val then
    (∑ ell : Fin 8, if k ≤ ell.val then L i ell * (T ell j : ℝ) else 0) / Real.sqrt (D j : ℝ)
  else 0
def candidateStates := luStates (lowerMatrix 8) candidateT candidateD
def witnessStates := luStates witnessLower witnessT witnessD
end NLA.IE05
