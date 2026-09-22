/- Independent nonauthor literal export consumer, referee 2, 2026-09-22. -/
import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped Matrix.Norms.L2Operator
open NLA.MI04
namespace MI04Referee2
example (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (hX : UniversalBlockNorm X) : PairModulusSymmetry X :=
  NLA.MI04.universal_pair_symmetry n hn X hX
example (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (hX : UniversalBlockNorm X) : EssentiallyHermitian X :=
  NLA.MI04.original_target n hn X hX
example {n : ℕ} (A : Mat n) : ‖A‖ = ‖Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℂ) A‖ := rfl
example {n : ℕ} (A B X : Mat n) :
    ‖Matrix.fromBlocks A X X.conjTranspose B‖ =
      ‖Matrix.toEuclideanCLM (n := Fin n ⊕ Fin n) (𝕜 := ℂ)
        (Matrix.fromBlocks A X X.conjTranspose B)‖ := rfl
end MI04Referee2
#check NLA.MI04.universal_pair_symmetry
#check NLA.MI04.original_target
#print axioms NLA.MI04.universal_pair_symmetry
#print axioms NLA.MI04.original_target
#assert_trust kernel NLA.MI04.universal_pair_symmetry
#assert_trust kernel NLA.MI04.original_target
#assert_trust kernel NLA.MI04.fourier_norm_difference
#assert_trust kernel NLA.MI04.threshold_compare
#print axioms NLA.MI04.fourier_norm_difference
#print axioms NLA.MI04.threshold_compare
