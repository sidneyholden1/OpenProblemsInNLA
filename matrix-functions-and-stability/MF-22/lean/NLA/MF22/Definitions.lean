/- MF-22 proof-independent boundary. Source proof: George Stepaniants (Caltech).
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.ENNReal.Real
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22
abbrev Block := Matrix (Fin 2) (Fin 2) ℂ
/-- The ordered pair (block row, within-block coordinate) indexes exactly 2n
coordinates. The canonical flattened index is 2*j+a. -/
abbrev Ix (n : ℕ) := Fin n × Fin 2
abbrev Mat (n : ℕ) := Matrix (Ix n) (Ix n) ℂ

/-- Exact original real block coefficients, embedded in ℂ. -/
def B (k : ℤ) : Block :=
  (3 / 40 : ℂ) • (if k = -1 then !![-1,0;-5,0]
    else if k = 0 then !![0,-5;16,-5]
    else if k = 1 then !![-5,16;-5,0]
    else if k = 2 then !![0,-5;0,-1] else 0)
def C (k : ℤ) : Block :=
  (1 / 80 : ℂ) • (if k = -1 then !![1,0;7,0]
    else if k = 0 then !![24,7;0,25]
    else if k = 1 then !![-25,0;-7,-24]
    else if k = 2 then !![0,-7;0,-1] else 0)

/-- Exact pure Toeplitz truncation with lag j-k and no corner corrections. -/
def H (ρ : ℝ) (n : ℕ) : Mat n := fun j k =>
  Complex.I * B ((j.1.val : ℤ) - k.1.val) j.2 k.2 -
    (ρ : ℂ) * C ((j.1.val : ℤ) - k.1.val) j.2 k.2

/-- Both norms are the induced Euclidean (spectral 2) matrix norms. The inverse
is Mathlib's actual matrix inverse; singular matrices have infinite condition. -/
def conditionNumber (ρ : ℝ) (n : ℕ) : ENNReal :=
  if (H ρ n).det = 0 then ⊤
  else ENNReal.ofReal (‖H ρ n‖ * ‖(H ρ n)⁻¹‖)
end NLA.MF22
