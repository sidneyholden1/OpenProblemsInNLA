/- Complete MI-04 necessity for arbitrary complex matrices.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden with Codex. -/
import NLA.MI04.Coordinate
import NLA.MI04.AffineHermitian
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.MI04

theorem universal_pair_symmetry (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (hX : UniversalBlockNorm X) : PairModulusSymmetry X := by
  letI : NeZero n := ⟨by omega⟩
  exact universal_pair_proved hX

theorem original_target (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (hX : UniversalBlockNorm X) : EssentiallyHermitian X := by
  exact pair_implies_essential X (universal_pair_symmetry n hn X hX)

#assert_trust kernel universal_pair_symmetry
#assert_trust kernel original_target
#print axioms universal_pair_symmetry
#print axioms original_target
end NLA.MI04
