import NLA.IE17.Approximation
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Classical Matrix MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.IE17

/-- Separate negative answers to both counted-together original questions. -/
theorem counterexample : ¬ monotonicError (@backwardError) ∧ ¬ monotonicError (@approxError) := by
  constructor
  · intro h
    have bad := h 4 3 witnessA witnessB 1 (by norm_num) x1 x2
      iterates.2.1 iterates.2.2.1 iterates.2.2.2.1 iterates.2.2.2.2.1 iterates.2.2.2.2.2.1
    exact (not_le_of_gt backward_increase.2.2.2.2) bad
  · intro h
    have bad := h 4 3 witnessA witnessB 1 (by norm_num) x1 x2
      iterates.2.1 iterates.2.2.1 iterates.2.2.2.1 iterates.2.2.2.2.1 iterates.2.2.2.2.2.1
    exact (not_le_of_gt approximation_increase.2.2.2.2) bad
end NLA.IE17

#assert_trust kernel NLA.IE17.iterates
#assert_trust kernel NLA.IE17.backward_increase
#assert_trust kernel NLA.IE17.approximation_increase
#assert_trust kernel NLA.IE17.counterexample
