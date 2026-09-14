/- Complete IV-06 exports, independent of the trusted Challenge environment. -/
import NLA.IV06.Proof

set_option autoImplicit false
namespace NLA.IV06

theorem included_points :
    (-3 : ℝ) ∈ witnessSpectrum ∧ 0 ∈ witnessSpectrum ∧
    3 ∈ witnessSpectrum ∧ 25 ∈ witnessSpectrum := included_points_proved

theorem excluded_separators :
    (-1 : ℝ) ∉ witnessSpectrum ∧ 1 ∉ witnessSpectrum ∧
    12 ∉ witnessSpectrum := excluded_separators_proved

theorem counterexample :
    (∀ i j, lower i j ≤ upper i j) ∧
    4 ≤ (components witnessSpectrum).encard := counterexample_proved

theorem not_componentBoundConjecture : ¬ ComponentBoundConjecture :=
  not_componentBoundConjecture_proved

#assert_trust kernel included_points
#assert_trust kernel excluded_separators
#assert_trust kernel counterexample
#assert_trust kernel not_componentBoundConjecture
end NLA.IV06
