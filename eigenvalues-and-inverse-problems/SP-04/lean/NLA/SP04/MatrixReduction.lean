import NLA.SP04.Definitions

/-!
All-matrix stationary reduction for Matthew J. Colbrook's SP-04 argument.
Formalization: Sidney Holden with Codex assistance. We use the two transposed
stationary identities directly, avoiding an additional spectral decomposition.
-/
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical
namespace NLA.SP04

lemma feasible_isUnit {n : ℕ} {X : Mat n} (hX : Feasible X) : IsUnit X := by
  apply (Matrix.isUnit_iff_isUnit_det X).mpr
  apply isUnit_iff_ne_zero.mpr
  intro hz
  have h := hX
  simp [Feasible, hz] at h

lemma stationary_reverse {n : ℕ} {U X : Mat n} {c : ℝ}
    (hX : Stationary U X c) : (U-X) * X.transpose = c • (1 : Mat n) := by
  have hu : IsUnit X.transpose := by
    simpa only [Matrix.isUnit_transpose] using feasible_isUnit hX.1
  apply hu.mul_left_cancel
  rw [← Matrix.mul_assoc, hX.2]
  simp

lemma singularInterval_injective {s : Fin 3 → ℝ} (hs : SingularInterval s) :
    Function.Injective s := by
  have hm : StrictMono s := Fin.strictMono_iff_lt_succ.mpr (by
    intro i
    fin_cases i
    · exact hs.2.1
    · exact hs.2.2)
  exact hm.injective

theorem diagonal_stationary_reduction_proved (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (X : Mat 3) (c : ℝ) (hX : Stationary (Matrix.diagonal s) X c) :
    ∃ x : Fin 3 → ℝ, X = Matrix.diagonal x ∧
      |∏ i, x i| = 1 ∧ ∀ i, (x i)^2 - s i*x i + c = 0 := by
  let D : Mat 3 := Matrix.diagonal s
  have hleft : X.transpose * (D-X) = c • (1 : Mat 3) := hX.2
  have hright : (D-X) * X.transpose = c • (1 : Mat 3) := stationary_reverse hX
  have htleft := congrArg Matrix.transpose hleft
  have htright := congrArg Matrix.transpose hright
  simp only [Matrix.transpose_mul, Matrix.transpose_sub, Matrix.transpose_transpose,
    Matrix.transpose_smul, Matrix.transpose_one] at htleft htright
  have hD : D.transpose = D := Matrix.diagonal_transpose s
  rw [hD] at htleft htright
  have hsym1 : X.transpose * D = D * X := by
    have ha : X.transpose * D - X.transpose * X = c • (1 : Mat 3) := by
      simpa only [mul_sub] using hleft
    have hb : D * X - X.transpose * X = c • (1 : Mat 3) := by
      simpa only [sub_mul] using htleft
    exact sub_left_inj.mp (ha.trans hb.symm)
  have hsym2 : D * X.transpose = X * D := by
    have ha : D * X.transpose - X * X.transpose = c • (1 : Mat 3) := by
      simpa only [sub_mul] using hright
    have hb : X * D - X * X.transpose = c • (1 : Mat 3) := by
      simpa only [mul_sub] using htright
    exact sub_left_inj.mp (ha.trans hb.symm)
  have hoff : ∀ i j : Fin 3, i ≠ j → X i j = 0 := by
    intro i j hij
    have h1 := congrArg (fun A : Mat 3 => A i j) hsym1
    have h2 := congrArg (fun A : Mat 3 => A i j) hsym2
    simp only [D, Matrix.mul_diagonal, Matrix.diagonal_mul, Matrix.transpose_apply] at h1 h2
    have hne : s i ≠ s j := fun h => hij (singularInterval_injective hs h)
    have hsq : s i ^ 2 - s j ^ 2 ≠ 0 := by
      intro he
      have hi := (hs.1 i).1
      have hj := (hs.1 j).1
      apply hne
      nlinarith
    have he : (s i ^ 2 - s j ^ 2) * X i j = 0 := by
      have ha := congrArg (fun z : ℝ => s i * z) h1
      have hb := congrArg (fun z : ℝ => s j * z) h2
      nlinarith
    exact (mul_eq_zero.mp he).resolve_left hsq
  let x : Fin 3 → ℝ := fun i => X i i
  have hx : X = Matrix.diagonal x := by
    ext i j
    by_cases hij : i=j
    · subst j; simp [x]
    · simp [Matrix.diagonal, hij, hoff i j hij]
  refine ⟨x, hx, ?_, ?_⟩
  · have h := hX.1
    simpa [Feasible, hx, Matrix.det_diagonal] using h
  · intro i
    have h := congrArg (fun A : Mat 3 => A i i) hleft
    rw [hx] at h
    simp [D, Matrix.diagonal_transpose] at h
    nlinarith

end NLA.SP04
