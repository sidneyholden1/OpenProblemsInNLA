import NLA.MI04.Definitions
import Mathlib.Tactic
set_option autoImplicit false
open scoped ComplexOrder Matrix.Norms.L2Operator
open NLA.MI04
example (n : ℕ) (X A B : Mat n) :
    ‖Matrix.fromBlocks A X X.conjTranspose B‖ =
      ‖Matrix.toEuclideanCLM (n := Fin n ⊕ Fin n) (𝕜 := ℂ)
        (Matrix.fromBlocks A X X.conjTranspose B)‖ := rfl
example (n : ℕ) (A B : Mat n) : ‖A+B‖ =
    ‖Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) (A+B)‖ := rfl
example (n : ℕ) (X : Mat n) : UniversalBlockNorm X ↔
    ∀ A B : Mat n, A.IsHermitian → B.IsHermitian →
      (Matrix.fromBlocks A X X.conjTranspose B).PosSemidef →
      ‖Matrix.fromBlocks A X X.conjTranspose B‖ ≤ ‖A+B‖ := Iff.rfl
example (X : Mat 1) : EssentiallyHermitian X := by
  refine ⟨0,0,X 0 0,Matrix.isHermitian_zero,?_⟩
  ext i j
  fin_cases i; fin_cases j
  simp
example (n : ℕ) (β : ℂ) : EssentiallyHermitian (β • (1 : Mat n)) :=
  ⟨0,0,β,Matrix.isHermitian_zero,by simp⟩
#check Matrix.posSemidef_self_mul_conjTranspose
#check Matrix.toEuclideanCLM_toLp
