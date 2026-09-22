/- Independent nonauthor final consumer by OpenAI Codex coordinator /root. -/
import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.IE14
example (n : ℕ) (hn : 4 ≤ n) (A : Matrix (Fin n) (Fin n) ℂ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℂ) (r : Fin n → Fin n)
    (hA : IsCyclic A) (hp : isPath A S r) :
    growth A S ≤ (Nat.fib (n+1) : ℝ)+1 := upper_bound n hn A S r hA hp
example (n : ℕ) (hn : 4 ≤ n) :
    IsCyclic (witness n) ∧ entryMax (witness n) = 1 ∧
    isPath (witness n) (witnessStates n) witnessPivot ∧
    growth (witness n) (witnessStates n) = (Nat.fib (n+1) : ℝ)+1 :=
  rational_attainment n hn
example (n : ℕ) (hn : 4 ≤ n) :
    IsGreatest (cyclicGrowths n) ((Nat.fib (n+1) : ℝ)+1) := sharp_maximum n hn
example (n : ℕ) (hn : 4 ≤ n) :
    (cyclicGrowths n).Nonempty ∧ BddAbove (cyclicGrowths n) ∧
    sSup (cyclicGrowths n) = (Nat.fib (n+1) : ℝ)+1 := original_target n hn
#assert_trust kernel upper_bound
#assert_trust kernel rational_attainment
#assert_trust kernel sharp_maximum
#assert_trust kernel original_target
#print axioms upper_bound
#print axioms rational_attainment
#print axioms sharp_maximum
#print axioms original_target
end NLA.IE14
