/- Full exact attainment data, including the zero lower bandwidth endpoint.
Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.WitnessPositive
import NLA.IE13.WitnessZero
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.IE13

theorem witness_data (p q : ℕ) :
    1+max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q)=1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    sharpGrowth p q ≤ growth (witness p q) (witnessStates p q) := by
  by_cases hp : p=0
  · subst p; exact witness_data_zero q
  · exact witness_data_positive p q (by omega)

#assert_trust kernel witness_data
end NLA.IE13
