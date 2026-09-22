/- Independent partial-candidate audit: only the universal upper-bound export. -/
import NLA.IE14.Upper
set_option autoImplicit false
namespace NLA.IE14
example (n : ℕ) (hn : 4 ≤ n) (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hA : IsCyclic A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth n := upper_bound_proved n hn A S r hA hpath
end NLA.IE14
#print axioms NLA.IE14.upper_bound_proved
#assert_trust kernel NLA.IE14.upper_bound_proved
