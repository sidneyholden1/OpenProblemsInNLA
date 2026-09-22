/- Trusted complete IE-13 statement boundary; four deliberate placeholders. -/
import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.IE13

theorem referee3_upper_bound (p q n : ℕ) (hn : 1 + max p q ≤ n)
    (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n)
    (hA : IsBanded p q A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth p q := upper_bound p q n hn A S r hA hpath

theorem referee3_rational_attainment (p q : ℕ) :
    1 + max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q) = 1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    growth (witness p q) (witnessStates p q) = sharpGrowth p q := rational_attainment p q

theorem referee3_sharp_maximum (p q : ℕ) :
    IsGreatest (bandGrowths p q) (sharpGrowth p q) := sharp_maximum p q

theorem referee3_original_target (p q : ℕ) :
    (bandGrowths p q).Nonempty ∧ BddAbove (bandGrowths p q) ∧
    sSup (bandGrowths p q) =
      (if p = 0 then 1 else (bandRec p (p + q) : ℝ)) := original_target p q
#assert_trust kernel referee3_upper_bound
#print axioms referee3_upper_bound
#assert_trust kernel referee3_rational_attainment
#print axioms referee3_rational_attainment
#assert_trust kernel referee3_sharp_maximum
#print axioms referee3_sharp_maximum
#assert_trust kernel referee3_original_target
#print axioms referee3_original_target
end NLA.IE13
