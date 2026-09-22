import NLA.IE13.Upper
set_option autoImplicit false
set_option leancert.trust "kernel"
open NLA.IE13
example (p q n : ℕ) (hn : 1 + max p q ≤ n)
    (A : Mat n) (S : ℕ → Mat n) (r : Fin n → Fin n)
    (hA : IsBanded p q A) (hpath : isPath A S r) :
    growth A S ≤ sharpGrowth p q := upper_bound_proved p q n hn A S r hA hpath
#print axioms NLA.IE13.upper_bound_proved
#assert_trust NLA.IE13.upper_bound_proved kernel
