/- Exact finite algebra for IS-02. Formalization: Sidney Holden with Codex.
Mathematical counterexample: Matthew J. Colbrook. Apache 2.0. -/
import NLA.IS02.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 4000000
set_option maxRecDepth 10000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.IS02

def model (a b c d e f : ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  !![1-a-b-c,a,b,c; a,1-a-d-e,d,e; b,d,1-b-d-f,f; c,e,f,1-c-e-f]
def edgeSum (a b c d e f : ℝ) : ℝ := a+b+c+d+e+f
def pairSum (a b c d e f : ℝ) : ℝ :=
  3*(a*b+a*c+a*d+a*e+b*c+b*d+b*f+c*e+c*f+d*e+d*f+e*f)+4*(a*f+b*e+c*d)
def treeSum (a b c d e f : ℝ) : ℝ :=
  a*b*c+a*b*e+a*b*f+a*c*d+a*c*f+a*d*e+a*d*f+a*e*f+
  b*c*d+b*c*e+b*d*e+b*d*f+b*e*f+c*d*e+c*d*f+c*e*f

lemma det_four {R : Type*} [CommRing R] (M : Matrix (Fin 4) (Fin 4) R) :
    M.det = M 0 0*(M 1 1*M 2 2*M 3 3 - M 1 1*M 2 3*M 3 2 - M 1 2*M 2 1*M 3 3 + M 1 2*M 2 3*M 3 1 + M 1 3*M 2 1*M 3 2 - M 1 3*M 2 2*M 3 1)
      - M 0 1*(M 1 0*M 2 2*M 3 3 - M 1 0*M 2 3*M 3 2 - M 1 2*M 2 0*M 3 3 + M 1 2*M 2 3*M 3 0 + M 1 3*M 2 0*M 3 2 - M 1 3*M 2 2*M 3 0)
      + M 0 2*(M 1 0*M 2 1*M 3 3 - M 1 0*M 2 3*M 3 1 - M 1 1*M 2 0*M 3 3 + M 1 1*M 2 3*M 3 0 + M 1 3*M 2 0*M 3 1 - M 1 3*M 2 1*M 3 0)
      - M 0 3*(M 1 0*M 2 1*M 3 2 - M 1 0*M 2 2*M 3 1 - M 1 1*M 2 0*M 3 2 + M 1 1*M 2 2*M 3 0 + M 1 2*M 2 0*M 3 1 - M 1 2*M 2 1*M 3 0) := by
  rw [Matrix.det_succ_row_zero,Fin.sum_univ_four]
  simp only [Matrix.det_fin_three,Matrix.submatrix_apply]
  change (-1 : R)^0*M 0 0*(M 1 1*M 2 2*M 3 3 - M 1 1*M 2 3*M 3 2 - M 1 2*M 2 1*M 3 3 + M 1 2*M 2 3*M 3 1 + M 1 3*M 2 1*M 3 2 - M 1 3*M 2 2*M 3 1) +
      (-1 : R)^1*M 0 1*(M 1 0*M 2 2*M 3 3 - M 1 0*M 2 3*M 3 2 - M 1 2*M 2 0*M 3 3 + M 1 2*M 2 3*M 3 0 + M 1 3*M 2 0*M 3 2 - M 1 3*M 2 2*M 3 0) +
      (-1 : R)^2*M 0 2*(M 1 0*M 2 1*M 3 3 - M 1 0*M 2 3*M 3 1 - M 1 1*M 2 0*M 3 3 + M 1 1*M 2 3*M 3 0 + M 1 3*M 2 0*M 3 1 - M 1 3*M 2 1*M 3 0) +
      (-1 : R)^3*M 0 3*(M 1 0*M 2 1*M 3 2 - M 1 0*M 2 2*M 3 1 - M 1 1*M 2 0*M 3 2 + M 1 1*M 2 2*M 3 0 + M 1 2*M 2 0*M 3 1 - M 1 2*M 2 1*M 3 0) = _
  ring

lemma model_charpoly (a b c d e f : ℝ) :
    (model a b c d e f).charpoly =
      (Polynomial.X-1)^4 + Polynomial.C (2*edgeSum a b c d e f)*(Polynomial.X-1)^3 +
      Polynomial.C (pairSum a b c d e f)*(Polynomial.X-1)^2 +
      Polynomial.C (4*treeSum a b c d e f)*(Polynomial.X-1) := by
  have hm : (model a b c d e f).charmatrix =
      !![Polynomial.X-Polynomial.C (1-a-b-c), -Polynomial.C a, -Polynomial.C b, -Polynomial.C c;
        -Polynomial.C a, Polynomial.X-Polynomial.C (1-a-d-e), -Polynomial.C d, -Polynomial.C e;
        -Polynomial.C b, -Polynomial.C d, Polynomial.X-Polynomial.C (1-b-d-f), -Polynomial.C f;
        -Polynomial.C c, -Polynomial.C e, -Polynomial.C f, Polynomial.X-Polynomial.C (1-c-e-f)] := by
    ext i j; fin_cases i <;> fin_cases j <;> norm_num [Matrix.charmatrix,Matrix.diagonal,model]
  unfold Matrix.charpoly
  rw [hm,det_four]
  change (Polynomial.X-Polynomial.C (1-a-b-c))*((Polynomial.X-Polynomial.C (1-a-d-e))*(Polynomial.X-Polynomial.C (1-b-d-f))*(Polynomial.X-Polynomial.C (1-c-e-f)) - (Polynomial.X-Polynomial.C (1-a-d-e))*(-Polynomial.C f)*(-Polynomial.C f) - (-Polynomial.C d)*(-Polynomial.C d)*(Polynomial.X-Polynomial.C (1-c-e-f)) + (-Polynomial.C d)*(-Polynomial.C f)*(-Polynomial.C e) + (-Polynomial.C e)*(-Polynomial.C d)*(-Polynomial.C f) - (-Polynomial.C e)*(Polynomial.X-Polynomial.C (1-b-d-f))*(-Polynomial.C e))
    - (-Polynomial.C a)*((-Polynomial.C a)*(Polynomial.X-Polynomial.C (1-b-d-f))*(Polynomial.X-Polynomial.C (1-c-e-f)) - (-Polynomial.C a)*(-Polynomial.C f)*(-Polynomial.C f) - (-Polynomial.C d)*(-Polynomial.C b)*(Polynomial.X-Polynomial.C (1-c-e-f)) + (-Polynomial.C d)*(-Polynomial.C f)*(-Polynomial.C c) + (-Polynomial.C e)*(-Polynomial.C b)*(-Polynomial.C f) - (-Polynomial.C e)*(Polynomial.X-Polynomial.C (1-b-d-f))*(-Polynomial.C c))
    + (-Polynomial.C b)*((-Polynomial.C a)*(-Polynomial.C d)*(Polynomial.X-Polynomial.C (1-c-e-f)) - (-Polynomial.C a)*(-Polynomial.C f)*(-Polynomial.C e) - (Polynomial.X-Polynomial.C (1-a-d-e))*(-Polynomial.C b)*(Polynomial.X-Polynomial.C (1-c-e-f)) + (Polynomial.X-Polynomial.C (1-a-d-e))*(-Polynomial.C f)*(-Polynomial.C c) + (-Polynomial.C e)*(-Polynomial.C b)*(-Polynomial.C e) - (-Polynomial.C e)*(-Polynomial.C d)*(-Polynomial.C c))
    - (-Polynomial.C c)*((-Polynomial.C a)*(-Polynomial.C d)*(-Polynomial.C f) - (-Polynomial.C a)*(Polynomial.X-Polynomial.C (1-b-d-f))*(-Polynomial.C e) - (Polynomial.X-Polynomial.C (1-a-d-e))*(-Polynomial.C b)*(-Polynomial.C f) + (Polynomial.X-Polynomial.C (1-a-d-e))*(Polynomial.X-Polynomial.C (1-b-d-f))*(-Polynomial.C c) + (-Polynomial.C d)*(-Polynomial.C b)*(-Polynomial.C e) - (-Polynomial.C d)*(-Polynomial.C d)*(-Polynomial.C c)) = _
  simp only [edgeSum,pairSum,treeSum,map_sub,map_add,map_mul,map_one,Polynomial.C_ofNat]
  ring

lemma model_trace (a b c d e f : ℝ) :
    Matrix.trace (model a b c d e f) = 4-2*edgeSum a b c d e f := by
  simp [Matrix.trace, model, Fin.sum_univ_succ, edgeSum]
  ring

lemma model_spectral_constraints (a b c d e f : ℝ)
    (h : (model a b c d e f).charpoly =
      Polynomial.X*(Polynomial.X-1)^2*(Polynomial.X+1)) :
    edgeSum a b c d e f = 3/2 ∧ pairSum a b c d e f = 2 ∧ treeSum a b c d e f = 0 := by
  have ht : Matrix.trace (model a b c d e f) = 1 := by
    rw [Matrix.trace_eq_neg_charpoly_coeff, h]
    have he : (Polynomial.X : Polynomial ℝ)*(Polynomial.X-1)^2*(Polynomial.X+1) =
        Polynomial.X^4-Polynomial.X^3-Polynomial.X^2+Polynomial.X := by ring
    rw [he]
    norm_num [Polynomial.coeff_X]
  rw [model_trace] at ht
  have hd := congrArg (fun p : Polynomial ℝ => p.derivative.eval 1) h
  rw [model_charpoly] at hd
  norm_num [Polynomial.derivative_pow] at hd
  have hz := congrArg (fun p : Polynomial ℝ => p.eval 0) h
  rw [model_charpoly] at hz
  norm_num at hz
  exact ⟨by linarith, by linarith, by linarith⟩

lemma stochastic_model (B : Matrix (Fin 4) (Fin 4) ℝ) (h : B ∈ stochasticSet 4) :
    B = model (B 0 1) (B 0 2) (B 0 3) (B 1 2) (B 1 3) (B 2 3) := by
  have hs : ∀ i j, B i j = B j i := fun i j => congrFun (congrFun h.1 j) i
  have hr := h.2.2
  have r0 := hr 0; have r1 := hr 1; have r2 := hr 2; have r3 := hr 3
  simp only [Fin.sum_univ_four] at r0 r1 r2 r3
  ext i j
  fin_cases i <;> fin_cases j <;> simp [model]
  all_goals first | exact hs _ _ | linarith [hs 1 0,hs 2 0,hs 2 1,hs 3 0,hs 3 1,hs 3 2]

#assert_trust kernel model_charpoly
#assert_trust kernel model_spectral_constraints
end NLA.IS02
