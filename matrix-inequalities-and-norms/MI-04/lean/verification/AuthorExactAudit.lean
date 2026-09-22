/- Two deliberately unproved MI-04 contracts. No proof module is imported. -/
import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace AuthorExact
open NLA.MI04

theorem checked_universal_pair_symmetry (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (hX : UniversalBlockNorm X) : PairModulusSymmetry X := by exact NLA.MI04.universal_pair_symmetry n hn X hX

theorem checked_original_target (n : ℕ) (hn : 1 ≤ n) (X : Mat n)
    (hX : UniversalBlockNorm X) : EssentiallyHermitian X := by exact NLA.MI04.original_target n hn X hX

end AuthorExact

#assert_trust kernel AuthorExact.checked_universal_pair_symmetry
#print axioms NLA.MI04.universal_pair_symmetry
#check @NLA.MI04.universal_pair_symmetry

#assert_trust kernel AuthorExact.checked_original_target
#print axioms NLA.MI04.original_target
#check @NLA.MI04.original_target
