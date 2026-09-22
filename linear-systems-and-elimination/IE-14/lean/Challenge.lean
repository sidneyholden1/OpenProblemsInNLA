/- Trusted full IE-14 statement boundary; four deliberate proof placeholders. -/
import NLA.IE14.Definitions
set_option autoImplicit false
namespace NLA.IE14

theorem upper_bound (n : ℕ) (hn : 4 ≤ n) (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hA : IsCyclic A) (hpath : isPath A S r) :
    growth A S  ≤  sharpGrowth n := by sorry

theorem rational_attainment (n : ℕ) (hn : 4 ≤ n) :
    IsCyclic (witness n) ∧ entryMax (witness n) = 1 ∧
    isPath (witness n) (witnessStates n) witnessPivot ∧
    growth (witness n) (witnessStates n) = sharpGrowth n := by sorry

theorem sharp_maximum (n : ℕ) (hn : 4 ≤ n) :
    IsGreatest (cyclicGrowths n) (sharpGrowth n) := by sorry

theorem original_target (n : ℕ) (hn : 4 ≤ n) :
    (cyclicGrowths n).Nonempty ∧ BddAbove (cyclicGrowths n) ∧
    sSup (cyclicGrowths n)  =  (Nat.fib (n + 1) : ℝ) + 1 := by sorry
end NLA.IE14
