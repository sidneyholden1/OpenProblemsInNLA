/- Complete original IE-13 target, strengthened to all bandwidth pairs.
Mathematics attributed to Matthew J. Colbrook; formalization Sidney Holden with Codex. -/
import NLA.IE13.Proof
set_option leancert.trust "kernel"
set_option autoImplicit false
namespace NLA.IE13

theorem upper_bound (p q n : ℕ) (hn : 1 + max p q ≤ n)
    (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n)
    (hA : IsBanded p q A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth p q := upper_bound_proved p q n hn A S r hA hpath

theorem rational_attainment (p q : ℕ) :
    1 + max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q) = 1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    growth (witness p q) (witnessStates p q) = sharpGrowth p q := rational_attainment_proved p q

theorem sharp_maximum (p q : ℕ) :
    IsGreatest (bandGrowths p q) (sharpGrowth p q) := sharp_maximum_proved p q

theorem original_target (p q : ℕ) :
    (bandGrowths p q).Nonempty ∧ BddAbove (bandGrowths p q) ∧
    sSup (bandGrowths p q) =
      (if p = 0 then 1 else (bandRec p (p + q) : ℝ)) := original_target_proved p q

#assert_trust kernel upper_bound
#assert_trust kernel rational_attainment
#assert_trust kernel sharp_maximum
#assert_trust kernel original_target
#print axioms upper_bound
#print axioms rational_attainment
#print axioms sharp_maximum
#print axioms original_target
end NLA.IE13
