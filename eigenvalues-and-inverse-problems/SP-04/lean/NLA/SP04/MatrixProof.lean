import NLA.SP04.Scalar
import NLA.SP04.MatrixOrbit

/- Orthogonal transport of the diagonal counterexample from the SP-04 source.
The underlying mathematical argument is due to Matthew Colbrook. -/
set_option autoImplicit false
noncomputable section
namespace NLA.SP04

theorem orbit_unique_failure_proved (U : Mat 3) (hU : U ∈ counterexampleFamily) :
    Failure U := by
  obtain ⟨P, Q, s, hP, hQ, hs, rfl⟩ := hU
  exact failure_orthogonalTransform hP hQ (diagonal_unique_failure_proved s hs)

end NLA.SP04
