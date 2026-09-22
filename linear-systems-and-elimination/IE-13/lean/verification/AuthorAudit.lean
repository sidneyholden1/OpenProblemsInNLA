import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
open NLA.IE13
example (p q n : ℕ) (hn : 1 + max p q ≤ n)
    (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n)
    (hA : IsBanded p q A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth p q := upper_bound p q n hn A S r hA hpath
example (p q : ℕ) :
    1 + max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q) = 1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    growth (witness p q) (witnessStates p q) = sharpGrowth p q := rational_attainment p q
example (p q : ℕ) : IsGreatest (bandGrowths p q) (sharpGrowth p q) := sharp_maximum p q
example (p q : ℕ) : (bandGrowths p q).Nonempty ∧ BddAbove (bandGrowths p q) ∧
    sSup (bandGrowths p q) = (if p = 0 then 1 else (bandRec p (p + q) : ℝ)) := original_target p q
#assert_trust kernel NLA.IE13.upper_bound
#assert_trust kernel NLA.IE13.rational_attainment
#assert_trust kernel NLA.IE13.sharp_maximum
#assert_trust kernel NLA.IE13.original_target
#print axioms NLA.IE13.upper_bound
#print axioms NLA.IE13.rational_attainment
#print axioms NLA.IE13.sharp_maximum
#print axioms NLA.IE13.original_target
