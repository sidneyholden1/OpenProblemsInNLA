import Solution
import LeanCert.Tactic.Verification
set_option autoImplicit false
namespace IE13Referee2
open NLA.IE13
example (p q n : ℕ) (hn : 1 + max p q ≤ n)
    (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n)
    (hA : IsBanded p q A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth p q := NLA.IE13.upper_bound p q n hn A S r hA hpath
example (p q : ℕ) :
    1 + max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q) = 1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    growth (witness p q) (witnessStates p q) = sharpGrowth p q :=
  NLA.IE13.rational_attainment p q
example (p q : ℕ) : IsGreatest (bandGrowths p q) (sharpGrowth p q) :=
  NLA.IE13.sharp_maximum p q
example (p q : ℕ) :
    (bandGrowths p q).Nonempty ∧ BddAbove (bandGrowths p q) ∧
    sSup (bandGrowths p q) =
      (if p = 0 then 1 else (bandRec p (p + q) : ℝ)) :=
  NLA.IE13.original_target p q
end IE13Referee2
#check NLA.IE13.upper_bound
#check NLA.IE13.rational_attainment
#check NLA.IE13.sharp_maximum
#check NLA.IE13.original_target
#print axioms NLA.IE13.upper_bound
#print axioms NLA.IE13.rational_attainment
#print axioms NLA.IE13.sharp_maximum
#print axioms NLA.IE13.original_target
#assert_trust NLA.IE13.upper_bound kernel
#assert_trust NLA.IE13.rational_attainment kernel
#assert_trust NLA.IE13.sharp_maximum kernel
#assert_trust NLA.IE13.original_target kernel
