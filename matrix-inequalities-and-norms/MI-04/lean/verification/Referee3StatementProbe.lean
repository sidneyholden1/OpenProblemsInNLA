import NLA.MI04.Definitions
set_option autoImplicit false
open scoped ComplexOrder Matrix.Norms.L2Operator
open NLA.MI04
example (n : ℕ) (X : Mat n) : UniversalBlockNorm X ↔
  ∀ A B : Mat n, A.IsHermitian → B.IsHermitian →
    (Matrix.fromBlocks A X X.conjTranspose B).PosSemidef →
    ‖Matrix.toEuclideanCLM (n := Fin n ⊕ Fin n) (𝕜 := ℂ) (Matrix.fromBlocks A X X.conjTranspose B)‖ ≤
      ‖Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) (A+B)‖ := Iff.rfl
example (n : ℕ) (X : Mat n) : EssentiallyHermitian X ↔
  ∃ K : Mat n, ∃ α β : ℂ, K.IsHermitian ∧ X=α • K+β • (1 : Mat n) := Iff.rfl
