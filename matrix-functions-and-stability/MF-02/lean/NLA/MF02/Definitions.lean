/- MF-02 proof-independent full statement boundary. Source exposition: George
Stepaniants; cubic iteration: Chen and Chow; prior order: Cheon, Kim and Kim.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Chebyshev.Extremal
import Mathlib.Topology.Algebra.Polynomial
import Mathlib.LinearAlgebra.Span.Defs
set_option autoImplicit false
open Polynomial
noncomputable section
namespace NLA.MF02

/-- All finite free real linear combinations of stored polynomial registers. -/
def registerSpan (ps : List ℝ[X]) : Submodule ℝ ℝ[X] :=
  Submodule.span ℝ {p | p ∈ ps}

/-- A straight-line register computation. Free linear combinations can be
used as either operand and as output. Every earlier stored product remains
available, so arbitrary shared-subexpression reuse is included. -/
inductive RegisterRun : ℕ → List ℝ[X] → Prop
  | initial : RegisterRun 0 [1, X]
  | multiply {m : ℕ} {ps : List ℝ[X]} {p q : ℝ[X]} :
      RegisterRun m ps → p ∈ registerSpan ps → q ∈ registerSpan ps →
      RegisterRun (m+1) (p*q :: ps)

/-- At most m products; scalar multiplication is free via registerSpan.
Charging an optional scalar product cannot enlarge this at-most class. -/
def computable (m : ℕ) (p : ℝ[X]) : Prop :=
  ∃ k ≤ m, ∃ ps, RegisterRun k ps ∧ p ∈ registerSpan ps

def gapDomain (δ : ℝ) : Set ℝ := Set.Icc (-1) (-δ) ∪ Set.Icc δ 1
def targetSign (x : ℝ) : ℝ := if x < 0 then -1 else 1
def pointErrors (δ : ℝ) (p : ℝ[X]) : Set ℝ :=
  (fun x => |p.eval x-targetSign x|) '' gapDomain δ
def uniformError (δ : ℝ) (p : ℝ[X]) : ℝ := sSup (pointErrors δ p)
def unrestrictedErrors (m : ℕ) (δ : ℝ) : Set ℝ :=
  {e | ∃ p, computable m p ∧ e = uniformError δ p}
def unrestrictedError (m : ℕ) (δ : ℝ) : ℝ := sInf (unrestrictedErrors m δ)

def cubic (a b : ℝ) : ℝ[X] := C a * X + C b * X^3
/-- Coefficients are listed in execution order, with exactly one stage per pair. -/
def composeCubics : List (ℝ × ℝ) → ℝ[X]
  | [] => X
  | ab :: rest => (composeCubics rest).comp (cubic ab.1 ab.2)
def cubicErrors (T : ℕ) (δ : ℝ) : Set ℝ :=
  {e | ∃ cs : List (ℝ × ℝ), cs.length = T ∧ e = uniformError δ (composeCubics cs)}
def cubicError (T : ℕ) (δ : ℝ) : ℝ := sInf (cubicErrors T δ)
def feasibleStages (m : ℕ) (δ : ℝ) : Set ℕ :=
  {T | cubicError T δ ≤ unrestrictedError m δ}
/-- Its nonempty-set/minimum properties are separate required exports. -/
def minimumStages (m : ℕ) (δ : ℝ) : ℕ := sInf (feasibleStages m δ)
def gapRatio (δ : ℝ) : ℝ := (1-δ)/(1+δ)
end NLA.MF02
