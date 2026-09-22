/- Independent consumer of the four exact frozen IE-14 signatures. -/
import Solution
set_option autoImplicit false
namespace NLA.IE14

example (n : ℕ) (hn : 4 ≤ n) (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hA : IsCyclic A) (hpath : isPath A S r) :
    growth A S  ≤  sharpGrowth n := NLA.IE14.upper_bound n hn A S r hA hpath

example (n : ℕ) (hn : 4 ≤ n) :
    IsCyclic (witness n) ∧ entryMax (witness n) = 1 ∧
    isPath (witness n) (witnessStates n) witnessPivot ∧
    growth (witness n) (witnessStates n) = sharpGrowth n := NLA.IE14.rational_attainment n hn

example (n : ℕ) (hn : 4 ≤ n) :
    IsGreatest (cyclicGrowths n) (sharpGrowth n) := NLA.IE14.sharp_maximum n hn

example (n : ℕ) (hn : 4 ≤ n) :
    (cyclicGrowths n).Nonempty ∧ BddAbove (cyclicGrowths n) ∧
    sSup (cyclicGrowths n)  =  (Nat.fib (n + 1) : ℝ) + 1 := NLA.IE14.original_target n hn
end NLA.IE14

#print axioms NLA.IE14.upper_bound
#assert_trust kernel NLA.IE14.upper_bound
#print axioms NLA.IE14.rational_attainment
#assert_trust kernel NLA.IE14.rational_attainment
#print axioms NLA.IE14.sharp_maximum
#assert_trust kernel NLA.IE14.sharp_maximum
#print axioms NLA.IE14.original_target
#assert_trust kernel NLA.IE14.original_target
