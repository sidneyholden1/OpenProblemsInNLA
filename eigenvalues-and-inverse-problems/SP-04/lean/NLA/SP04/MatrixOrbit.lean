import NLA.SP04.Definitions

/- Orthogonal invariance for the full real stationary and feasible spaces in
Colbrook's SP-04 counterexample. Sidney Holden, with Codex assistance. -/
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical
namespace NLA.SP04

def orthogonalTransform (P Q X : Mat 3) : Mat 3 := P * X * Q.transpose

lemma orthogonal_transpose {P : Mat 3} (hP : Orthogonal P) : Orthogonal P.transpose := by
  simpa only [Orthogonal, Matrix.transpose_transpose] using And.intro hP.2 hP.1

lemma orthogonal_abs_det {P : Mat 3} (hP : Orthogonal P) : |P.det| = 1 := by
  have h := congrArg Matrix.det hP.1
  simp only [Matrix.det_mul, Matrix.det_transpose, Matrix.det_one] at h
  have hs : |P.det| ^ 2 = 1 := by rw [sq_abs]; nlinarith
  have hp := abs_nonneg P.det
  nlinarith

lemma orthogonalTransform_sub (P Q U X : Mat 3) :
    orthogonalTransform P Q (U-X) = orthogonalTransform P Q U - orthogonalTransform P Q X := by
  simp [orthogonalTransform, mul_sub, sub_mul]

lemma orthogonalTransform_inverse {P Q : Mat 3} (hP : Orthogonal P) (hQ : Orthogonal Q)
    (X : Mat 3) :
    orthogonalTransform P.transpose Q.transpose (orthogonalTransform P Q X) = X := by
  simp only [orthogonalTransform, Matrix.transpose_transpose]
  calc
    P.transpose * (P * X * Q.transpose) * Q = (P.transpose * P) * X * (Q.transpose * Q) := by
      simp only [Matrix.mul_assoc]
    _ = X := by rw [hP.1, hQ.1]; simp

lemma feasible_orthogonalTransform {P Q X : Mat 3} (hP : Orthogonal P) (hQ : Orthogonal Q)
    (hX : Feasible X) : Feasible (orthogonalTransform P Q X) := by
  simp only [Feasible, orthogonalTransform, Matrix.det_mul, Matrix.det_transpose, abs_mul]
  rw [orthogonal_abs_det hP, orthogonal_abs_det hQ]
  simpa [Feasible] using hX

lemma stationary_orthogonalTransform {P Q U X : Mat 3} {c : ℝ}
    (hP : Orthogonal P) (hQ : Orthogonal Q) (hX : Stationary U X c) :
    Stationary (orthogonalTransform P Q U) (orthogonalTransform P Q X) c := by
  refine ⟨feasible_orthogonalTransform hP hQ hX.1, ?_⟩
  rw [← orthogonalTransform_sub]
  calc
    (orthogonalTransform P Q X).transpose * orthogonalTransform P Q (U-X) =
        Q * (X.transpose * (P.transpose * P) * (U-X)) * Q.transpose := by
      simp only [orthogonalTransform, Matrix.transpose_mul, Matrix.transpose_transpose,
        Matrix.mul_assoc]
    _ = Q * (X.transpose * (U-X)) * Q.transpose := by rw [hP.1]; simp
    _ = c • (1 : Mat 3) := by rw [hX.2]; simp [hQ.2]

lemma distanceSq_trace (U X : Mat 3) :
    distanceSq U X = ((U-X).transpose * (U-X)).trace := by
  simp only [distanceSq, Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Matrix.sub_apply, pow_two]
  rw [Finset.sum_comm]

lemma distanceSq_orthogonalTransform {P Q : Mat 3} (hP : Orthogonal P) (hQ : Orthogonal Q)
    (U X : Mat 3) :
    distanceSq (orthogonalTransform P Q U) (orthogonalTransform P Q X) = distanceSq U X := by
  rw [distanceSq_trace, ← orthogonalTransform_sub, distanceSq_trace]
  have he : (orthogonalTransform P Q (U-X)).transpose * orthogonalTransform P Q (U-X) =
      Q * ((U-X).transpose * (U-X)) * Q.transpose := by
    calc
      _ = Q * ((U-X).transpose * (P.transpose * P) * (U-X)) * Q.transpose := by
        simp only [orthogonalTransform, Matrix.transpose_mul, Matrix.transpose_transpose,
          Matrix.mul_assoc]
      _ = _ := by rw [hP.1]; simp
  rw [he, Matrix.trace_mul_cycle, ← Matrix.mul_assoc, hQ.1, Matrix.one_mul]

lemma uniqueLeast_orthogonalTransform {P Q U X : Mat 3} {c : ℝ}
    (hP : Orthogonal P) (hQ : Orthogonal Q) (hX : UniqueLeast U X c) :
    UniqueLeast (orthogonalTransform P Q U) (orthogonalTransform P Q X) c := by
  refine ⟨stationary_orthogonalTransform hP hQ hX.1, ?_⟩
  intro Y d hY
  have hi := stationary_orthogonalTransform (orthogonal_transpose hP) (orthogonal_transpose hQ) hY
  rw [orthogonalTransform_inverse hP hQ] at hi
  obtain ⟨hcd, he⟩ := hX.2 _ d hi
  refine ⟨hcd, ?_⟩
  intro hd
  obtain ⟨hy, hdc⟩ := he hd
  refine ⟨?_, hdc⟩
  have hh := congrArg (orthogonalTransform P Q) hy
  have hc := orthogonalTransform_inverse (orthogonal_transpose hP) (orthogonal_transpose hQ) Y
  simp only [Matrix.transpose_transpose] at hc
  rwa [hc] at hh

lemma failure_orthogonalTransform {P Q U : Mat 3} (hP : Orthogonal P) (hQ : Orthogonal Q)
    (hU : Failure U) : Failure (orthogonalTransform P Q U) := by
  obtain ⟨X,c,hX,hn⟩ := hU
  refine ⟨orthogonalTransform P Q X,c,uniqueLeast_orthogonalTransform hP hQ hX,?_⟩
  intro hnear
  apply hn
  refine ⟨hX.1.1, ?_⟩
  intro Y hY
  have hh := hnear.2 (orthogonalTransform P Q Y) (feasible_orthogonalTransform hP hQ hY)
  simpa only [distanceSq_orthogonalTransform hP hQ] using hh

end NLA.SP04
