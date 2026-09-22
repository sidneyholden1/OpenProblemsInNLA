/- SP-05 proof-independent boundary. Mathematical resolution: Matthew J. Colbrook.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Analysis.Matrix.PosDef
import Mathlib.LinearAlgebra.Matrix.Kronecker
set_option autoImplicit false
open scoped BigOperators Matrix Kronecker
noncomputable section
namespace NLA.SP05
abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
/-- The first coordinate is the column and the second the row: the usual
column-stacking order on the n² coordinates. -/
abbrev Vec (n : ℕ) := (Fin n × Fin n) → ℝ
abbrev BigMat (n : ℕ) := Matrix (Fin n × Fin n) (Fin n × Fin n) ℝ

def columnVec {n : ℕ} (X : Mat n) : Vec n := fun ij => X ij.2 ij.1

def commutation (n : ℕ) : BigMat n :=
  fun ij kl => if ij = (kl.2,kl.1) then 1 else 0

def jordan {n : ℕ} (A B : Mat n) : BigMat n := A ⊗ₖ B + B ⊗ₖ A

def jordanMap {n : ℕ} (A B X : Mat n) : Mat n := A*X*B+B*X*A

/-- Actual Euclidean Rayleigh quotient; exports exclude zero vectors. -/
def rayleigh {n : ℕ} (K : BigMat n) (v : Vec n) : ℝ :=
  (∑ i, v i*(K.mulVec v) i)/(∑ i, v i*v i)

/-- Full sets of Rayleigh values on the actual ±1 commutation eigenspaces. -/
def sectorValues {n : ℕ} (A B : Mat n) (sign : ℝ) : Set ℝ :=
  {t | ∃ v : Vec n, v ≠ 0 ∧ (commutation n).mulVec v = sign • v ∧
    t = rayleigh (A ⊗ₖ B) v}
end NLA.SP05
