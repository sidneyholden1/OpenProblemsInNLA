/- Full original IE-14 result. See NUMERICAL_TARGETS.md and reviews for scope.
Mathematics attributed to Matthew J. Colbrook; formalization Sidney Holden
with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE14.Proof
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.IE14

theorem upper_bound (n : ℕ) (hn : 4 ≤ n) (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hA : IsCyclic A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth n := upper_bound_proved n hn A S r hA hpath

theorem rational_attainment (n : ℕ) (hn : 4 ≤ n) :
    IsCyclic (witness n) ∧ entryMax (witness n) = 1 ∧
    isPath (witness n) (witnessStates n) witnessPivot ∧
    growth (witness n) (witnessStates n) = sharpGrowth n := rational_attainment_proved n hn

theorem sharp_maximum (n : ℕ) (hn : 4 ≤ n) :
    IsGreatest (cyclicGrowths n) (sharpGrowth n) := sharp_maximum_proved n hn

theorem original_target (n : ℕ) (hn : 4 ≤ n) :
    (cyclicGrowths n).Nonempty ∧ BddAbove (cyclicGrowths n) ∧
    sSup (cyclicGrowths n) = (Nat.fib (n+1):ℝ)+1 := original_target_proved n hn

#assert_trust kernel upper_bound
#assert_trust kernel rational_attainment
#assert_trust kernel sharp_maximum
#assert_trust kernel original_target
#print axioms upper_bound
#print axioms rational_attainment
#print axioms sharp_maximum
#print axioms original_target
end NLA.IE14
