import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped ComplexOrder Matrix.Norms.L2Operator
open NLA.MI04
namespace Referee3
example (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (h : ∀ A B : Mat n, A.IsHermitian → B.IsHermitian →
      (Matrix.fromBlocks A X X.conjTranspose B).PosSemidef →
      ‖Matrix.fromBlocks A X X.conjTranspose B‖ ≤ ‖A+B‖) :
    ∀ u v : Vec n, ‖u‖=1 → ‖v‖=1 → inner ℂ u v=0 →
      ‖inner ℂ u (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) X v)‖ =
      ‖inner ℂ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) X u)‖ :=
  universal_pair_symmetry n hn X h
example (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (h : ∀ A B : Mat n, A.IsHermitian → B.IsHermitian →
      (Matrix.fromBlocks A X X.conjTranspose B).PosSemidef →
      ‖Matrix.fromBlocks A X X.conjTranspose B‖ ≤ ‖A+B‖) :
    ∃ K : Mat n, ∃ α β : ℂ, K.IsHermitian ∧ X=α • K+β • (1:Mat n) :=
  original_target n hn X h
example (n : ℕ) (X A B : Mat n) :
    ‖Matrix.fromBlocks A X X.conjTranspose B‖ =
      ‖Matrix.toEuclideanCLM (n := Fin n ⊕ Fin n) (𝕜 := ℂ)
        (Matrix.fromBlocks A X X.conjTranspose B)‖ := rfl
example (n : ℕ) (A B : Mat n) :
    ‖A+B‖=‖Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) (A+B)‖ := rfl
example (X : Mat 1) (h : UniversalBlockNorm X) :
    ∃ K : Mat 1, ∃ α β : ℂ, K.IsHermitian ∧ X=α • K+β • (1:Mat 1) :=
  original_target 1 (by omega) X h
#assert_trust kernel NLA.MI04.universal_pair_symmetry
#assert_trust kernel NLA.MI04.original_target
#print axioms NLA.MI04.universal_pair_symmetry
#print axioms NLA.MI04.original_target
end Referee3
