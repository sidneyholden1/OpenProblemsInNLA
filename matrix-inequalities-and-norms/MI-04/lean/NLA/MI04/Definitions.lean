/- MI-04 proof-independent boundary. Mathematical source: Matthew J. Colbrook.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.LinearAlgebra.Matrix.PosDef
set_option autoImplicit false
open scoped ComplexOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MI04

abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℂ
abbrev Vec (n : ℕ) := EuclideanSpace ℂ (Fin n)

/-- The literal universal positive-block condition, with the induced Euclidean
operator norm on both the 2n-by-2n block matrix and A+B. -/
def UniversalBlockNorm {n : ℕ} (X : Mat n) : Prop :=
  ∀ A B : Mat n, A.IsHermitian → B.IsHermitian →
    (Matrix.fromBlocks A X X.conjTranspose B).PosSemidef →
    ‖Matrix.fromBlocks A X X.conjTranspose B‖ ≤ ‖A + B‖

/-- Every genuine orthonormal pair has symmetric off-diagonal moduli.
The action is the actual matrix action on the Euclidean inner-product space. -/
def PairModulusSymmetry {n : ℕ} (X : Mat n) : Prop :=
  ∀ u v : Vec n, ‖u‖ = 1 → ‖v‖ = 1 → inner ℂ u v = 0 →
    ‖inner ℂ u (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) X v)‖ =
    ‖inner ℂ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) X u)‖

/-- The exact original conclusion; alpha=0 is allowed, including scalar X. -/
def EssentiallyHermitian {n : ℕ} (X : Mat n) : Prop :=
  ∃ K : Mat n, ∃ α β : ℂ, K.IsHermitian ∧ X = α • K + β • (1 : Mat n)

end NLA.MI04
