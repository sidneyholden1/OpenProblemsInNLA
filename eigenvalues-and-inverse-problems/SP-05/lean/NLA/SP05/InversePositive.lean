/- Spectral proof of the inverse-Jordan PSD implication in Colbrook's SP-05.
The source uses an integral; this equivalent argument uses negative eigenvectors.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Analysis.Matrix.Order
import Mathlib.Tactic
set_option autoImplicit false
set_option maxHeartbeats 1000000
open Matrix
open scoped BigOperators ComplexOrder MatrixOrder
noncomputable section
namespace NLA.SP05

/-- A positive definite Sylvester coefficient detects positivity of its
Hermitian argument. This avoids any integral or convergence hypothesis. -/
theorem sylvester_posSemidef {n : Type*} [Fintype n] [DecidableEq n]
    (C Z : Matrix n n ℂ) (hC : C.PosDef) (hZ : Z.IsHermitian)
    (hY : (C*Z+Z*C).PosSemidef) : Z.PosSemidef := by
  apply hZ.posSemidef_iff_eigenvalues_nonneg.mpr
  intro i
  let v : n → ℂ := hZ.eigenvectorBasis i
  have hv : v ≠ 0 := by
    exact (WithLp.ofLp_eq_zero 2).ne.2 (hZ.eigenvectorBasis.orthonormal.ne_zero i)
  have he : Z *ᵥ v = hZ.eigenvalues i • v := hZ.mulVec_eigenvectorBasis i
  have hCv : 0 < (star v ⬝ᵥ (C *ᵥ v)).re := hC.re_dotProduct_pos hv
  have hYv := hY.re_dotProduct_nonneg v
  have hleft : star v ⬝ᵥ (Z *ᵥ (C *ᵥ v)) = hZ.eigenvalues i • (star v ⬝ᵥ (C *ᵥ v)) := by
    have hs : star v ᵥ* Z = star (Z *ᵥ v) := by
      rw [star_mulVec, hZ.eq]
    rw [dotProduct_mulVec, hs, he]
    simp [smul_dotProduct]
  have hright : star v ⬝ᵥ (C *ᵥ (Z *ᵥ v)) = hZ.eigenvalues i • (star v ⬝ᵥ (C *ᵥ v)) := by
    rw [he,mulVec_smul,dotProduct_smul]
  simp only [add_mulVec, ← mulVec_mulVec, dotProduct_add, hleft, hright] at hYv
  change 0 ≤ (hZ.eigenvalues i • (star v ⬝ᵥ (C *ᵥ v)) + hZ.eigenvalues i • (star v ⬝ᵥ (C *ᵥ v))).re at hYv
  simp only [Complex.add_re, Complex.real_smul, Complex.mul_re, Complex.ofReal_re,
    Complex.ofReal_im, zero_mul, sub_zero] at hYv
  change 0 ≤ hZ.eigenvalues i
  nlinarith

/-- The full inverse-positivity implication for a positive-definite Jordan pair.
No commutation or additional inverse-positivity premise is required. -/
theorem jordanMap_posSemidef_inverse {n : Type*} [Fintype n] [DecidableEq n]
    (A B X : Matrix n n ℂ) (hA : A.PosDef) (hB : B.PosDef)
    (hX : X.IsHermitian) (hY : (A*X*B+B*X*A).PosSemidef) : X.PosSemidef := by
  obtain ⟨u, hu, hBu⟩ : ∃ u : Matrix n n ℂ, IsUnit u ∧ B = star u * u :=
    CStarAlgebra.isStrictlyPositive_iff_eq_star_mul_self.mp hB.isStrictlyPositive
  subst B
  lift u to (Matrix n n ℂ)ˣ using hu
  let v : Matrix n n ℂ := ↑u⁻¹
  have hv : IsUnit v := Units.isUnit u⁻¹
  have hC : (star v*A*v).PosDef := hv.posDef_star_left_conjugate_iff.mpr hA
  have hZ : ((u : Matrix n n ℂ)*X*star (u : Matrix n n ℂ)).IsHermitian :=
    isHermitian_mul_mul_conjTranspose _ hX
  have heq : (star v*A*v)*((u : Matrix n n ℂ)*X*star (u : Matrix n n ℂ)) +
      ((u : Matrix n n ℂ)*X*star (u : Matrix n n ℂ))*(star v*A*v) =
      star v*(A*X*(star (u : Matrix n n ℂ)*(u : Matrix n n ℂ))+
        (star (u : Matrix n n ℂ)*(u : Matrix n n ℂ))*X*A)*v := by
    simp only [v, mul_add, add_mul, mul_assoc]
    simp only [← mul_assoc, Units.inv_mul, mul_one, ← star_mul, Units.mul_inv,
      star_one, one_mul]
  have hSY : ((star v*A*v)*((u : Matrix n n ℂ)*X*star (u : Matrix n n ℂ)) +
      ((u : Matrix n n ℂ)*X*star (u : Matrix n n ℂ))*(star v*A*v)).PosSemidef := by
    rw [heq]
    exact hv.posSemidef_star_left_conjugate_iff.mpr hY
  exact (Units.isUnit u).posSemidef_star_right_conjugate_iff.mp
    (sylvester_posSemidef _ _ hC hZ hSY)

end NLA.SP05
