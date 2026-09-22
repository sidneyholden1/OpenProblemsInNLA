import NLA.SP04.MatrixOrbit

set_option backward.isDefEq.respectTransparency false
set_option maxHeartbeats 1200000
open scoped BigOperators Matrix.Norms.Operator Topology
open Filter NormedSpace
namespace NLA.SP04
noncomputable section

/-- Independent left and right skew coordinates, plus three diagonal coordinates. -/
def leftSkew : Mat 3 →ₗ[ℝ] Mat 3 where
  toFun X i j := if i < j then X i j else if j < i then -X j i else 0
  map_add' X Y := by
    funext i j
    simp only [Pi.add_apply, Matrix.add_apply]
    split_ifs <;> simp_all <;> ring
  map_smul' c X := by
    funext i j
    simp only [Pi.smul_apply, Matrix.smul_apply, smul_eq_mul, RingHom.id_apply]
    split_ifs <;> simp_all

def rightSkew : Mat 3 →ₗ[ℝ] Mat 3 where
  toFun X i j := if i < j then X j i else if j < i then -X i j else 0
  map_add' X Y := by
    funext i j
    simp only [Pi.add_apply, Matrix.add_apply]
    split_ifs <;> simp_all <;> ring
  map_smul' c X := by
    funext i j
    simp only [Pi.smul_apply, Matrix.smul_apply, smul_eq_mul, RingHom.id_apply]
    split_ifs <;> simp_all

def diagPart : Mat 3 →ₗ[ℝ] Mat 3 where
  toFun X := Matrix.diagonal (fun i => X i i)
  map_add' X Y := by ext i j; simp [Matrix.diagonal]; split_ifs <;> simp
  map_smul' c X := by ext i j; simp [Matrix.diagonal]

def localOrbit (s : Fin 3 → ℝ) (X : Mat 3) : Mat 3 :=
  exp (leftSkew X) * (Matrix.diagonal s + diagPart X) * exp (rightSkew X)

lemma leftSkew_transpose (X : Mat 3) : (leftSkew X).transpose = -leftSkew X := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [leftSkew, Matrix.transpose_apply]

lemma rightSkew_transpose (X : Mat 3) : (rightSkew X).transpose = -rightSkew X := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [rightSkew, Matrix.transpose_apply]

lemma orthogonal_exp_of_skew (A : Mat 3) (hA : A.transpose = -A) : Orthogonal (exp A) := by
  have h : exp A.transpose = exp (-A) := congrArg exp hA
  rw [Matrix.exp_transpose] at h
  constructor
  · rw [h, ← Matrix.exp_add_of_commute _ _ (Commute.neg_left (Commute.refl A)), neg_add_cancel, exp_zero]
  · rw [h, ← Matrix.exp_add_of_commute _ _ (Commute.neg_right (Commute.refl A)), add_neg_cancel, exp_zero]

@[simp] lemma localOrbit_zero (s : Fin 3 → ℝ) : localOrbit s 0 = Matrix.diagonal s := by
  simp [localOrbit]

def orbitDerivative (s : Fin 3 → ℝ) : Mat 3 →L[ℝ] Mat 3 :=
  (((ContinuousLinearMap.mul ℝ (Mat 3)).flip (Matrix.diagonal s)).comp leftSkew.toContinuousLinearMap +
    diagPart.toContinuousLinearMap) +
    (ContinuousLinearMap.mul ℝ (Mat 3) (Matrix.diagonal s)).comp rightSkew.toContinuousLinearMap

lemma orbitDerivative_apply (s : Fin 3 → ℝ) (X : Mat 3) :
    orbitDerivative s X = leftSkew X * Matrix.diagonal s + diagPart X +
      Matrix.diagonal s * rightSkew X := by rfl

lemma localOrbit_derivative (s : Fin 3 → ℝ) :
    HasStrictFDerivAt (localOrbit s) (orbitDerivative s) 0 := by
  have heL : HasStrictFDerivAt exp (1 : Mat 3 →L[ℝ] Mat 3) (leftSkew.toContinuousLinearMap 0) := by simpa using (hasStrictFDerivAt_exp_zero (𝕂 := ℝ) (𝔸 := Mat 3))
  have heR : HasStrictFDerivAt exp (1 : Mat 3 →L[ℝ] Mat 3) (rightSkew.toContinuousLinearMap 0) := by simpa using (hasStrictFDerivAt_exp_zero (𝕂 := ℝ) (𝔸 := Mat 3))
  have hL := heL.comp 0
    (leftSkew.toContinuousLinearMap.hasStrictFDerivAt)
  have hR := heR.comp 0
    (rightSkew.toContinuousLinearMap.hasStrictFDerivAt)
  have hD := (diagPart.toContinuousLinearMap.hasStrictFDerivAt (x := (0 : Mat 3))).const_add
    (Matrix.diagonal s)
  have H := (hL.mul' hD).mul' hR
  convert! H using 1
  ext X
  simp [orbitDerivative, add_comm, add_left_comm]

lemma orbitDerivative_injective (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    Function.Injective (orbitDerivative s) := by
  apply (orbitDerivative s).toLinearMap.ker_eq_bot.mp
  apply LinearMap.ker_eq_bot'.mpr
  intro X hX
  change orbitDerivative s X = 0 at hX
  have hp (i : Fin 3) : 0 < s i := lt_trans (by norm_num) (hs.1 i).1
  have hd01 : s 0 ^ 2 ≠ s 1 ^ 2 := by nlinarith [hp 0, hp 1, hs.2.1]
  have hd12 : s 1 ^ 2 ≠ s 2 ^ 2 := by nlinarith [hp 1, hp 2, hs.2.2]
  have hd02 : s 0 ^ 2 ≠ s 2 ^ 2 := by nlinarith [hp 0, hp 2, hs.2.1, hs.2.2]
  have he (i j : Fin 3) := congrFun (congrFun hX i) j
  simp only [orbitDerivative_apply, Matrix.add_apply, Matrix.mul_diagonal,
    Matrix.diagonal_mul, leftSkew, rightSkew, diagPart, LinearMap.coe_mk,
    AddHom.coe_mk, Matrix.diagonal_apply, Matrix.zero_apply] at he
  have h00 := he 0 0
  have h11 := he 1 1
  have h22 := he 2 2
  have h01 := he 0 1
  have h10 := he 1 0
  have h02 := he 0 2
  have h20 := he 2 0
  have h12 := he 1 2
  have h21 := he 2 1
  norm_num [Fin.lt_def, Fin.ext_iff] at h00 h11 h22 h01 h10 h02 h20 h12 h21
  have pair {a b x y : ℝ} (hd : a^2 ≠ b^2)
      (h1 : x*b+a*y=0) (h2 : -x*a-b*y=0) : x=0 ∧ y=0 := by
    have hxx : x * (a^2-b^2)=0 := by nlinarith [congrArg (fun z => z*b) h1, congrArg (fun z => z*a) h2]
    have hx : x=0 := (mul_eq_zero.mp hxx).resolve_right (sub_ne_zero.mpr hd)
    have hyy : y * (a^2-b^2)=0 := by nlinarith [congrArg (fun z => z*a) h1, congrArg (fun z => z*b) h2]
    exact ⟨hx, (mul_eq_zero.mp hyy).resolve_right (sub_ne_zero.mpr hd)⟩
  obtain ⟨h01,h10⟩ := pair hd01 h01 (by simpa [sub_eq_add_neg, neg_mul] using h10)
  obtain ⟨h02,h20⟩ := pair hd02 h02 (by simpa [sub_eq_add_neg, neg_mul] using h20)
  obtain ⟨h12,h21⟩ := pair hd12 h12 (by simpa [sub_eq_add_neg, neg_mul] using h21)
  ext i j
  fin_cases i <;> fin_cases j
  all_goals first | exact h00 | exact h01 | exact h02 | exact h10 | exact h11 | exact h12 | exact h20 | exact h21 | exact h22

lemma singularInterval_open : IsOpen {s : Fin 3 → ℝ | SingularInterval s} := by
  have h (i : Fin 3) : IsOpen {s : Fin 3 → ℝ | (7:ℝ)/4 < s i ∧ s i < (44:ℝ)/25} :=
    (isOpen_lt continuous_const (continuous_apply i)).inter
      (isOpen_lt (continuous_apply i) continuous_const)
  have h0 := isOpen_iInter_of_finite h
  have h1 : IsOpen {s : Fin 3 → ℝ | s 0 < s 1} := isOpen_lt (continuous_apply 0) (continuous_apply 1)
  have h2 : IsOpen {s : Fin 3 → ℝ | s 1 < s 2} := isOpen_lt (continuous_apply 1) (continuous_apply 2)
  convert h0.inter (h1.inter h2) using 1
  ext s
  simp [SingularInterval]

lemma localOrbit_mem_family (s : Fin 3 → ℝ) (X : Mat 3)
    (h : SingularInterval (fun i => s i + X i i)) : localOrbit s X ∈ counterexampleFamily := by
  refine ⟨exp (leftSkew X), (exp (rightSkew X)).transpose, (fun i => s i + X i i),
    orthogonal_exp_of_skew _ (leftSkew_transpose X),
    orthogonal_transpose (orthogonal_exp_of_skew _ (rightSkew_transpose X)), h, ?_⟩
  simp only [localOrbit, Matrix.transpose_transpose]
  congr 2
  exact Matrix.diagonal_add _ _

lemma diagonal_family_nhds (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    counterexampleFamily ∈ 𝓝 (Matrix.diagonal s) := by
  have hc : Continuous (fun X : Mat 3 => fun i => s i + X i i) := by fun_prop
  have hne : {X : Mat 3 | SingularInterval (fun i => s i + X i i)} ∈ 𝓝 0 :=
    (singularInterval_open.preimage hc).mem_nhds (by simpa using hs)
  have hsur : (orbitDerivative s).range = ⊤ :=
    LinearMap.range_eq_top.mpr (LinearMap.surjective_of_injective (orbitDerivative_injective s hs))
  have hm := (localOrbit_derivative s).map_nhds_eq_of_surj hsur
  rw [localOrbit_zero] at hm
  rw [← hm]
  change (localOrbit s ⁻¹' counterexampleFamily) ∈ 𝓝 0
  exact Filter.mem_of_superset hne (fun X hX => localOrbit_mem_family s X hX)

lemma orthogonal_mul {P Q : Mat 3} (hP : Orthogonal P) (hQ : Orthogonal Q) : Orthogonal (P*Q) := by
  constructor
  · calc
      (P*Q).transpose*(P*Q) = Q.transpose*(P.transpose*P)*Q := by simp [Matrix.transpose_mul, Matrix.mul_assoc]
      _ = 1 := by rw [hP.1]; simpa using hQ.1
  · calc
      (P*Q)*(P*Q).transpose = P*(Q*Q.transpose)*P.transpose := by simp [Matrix.transpose_mul, Matrix.mul_assoc]
      _ = 1 := by rw [hQ.2]; simpa using hP.2

lemma family_orthogonalTransform {P Q U : Mat 3} (hP : Orthogonal P) (hQ : Orthogonal Q)
    (hU : U ∈ counterexampleFamily) : orthogonalTransform P Q U ∈ counterexampleFamily := by
  obtain ⟨R,S,s,hR,hS,hs,rfl⟩ := hU
  refine ⟨P*R,Q*S,s,orthogonal_mul hP hR,orthogonal_mul hQ hS,hs,?_⟩
  simp [orthogonalTransform, Matrix.transpose_mul, Matrix.mul_assoc]

def orthogonalHomeomorph (P Q : Mat 3) (hP : Orthogonal P) (hQ : Orthogonal Q) :
    Mat 3 ≃ₜ Mat 3 where
  toFun := orthogonalTransform P Q
  invFun := orthogonalTransform P.transpose Q.transpose
  left_inv := orthogonalTransform_inverse hP hQ
  right_inv := by
    intro X
    simpa using orthogonalTransform_inverse (orthogonal_transpose hP) (orthogonal_transpose hQ) X
  continuous_toFun := by unfold orthogonalTransform; fun_prop
  continuous_invFun := by unfold orthogonalTransform; fun_prop

lemma open_counterexample_family_proved :
    counterexampleFamily.Nonempty ∧ IsOpen counterexampleFamily := by
  constructor
  · refine ⟨Matrix.diagonal (fun i => 1751/1000 + (i.val : ℝ)*4/1000 : Fin 3 → ℝ),
      1,1,(fun i => 1751/1000 + (i.val : ℝ)*4/1000 : Fin 3 → ℝ),⟨by simp,by simp⟩,⟨by simp,by simp⟩,?_,by simp⟩
    constructor
    · intro i; fin_cases i <;> norm_num
    · norm_num
  · apply isOpen_iff_mem_nhds.mpr
    intro U hU
    obtain ⟨P,Q,s,hP,hQ,hs,rfl⟩ := hU
    let e := orthogonalHomeomorph P Q hP hQ
    have h := e.isOpenMap
    have hn := diagonal_family_nhds s hs
    have him : e '' counterexampleFamily ∈ 𝓝 (e (Matrix.diagonal s)) :=
      e.isOpenMap.image_mem_nhds hn
    apply Filter.mem_of_superset him
    rintro X ⟨Y,hY,rfl⟩
    exact family_orthogonalTransform hP hQ hY

end
end NLA.SP04
