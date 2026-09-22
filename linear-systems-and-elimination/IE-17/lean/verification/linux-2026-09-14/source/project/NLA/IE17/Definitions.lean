/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance.
Mathematical counterexample: Matthew J. Colbrook. Original questions: Fong and Saunders.
This file is the proof-independent mathematical statement boundary.
-/
import Mathlib.Analysis.Matrix.Order
import Mathlib.Data.Matrix.ColumnRowPartitioned
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Topology.MetricSpace.HausdorffDistance

set_option autoImplicit false
open scoped BigOperators Classical Matrix MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.IE17

/-- Actual Euclidean vector norm, irrespective of the default norm on functions. -/
def vnorm {ι : Type*} [Fintype ι] (x : ι → ℝ) : ℝ := ‖WithLp.toLp 2 x‖

def residual {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ) (b : Fin m → ℝ)
    (x : Fin n → ℝ) : Fin m → ℝ := b - A *ᵥ x

def normalResidual {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ) (b : Fin m → ℝ)
    (x : Fin n → ℝ) : Fin n → ℝ := Aᵀ *ᵥ residual A b x

/-- Actual block powers of AᵀA applied to Aᵀb, with zero initial guess. -/
def krylovSpace {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ) (b : Fin m → ℝ)
    (k : ℕ) : Submodule ℝ (Fin n → ℝ) :=
  Submodule.span ℝ (Set.range (fun j : Fin k => (Aᵀ * A)^j.val *ᵥ (Aᵀ *ᵥ b)))

/-- Exact LSMR's variational characterization, including the minimum-length
choice among residual minimizers. No normal-residual proxy replaces a backward error. -/
def isLSMRIterate {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ) (b : Fin m → ℝ)
    (k : ℕ) (x : Fin n → ℝ) : Prop :=
  x ∈ krylovSpace A b k ∧
  (∀ y ∈ krylovSpace A b k, vnorm (normalResidual A b x) ≤ vnorm (normalResidual A b y)) ∧
  (∀ y ∈ krylovSpace A b k, vnorm (normalResidual A b y) = vnorm (normalResidual A b x) →
    vnorm x ≤ vnorm y)

/-- Matrix-only perturbations; b remains fixed. -/
def feasible {m n : ℕ} (A E : Matrix (Fin m) (Fin n) ℝ)
    (b : Fin m → ℝ) (x : Fin n → ℝ) : Prop :=
  (A + E)ᵀ *ᵥ ((A + E) *ᵥ x - b) = 0

/-- Infimum of the genuine spectral norms of all feasible perturbations.
The advertised witness theorems separately assert attainment and hence a minimum. -/
def backwardError {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ)
    (b : Fin m → ℝ) (x : Fin n → ℝ) : ℝ :=
  sInf {t : ℝ | ∃ E : Matrix (Fin m) (Fin n) ℝ, feasible A E b x ∧ t = ‖E‖}

def stacked {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ)
    (b : Fin m → ℝ) (x : Fin n → ℝ) : Matrix (Fin m ⊕ Fin n) (Fin n) ℝ :=
  Matrix.fromRows A ((vnorm (residual A b x) / vnorm x) • (1 : Matrix (Fin n) (Fin n) ℝ))

/-- Moore–Penrose formula for a full-column-rank real matrix. The advertised
approximation certificate verifies all four Moore–Penrose identities for both witnesses. -/
def leftPseudo {ι κ : Type*} [Fintype ι] [Fintype κ] [DecidableEq κ]
    (K : Matrix ι κ ℝ) : Matrix κ ι ℝ := (Kᵀ * K)⁻¹ * Kᵀ

def moorePenrose {ι κ : Type*} [Fintype ι] [Fintype κ]
    (K : Matrix ι κ ℝ) (P : Matrix κ ι ℝ) : Prop :=
  K * P * K = K ∧ P * K * P = P ∧ (K * P)ᵀ = K * P ∧ (P * K)ᵀ = P * K

/-- The original projected-residual approximation, with exact-termination convention.
All universal claims below restrict to nonzero iterates. -/
def approxError {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ)
    (b : Fin m → ℝ) (x : Fin n → ℝ) : ℝ :=
  if normalResidual A b x = 0 then 0 else
    vnorm ((stacked A b x * leftPseudo (stacked A b x)) *ᵥ
      (Sum.elim (residual A b x) (0 : Fin n → ℝ))) / vnorm x

/-- Monotonicity along successive nonzero exact LSMR iterates, before termination. -/
def monotonicError (err : ∀ {m n : ℕ}, Matrix (Fin m) (Fin n) ℝ →
    (Fin m → ℝ) → (Fin n → ℝ) → ℝ) : Prop :=
  ∀ m n : ℕ, ∀ A : Matrix (Fin m) (Fin n) ℝ, ∀ b : Fin m → ℝ,
    ∀ k : ℕ, 1 ≤ k → ∀ x y : Fin n → ℝ,
      isLSMRIterate A b k x → isLSMRIterate A b (k+1) y →
      x ≠ 0 → y ≠ 0 → normalResidual A b x ≠ 0 → err A b y ≤ err A b x

def witnessA : Matrix (Fin 4) (Fin 3) ℝ := !![1,0,0; 0,6,0; 0,0,5; 0,0,0]
def witnessB : Fin 4 → ℝ := ![11,1,1,1]
def x1 : Fin 3 → ℝ := ![11231/31201,6126/31201,5105/31201]
def x2 : Fin 3 → ℝ := ![87659/55219,7599/55219,16865/55219]

def approxSquared1 : ℝ := 69694107852573439503892031925 / 69323394392991282508138323472
def approxSquared2 : ℝ := 5430772101137459612205263871781350 / 5387955615790281743396033884265233
end NLA.IE17
