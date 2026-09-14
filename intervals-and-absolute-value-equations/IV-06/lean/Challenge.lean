/- Trusted statement environment. The deliberate placeholders are never
imported by Solution and establish no mathematical result. -/
import NLA.IV06.Definitions

set_option autoImplicit false
namespace NLA.IV06

theorem included_points :
    (-3 : ℝ) ∈ witnessSpectrum ∧ 0 ∈ witnessSpectrum ∧
    3 ∈ witnessSpectrum ∧ 25 ∈ witnessSpectrum := by sorry

theorem excluded_separators :
    (-1 : ℝ) ∉ witnessSpectrum ∧ 1 ∉ witnessSpectrum ∧
    12 ∉ witnessSpectrum := by sorry

theorem counterexample :
    (∀ i j, lower i j ≤ upper i j) ∧
    4 ≤ (components witnessSpectrum).encard := by sorry

theorem not_componentBoundConjecture : ¬ ComponentBoundConjecture := by sorry

end NLA.IV06
